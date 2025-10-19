## Запуск в фоновом режиме

```bash
# Сборка образа
docker build -t django-stocks-api .

# Запуск в фоновом режиме на порту 8001
docker run -d -p 8001:8000 --env-file .env --name django-api django-stocks-api

# Просмотр логов
docker logs django-api

# Остановка контейнера
docker stop django-api