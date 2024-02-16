FROM php:8.1-fpm

# Consider alternative package manager or individual installations if needed
# RUN apt-get update && apt-get install -y curl php-mysql

# Copy application files
COPY . /app

WORKDIR /app

# Use the correct downloaded file name (likely `composer.phar`)
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar composer
RUN chmod +x composer

# Install dependencies (consider using composer)
RUN composer install

# Create and configure environment variables (securely)
COPY .env.example .env
# Use Render's secrets management or env variables for credentials
RUN echo "MYSQL_HOST=your_mysql_host" >> .env
RUN echo "MYSQL_PORT=your_mysql_port" >> .env

# Generate app key and migrate database
RUN php artisan key:generate
RUN php artisan migrate

# Start PHP-FPM in the foreground for easier troubleshooting (optional)
CMD ["php-fpm", "-F"]

# Install and configure MySQL (securely)
# Consider alternative MySQL setup or containerized approach
# RUN apt-get update && apt-get install -y mysql-server

# Set MySQL credentials securely (avoid storing in Dockerfile)
ENV MYSQL_USER="your_mysql_user"
ENV MYSQL_PASSWORD="your_mysql_password"

# Create database and grant privileges (securely)
# Consider alternative approach if not using Render's MySQL
# RUN mysql -u $MYSQL_USER -p"$MYSQL_PASSWORD" <<EOF
# CREATE DATABASE IF NOT EXISTS my_database;
# GRANT ALL PRIVILEGES ON my_database.* TO $MYSQL_USER@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
# EOF