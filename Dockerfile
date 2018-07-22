FROM node:alpine
LABEL maintainer="https://github.com/ilex0208/amosns-docker"

RUN apk update && apk upgrade && apk add git && adduser -D -S -s /bin/sh -h /amosns amosns && rm -rf /var/cache/apk/*

RUN git clone --depth 1 https://github.com/ilex0208/amosns-docker.git /amosns/registry

ADD config.yaml /amosns/registry/config.yaml

WORKDIR /amosns/registry

RUN npm install --production && npm cache clean

USER amosns

VOLUME /amosns/storage

EXPOSE 9696

CMD ["./bin/amosns"]
