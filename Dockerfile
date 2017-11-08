FROM resin/rpi-raspbian:stretch-20171108
MAINTAINER Ignacio Vaquero <i.vaqueroguisasola@gmail.com>

LABEL org.opencontainers.image.description="An nginx image for raspberry pi" \
      org.opencontainers.image.version="1.10.3"

COPY /tini-static /tini

RUN apt-get update && \
    apt-get install -y nginx=1.10.3-1+deb9u1 && \
    mkdir /certs

EXPOSE 80 443

VOLUME /etc/nginx/conf.d
VOLUME /certs

ENTRYPOINT ["/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
