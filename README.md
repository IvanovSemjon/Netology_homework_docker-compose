# Django Stocks API - Docker

REST API сервер для управления складами и запасами товаров.

## Требования

- Docker
- Docker Compose (опционально)

## Быстрый старт

### 1. Сборка образа
```bash
docker build -t django-stocks-api .
```

### 2. Запуск миграций
```bash
docker run --rm --env-file .env django-stocks-api python manage.py migrate
```

### 3. Создание суперпользователя (опционально)
```bash
docker run -it --rm --env-file .env django-stocks-api python manage.py createsuperuser
```

### 4. Запуск сервера
```bash
# Запуск в фоновом режиме на порту 8001
docker run -d -p 8001:8000 --env-file .env --name django-api django-stocks-api

# Или запуск в интерактивном режиме
docker run -p 8001:8000 --env-file .env --name django-api django-stocks-api
```

## Управление контейнером

```bash
# Просмотр логов
docker logs django-api

# Остановка контейнера
docker stop django-api

# Удаление контейнера
docker rm django-api

# Перезапуск
docker restart django-api
```

## Тестирование API

После запуска API будет доступен по адресу: http://localhost:8001

### Основные эндпоинты:
- `GET /api/v1/products/` - список товаров
- `POST /api/v1/products/` - создание товара
- `GET /api/v1/stocks/` - список складов
- `POST /api/v1/stocks/` - создание склада

### Примеры запросов в файле:
`requests-examples.http`

## Переменные окружения

Основные переменные в файле `.env`:
- `SECRET_KEY` - секретный ключ Django
- `DEBUG` - режим отладки (True/False)
- `DB_ENGINE` - движок БД (sqlite3)
- `DB_NAME` - имя файла БД
- `ALLOWED_HOSTS` - разрешенные хосты