FROM node:alpine
LABEL maintainer="https://github.com/ilex0208/amosns-docker"

RUN adduser --disabled-password --gecos "" amosns && \
    mkdir -p /opt/amosns/storage

WORKDIR /opt/amosns

RUN npm install js-yaml amosns && \
    chown -R amosns:amosns /opt/amosns

USER amosns

ADD /config.yaml /tmp/config.yaml
ADD /start.sh /opt/amosns/start.sh

CMD ["/opt/amosns/start.sh"]

EXPOSE 9696
VOLUME /opt/amosns
