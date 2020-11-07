# docker-telegram-bot-api ![CI](https://github.com/bots-house/docker-telegram-bot-api/workflows/CI/badge.svg)

It's just image and CI pipline for build [tdlib/telegram-bot-api](https://github.com/tdlib/telegram-bot-api). 

 - 🧙 no magic, contains only build stage with binary entrypoint; 
 - 🔄 trigger build when someone push to upstream repository (via [github-actions-upstream-watch](https://github.com/bots-house/github-actions-upstream-watch))

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
      # get this values from https://core.telegram.org/api/obtaining_api_id
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

## Usage 

You can configure it through the command line flags, here is the list of available ones:

```
Usage: telegram-bot-api --api_id=<arg> --api-hash=<arg> [--local] [OPTION]...

Telegram Bot API server. Options:
  -h, --help                          display this help text and exit
      --local                         allow the Bot API server to serve local requests
      --api-id=<arg>                  application identifier for Telegram API access, which can be obtained at https://my.telegram.org (defaults to the value of the TELEGRAM_API_ID environment variable)
      --api-hash=<arg>                application identifier hash for Telegram API access, which can be obtained at https://my.telegram.org (defaults to the value of the TELEGRAM_API_HASH environment variable)
  -p, --http-port=<arg>               HTTP listening port (default is 8081)
  -s, --http-stat-port=<arg>          HTTP statistics port
  -d, --dir=<arg>                     server working directory
  -t, --temp-dir=<arg>                directory for storing HTTP server temporary files
      --filter=<arg>                  "<remainder>/<modulo>". Allow only bots with 'bot_user_id % modulo == remainder'
      --max-webhook-connections=<arg> default value of the maximum webhook connections per bot
  -l, --log=<arg>                     path to the file where the log will be written
  -v, --verbosity=<arg>               log verbosity level
      --log-max-file-size=<arg>       maximum size of the log file in bytes before it will be auto-rotated (default is 2000000000)
  -u, --username=<arg>                effective user name to switch to
  -g, --groupname=<arg>               effective group name to switch to
  -c, --max-connections=<arg>         maximum number of open file descriptors
      --proxy=<arg>                   HTTP proxy server for outgoing webhook requests in the format http://host:port
```

## Show your support

Give a ⭐️ if this project helped you!