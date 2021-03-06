FROM golang:1.11.1-alpine3.8 AS builder

ARG APP_ENV

ENV APP_ENV $APP_ENV

COPY . /go/src/echoteas-api/src/api/

WORKDIR /go/src/echoteas-api/src/api/

RUN apk update \
  && apk add --no-cache git \
  && go get -u github.com/golang/dep/cmd/dep \
  && dep ensure --vendor-only \
  && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:3.8

ARG APP_ENV

ENV APP_ENV $APP_ENV
ENV GIN_MODE release

RUN apk update \
  && apk add ca-certificates \
  && rm -rf /var/cache/apk/*

WORKDIR /app

COPY --from=builder /go/src/echoteas-api/src/api/config/*.yaml /app/config/
COPY --from=builder /go/src/echoteas-api/src/api/assets/ /app/assets/
COPY --from=builder /go/src/echoteas-api/src/api/robots.txt /app/robots.txt
COPY --from=builder /go/src/echoteas-api/src/api/main /app/main

RUN chown nobody:nogroup /app

USER nobody

ENTRYPOINT /app/main
