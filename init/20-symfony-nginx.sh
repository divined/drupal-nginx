#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

gotpl "/etc/gotpl/symfony.conf.tpl" > /etc/nginx/conf.d/symfony.conf
