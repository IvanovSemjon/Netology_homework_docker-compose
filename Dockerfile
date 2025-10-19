FROM python:3.11-alpine

# Создаем пользователя
RUN addgroup -g 1001 -S django && \
    adduser -S django -G django

RUN apk add --no-cache \
    gcc \
    musl-dev \
    linux-headers

WORKDIR /app

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chown -R django:django /app

USER django

EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "stocks_products.wsgi:application"]
