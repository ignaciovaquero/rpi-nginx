FROM resin/rpi-raspbian:stretch-20171108
MAINTAINER Ignacio Vaquero <i.vaqueroguisasola@gmail.com>

LABEL org.opencontainers.image.description="An nginx image for raspberry pi" \
      org.opencontainers.image.version="1.10.3"

RUN apt-get update && \
    apt-get install -y nginx=1.10.3-1+deb9u1 && \
    mkdir /certs

COPY tini-static /tini
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

ENV NGINX_SERVER_NAME=localhost \
    NGINX_PROXY_PASS_HOST=localhost \
    NGINX_PROXY_PASS_PORT=80 \
    NGINX_SERVER_C=ES \
    NGINX_SERVER_ST=Madrid \
    NGINX_SERVER_L=Madrid \
    NGINX_SERVER_O=Organization \
    NGINX_SERVER_OU=OrganizationUnit \
    NGINX_SERVER_EMAIL_ADDR=example@email.com \
    NGINX_ALT_NAME=localhost

EXPOSE 80 443

VOLUME /etc/nginx/conf.d

ENTRYPOINT ["/tini", "--"]
CMD ["/docker-entrypoint.sh"]
