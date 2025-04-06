# Użycie obrazu PHP z Apache
FROM php:7.4-apache

# Instalacja wymaganych zależności PHP
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libzip-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd intl zip && \
    a2enmod rewrite

# Skopiowanie plików PrestaShop z repozytorium do kontenera
COPY . /var/www/html/

# Ustawienie odpowiednich uprawnień
RUN chown -R www-data:www-data /var/www/html/

# Konfiguracja katalogu roboczego
WORKDIR /var/www/html/

# Wskazanie głównego katalogu dokumentów
ENV APACHE_DOCUMENT_ROOT /var/www/html

# Ekspozycja portu 80
EXPOSE 80

# Uruchomienie Apache w trybie foreground
CMD ["apache2-foreground"]
