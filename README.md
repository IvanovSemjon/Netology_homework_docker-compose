# Django Stocks API - Docker Compose

REST API для управления складами и запасами товаров с использованием Docker Compose.

## Архитектура

- **Backend**: Django + Gunicorn + DRF
- **Database**: SQLite (по умолчанию) / PostgreSQL 15
- **Proxy**: Nginx
- **Network**: Изолированная Docker сеть

## Быстрый запуск

### 1. Запуск всех сервисов
```bash
docker-compose up --build -d
```

### 2. Выполнение миграций
```bash
docker-compose exec backend python manage.py migrate
```

### 3. Создание суперпользователя (опционально)
```bash
docker-compose exec backend python manage.py createsuperuser
```

## Доступ к приложению

- **API**: http://localhost:8080/api/v1/
- **Admin**: http://localhost:8080/admin/
- **Health Check**: http://localhost:8080/health/

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

### Товары
- `GET /api/v1/products/` - список товаров
- `POST /api/v1/products/` - создание товара
- `GET /api/v1/products/{id}/` - получение товара
- `PUT /api/v1/products/{id}/` - обновление товара
- `DELETE /api/v1/products/{id}/` - удаление товара

### Склады
- `GET /api/v1/stocks/` - список складов
- `POST /api/v1/stocks/` - создание склада
- `GET /api/v1/stocks/{id}/` - получение склада
- `PUT /api/v1/stocks/{id}/` - обновление склада
- `DELETE /api/v1/stocks/{id}/` - удаление склада

## Примеры API запросов

```bash
# Создание товара
curl -X POST http://localhost:8080/api/v1/products/ \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Product", "description": "Test Description"}'

# Создание склада
curl -X POST http://localhost:8080/api/v1/stocks/ \
  -H "Content-Type: application/json" \
  -d '{"address": "Test Address", "positions": []}'
```

## Security Features

- Non-root пользователи в контейнерах
- Read-only файловые системы
- Security headers в Nginx
- Rate limiting
- Изолированная сеть
- Health checks
- CORS настройки

## Структура проекта

```
├── docker-compose.yml    # Конфигурация сервисов
├── Dockerfile           # Образ Django приложения
├── nginx.conf          # Конфигурация Nginx
├── .env.example        # Пример переменных окружения
├── requirements.txt    # Python зависимости
└── logistic/           # Django приложение
    ├── models.py       # Модели данных
    ├── serializers.py  # DRF сериализаторы
    └── views.py        # API представления
```

## Переключение на PostgreSQL

Для использования PostgreSQL вместо SQLite:

1. Раскомментируйте DATABASE_URL в docker-compose.yml
2. Перезапустите сервисы: `docker-compose up -d`
3. Выполните миграции: `docker-compose exec backend python manage.py migrate`