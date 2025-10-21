FROM python:3.11-slim-bookworm

# Security: Update packages and install only necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Security: Create non-root user with minimal privileges
RUN groupadd -r app && useradd -r -g app -d /app -s /sbin/nologin app

WORKDIR /app

# Security: Copy and install requirements first (better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip==23.3.1 && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Security: Set proper ownership and permissions
RUN chown -R app:app /app && \
    chmod -R 755 /app && \
    mkdir -p /app/staticfiles && \
    chown app:app /app/staticfiles

# Security: Switch to non-root user
USER app

# Security: Use non-privileged port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python manage.py check --deploy || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "--timeout", "120", "--max-requests", "1000", "stocks_products.wsgi:application"]