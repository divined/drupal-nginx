ARG FROM_TAG

FROM wodby/php-nginx:${FROM_TAG}

ARG DRUPAL_VER

USER root

RUN apt-get update && apt-get install -y dos2unix && \
    rm /etc/gotpl/default-vhost.conf.tpl

USER www-data

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/

RUN dos2unix /etc/gotpl/* && dos2unix /docker-entrypoint-init.d/* && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
