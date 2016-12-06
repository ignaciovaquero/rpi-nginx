FROM resin/rpi-raspbian:jessie-20161202
MAINTAINER Ignacio Vaquero <i.vaqueroguisasola@gmail.com>

LABEL org.label-schema.name="rpi-nginx" \
      org.label-schema.description="An nginx image for raspberry pi" \
      org.label-schema.vcs-url="https://github.com/igvaquero18/rpi-nginx" \
      org.label-schema.version="0.1.0" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.docker.cmd="docker run -d --name some-nginx -v /some/nginx.conf:/etc/nginx/conf.d/default.conf:ro -p 8080:80 -p 443:443 ivaquero/rpi-nginx:0.1.0"

ADD dumb-init_v1.2.0 /usr/bin/dumb-init

RUN apt-get update && \
    apt-get install -y nginx=1.6.2-5+deb8u4

EXPOSE 80 443

VOLUME /etc/nginx/conf.d

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["nginx", "-g", "daemon off;"]
