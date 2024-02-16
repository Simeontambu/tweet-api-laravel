FROM php:8.1-fpm

# RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y php
RUN echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> /etc/profile

COPY . /app

WORKDIR /app

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer-1.0.0-installer.php composer
RUN chmod +x composer
RUN composer install


RUN cp .env.example .env

RUN php artisan key:generate

RUN php artisan migrate
RUN php artisan serve

CMD ["php-fpm", "-F"]

RUN apt-get update && apt-get install -y mysql-server

ENV MYSQL_DATABASE my_database
ENV MYSQL_USER my_user
ENV MYSQL_PASSWORD my_password

RUN mysql -u root -p"" <<EOF
CREATE DATABASE $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF