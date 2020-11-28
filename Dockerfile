FROM php:7.4-fpm

COPY composer.json /var/www/

WORKDIR /var/www

RUN apt-get update --fix-missing && apt-get install -y \
    git curl nano iputils-ping zip unzip \
    libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

RUN docker-php-ext-install mbstring exif pcntl pdo pdo_mysql mysqli

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www

RUN adduser www-data root

EXPOSE 9000

CMD ["php-fpm"]
