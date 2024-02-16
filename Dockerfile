FROM php:8.1-fpm

RUN apt-get update && apt-get install -y curl

COPY . /app

WORKDIR /app

RUN composer install

RUN cp .env.example .env

RUN php artisan key:generate

RUN php artisan migrate

CMD ["php-fpm", "-F"]