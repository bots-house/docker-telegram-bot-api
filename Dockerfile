FROM alpine:3.13.4 as builder

RUN apk --no-cache add \
    build-base \
    cmake \
    openssl-dev \
    zlib-dev \
    gperf \
    linux-headers

WORKDIR /usr/src/telegram-bot-api

COPY upstream/CMakeLists.txt .
COPY upstream/td ./td
COPY upstream/telegram-bot-api ./telegram-bot-api

WORKDIR /usr/src/telegram-bot-api/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. \
 && cmake --build . --target install -j "$(nproc)"\
 && strip /usr/src/telegram-bot-api/bin/telegram-bot-api

FROM alpine:3.13.4

RUN apk --no-cache --update add \
    libstdc++ \
    openssl

COPY --from=builder \
    /usr/src/telegram-bot-api/bin/telegram-bot-api \
    /usr/local/bin/telegram-bot-api

# 8081 - default bot api port 
# 8082 - default stats port 
EXPOSE 8081/tcp 8082/tcp

HEALTHCHECK \
    --interval=5s \
    --timeout=30s \
    --retries=3 \
    CMD nc -z localhost 8081 || exit 1

ENTRYPOINT ["/usr/local/bin/telegram-bot-api"]
