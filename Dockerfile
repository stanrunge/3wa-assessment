FROM composer:2.8 AS composer
FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libonig-dev \
    libicu-dev \
    libxslt-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libargon2-dev \
    zlib1g-dev \
    unzip \
    git \
    curl \
    libpq-dev \
    libedit-dev \
    libreadline-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    pkg-config \
    libsodium-dev \
    cron

RUN sed -i 's/^listen = .*/listen = 9000/' /usr/local/etc/php-fpm.d/www.conf

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install  \
    bcmath \
    ctype \
    curl \
    dom \
    fileinfo \
    filter \
    iconv \
    intl \
    mbstring \
    pdo_mysql \
    simplexml \
    soap \
    sockets \
    sodium \
    ftp \
    xmlwriter \
    zip \
    gd \
    xsl

RUN echo "memory_limit=2G" > /usr/local/etc/php/conf.d/memory-limit.ini

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
