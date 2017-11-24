ARG FROM_TAG

FROM wodby/php-nginx:${FROM_TAG}

USER root

RUN rm /etc/gotpl/default-vhost.conf.tpl && \
    mkdir -p /usr/local/bin && \
    curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && \
    chmod a+x /usr/local/bin/symfony
    
USER www-data

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/
