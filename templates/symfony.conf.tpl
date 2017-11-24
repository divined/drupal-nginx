upstream php {
    server {{ getenv "NGINX_BACKEND_HOST" }}:9000;
}

map $http_x_forwarded_proto $fastcgi_https {
    default $https;
    http '';
    https on;
}

server {
    server_name {{ getenv "NGINX_SERVER_NAME" "symfony" }};
    listen 80;

    root {{ getenv "NGINX_SERVER_ROOT" "/var/www/html/" }};
   
    include fastcgi.conf;

    location / {
        try_files $uri /index.php$is_args$args;
    }
    
    location ~ ^/index\.php(/|$) {
        fastcgi_pass php;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
        internal;
    }

    location ~ \.php$ {
        return 404;
    }
}
