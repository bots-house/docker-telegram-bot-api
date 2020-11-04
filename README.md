# docker-telegram-bot-api ![CI](https://github.com/bots-house/docker-telegram-bot-api/workflows/CI/badge.svg)

It's just image and CI pipline for build [tdlib/telegram-bot-api](https://github.com/tdlib/telegram-bot-api). 

## Docker Compose

```yaml
version: '3.8'

volumes:
  server-data: 
    driver: local

services:
  server:
    image: ghcr.io/bots-house/docker-telegram-bot-api:latest
    environment: 
      # get this values from https://tdlib.github.io/telegram-bot-api/build.html
      TELEGRAM_API_ID: ?
      TELEGRAM_API_HASH: ?
    command: 
      # set working directory for files 
      - --dir=/var/lib/telegram-bot-api
      # enable logging, disable in production
      - --verbosity=2
    volumes: 
      # mount volume for persistance of files
      - server-data:/var/lib/telegram-bot-api
    ports:
      # access the API on 8081 port
      - 8081:8081
```

