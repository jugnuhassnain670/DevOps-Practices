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
    php-xml \
    unzip \
    git \
    curl  
# RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
#     apt-get install -y nodejs
RUN composer create-project --prefer-dist laravel/laravel jugnu-laravel-app
WORKDIR /var/www/html
COPY . /var/www/html
# RUN composer install --no-interaction
COPY ./nginx/nginx-site.conf /etc/nginx/sites-available/default
EXPOSE 80
CMD service php7.4-fpm start && nginx restart
CMD service php7.4-fpm start && nginx -g "daemon off;"
