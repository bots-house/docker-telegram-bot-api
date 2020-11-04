FROM alpine:3.12.1 as builder

RUN apk --no-cache add \
    build-base \
    git cmake \
    openssl-dev \
    zlib-dev \
    gperf \
    linux-headers

RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git /src

WORKDIR /src/build

RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cmake --build . --target install -- -j 4

FROM alpine:3.12.1

RUN apk --no-cache add libstdc++

COPY --from=builder /usr/local/bin/telegram-bot-api /usr/local/bin/telegram-bot-api

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/telegram-bot-api"]
