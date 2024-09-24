# Utiliser l'image officielle de PHP
FROM php:8.3-fpm

# Installer les extensions nécessaires
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www

# Copier le contenu du projet Laravel
COPY . .

# Installer les dépendances de Laravel
RUN composer install

# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Exposer le port

EXPOSE 9000

# Commande pour démarrer le serveur
CMD ["php-fpm"]
