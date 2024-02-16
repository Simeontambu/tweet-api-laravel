# Utilisez une image de base avec PHP et Apache
FROM php:8.1-apache

# Définissez le répertoire de travail dans le conteneur
WORKDIR /var/www/html

# Copiez les fichiers de votre application dans le conteneur
COPY . .

RUN sed -i 's/deb.debian.org/debian.mirror.constant.com/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/debian.mirror.constant.com/g' /etc/apt/sources.list
# Installez les dépendances de l'application avec Composer
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-interaction --no-dev --prefer-dist

# Définissez les variables d'environnement pour Laravel
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
ENV APACHE_LOG_DIR=/var/log/apache2

# Activez le module Apache mod_rewrite
RUN a2enmod rewrite

# Définissez les autorisations appropriées pour les fichiers Laravel
RUN chown -R www-data:www-data storage bootstrap/cache

# Exposez le port 80 pour accéder à l'application
EXPOSE 80

# Démarrez le serveur Apache
CMD ["apache2-foreground"]