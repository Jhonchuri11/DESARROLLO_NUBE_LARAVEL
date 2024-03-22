# Usar una imagen base de PHP con Apache
FROM php:8.2-apache

# Establece el directorio de trabajo en /var/www/html
WORKDIR /var/www/html

# Instala las dependencias necesarias para Laravel
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip

# Copia el código de tu aplicación Laravel al contenedor
COPY . /var/www/html

# Instala las dependencias de Composer
RUN curl -sS https://getcomposer.org/Composer-Setup.exe | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader

# Establece los permisos adecuados
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expone el puerto 80
EXPOSE 80

# Inicia Apache
CMD ["apache2-foreground"]