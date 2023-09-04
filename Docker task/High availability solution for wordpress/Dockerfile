FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
#Install packages in ubuntu VM in container 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nginx \
    nano \
    curl \
    wget \
    tar
RUN apt install -y php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip 
WORKDIR /var/www/html
COPY ./nginx/default /etc/nginx/sites-enabled
RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm latest.tar.gz
RUN chown -R www-data:www-data /var/www/html

CMD ["sh", "-c", "service php8.1-fpm start & nginx -g 'daemon off;'"]
