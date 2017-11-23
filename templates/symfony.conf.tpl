upstream php {
    server {{ getenv "NGINX_BACKEND_HOST" }}:9000;
}

map $http_x_forwarded_proto $fastcgi_https {
    default $https;
    http '';
    https on;
}

server {
    server_name {{ getenv "NGINX_SERVER_NAME" "drupal" }};
    listen 80;

    root {{ getenv "NGINX_SERVER_ROOT" "/var/www/html/" }};
   
    include fastcgi.conf;

    location / {
        # try to serve file directly, fallback to app.php
        try_files $uri /app.php$is_args$args;
    }
    
    location ~ ^/(app_dev|config)\.php(/|$) {
        # fastcgi_pass unix:/var/run/php7.1-fpm.sock;
        # fastcgi_split_path_info ^(.+\.php)(/.*)$;
        fastcgi_pass php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
    }
    
    location ~ \.php$ {
        return 404;
    }
}
