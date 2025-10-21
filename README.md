# Django Stocks API - Docker Compose

REST API для управления складами и запасами товаров с использованием Docker Compose.

## Архитектура

- **Backend**: Django + Gunicorn
- **Database**: PostgreSQL 15
- **Proxy**: Nginx
- **Network**: Изолированная Docker сеть

## Быстрый запуск

### 1. Подготовка окружения
```bash
# Скопировать и настроить переменные окружения
cp .env.example .env
# Изменить SECRET_KEY и DB_PASSWORD в .env
```

### 2. Запуск всех сервисов
```bash
docker-compose up --build -d
```

### 3. Создание суперпользователя
```bash
docker-compose exec backend python manage.py createsuperuser
```

## Доступ к приложению

- **API**: http://localhost/api/v1/
- **Admin**: http://localhost/admin/
- **Health Check**: http://localhost/health/

## Основные команды

```bash
# Просмотр логов
docker-compose logs -f

# Остановка
docker-compose down

# Перезапуск
docker-compose restart

# Выполнение команд Django
docker-compose exec backend python manage.py <command>
```

## API Endpoints

- `GET /api/v1/products/` - список товаров
- `POST /api/v1/products/` - создание товара
- `GET /api/v1/stocks/` - список складов
- `POST /api/v1/stocks/` - создание склада

## Security Features

- Non-root пользователи в контейнерах
- Read-only файловые системы
- Security headers в Nginx
- Rate limiting
- Изолированная сеть
- Health checks

## Структура проекта

```
├── docker-compose.yml    # Конфигурация сервисов
├── Dockerfile           # Образ Django приложения
├── nginx.conf          # Конфигурация Nginx
├── .env.example        # Пример переменных окружения
└── requirements.txt    # Python зависимости
```