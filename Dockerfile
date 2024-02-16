FROM php:8.1-fpm

# Install essentials and Composer
RUN apt-get update && apt-get install -y curl php-mysql

# Copy application files
COPY . /app

WORKDIR /app

# Use the correct downloaded file name (likely `composer.phar`)
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar composer
RUN chmod +x composer

# Install dependencies
RUN composer install

# Create and configure environment variables
COPY .env.example .env
RUN echo "MYSQL_HOST=localhost" >> .env
RUN echo "MYSQL_PORT=3306" >> .env

# Generate app key and migrate database
RUN php artisan key:generate
RUN php artisan migrate

# Start PHP-FPM in the foreground for easier troubleshooting (optional)
CMD ["php-fpm", "-F"]

# Install and configure MySQL (ensure security during setup)
RUN apt-get update && apt-get install -y mysql-server

# Set MySQL credentials in a secure way (use secrets management or environment variables)
ENV MYSQL_USER="your_mysql_user"
ENV MYSQL_PASSWORD="your_mysql_password"

# Create database and grant privileges (use placeholders for actual values)
RUN mysql -u $MYSQL_USER -p"$MYSQL_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS my_database;
GRANT ALL PRIVILEGES ON my_database.* TO $MYSQL_USER@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF