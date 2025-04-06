# Używamy obrazu PHP z Apache
FROM php:7.4-apache

# Instalacja wymaganych rozszerzeń PHP (zip, gd, intl, itd.)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libzip-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd intl zip && \
    a2enmod rewrite

# Skopiowanie plików PrestaShop
COPY . /var/www/html/

# Ustawienie uprawnień do katalogów PrestaShop
RUN chown -R www-data:www-data /var/www/html/

# Zmiana katalogu roboczego
WORKDIR /var/www/html/

# Ustawienie dokumentu głównego
ENV APACHE_DOCUMENT_ROOT /var/www/html

# Exponowanie portu 80
EXPOSE 80

# Uruchomienie Apache w trybie przód
CMD ["apache2-foreground"]
