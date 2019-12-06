FROM tarampampam/nginx:stable-alpine
LABEL Description="%%app_name%% application" Vendor="dev@avtocod.ru"

COPY ./docker/default.conf /etc/nginx/conf.d/default.conf
COPY ./build /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
VOLUME ["/usr/share/nginx/html"]
