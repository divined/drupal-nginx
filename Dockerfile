ARG FROM_TAG

FROM wodby/php-nginx:${FROM_TAG}

ARG DRUPAL_VER

USER root

RUN apk add dos2unix --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    rm /etc/gotpl/default-vhost.conf.tpl

USER www-data

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/

RUN sudo dos2unix /etc/gotpl/* && sudo dos2unix /docker-entrypoint-init.d/* && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
