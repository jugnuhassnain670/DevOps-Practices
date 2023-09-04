FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nginx \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-cli \
    composer \
    php-xml 
WORKDIR /var/www/html
RUN cd /var/www/html
RUN chmod 777 -R /var
RUN composer create-project laravel/laravel jugnu-laravel-app --ignore-platform-req=ext-curl
COPY ./nginx/nginx-site.conf /etc/nginx/sites-enabled/default
EXPOSE 80
CMD service php8.1-fpm start && nginx -g "daemon off;"
