FROM php:8.1-fpm

RUN apt-get update && apt-get install -y curl

COPY . /app

WORKDIR /app

RUN curl -sS https://getcomposer.org/installer | php
RUN mv installer.php composer
RUN chmod +x composer
RUN composer install

RUN cp .env.example .env

RUN php artisan key:generate

RUN php artisan migrate

CMD ["php-fpm", "-F"]

RUN apt-get update && apt-get install -y mysql-server

ENV MYSQL_DATABASE my_database
ENV MYSQL_USER my_user
ENV MYSQL_PASSWORD my_password

RUN mysql -u root -p"" <<EOF
CREATE DATABASE $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF