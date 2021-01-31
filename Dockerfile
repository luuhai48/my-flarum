FROM php:7.4-fpm

ARG user
ARG uid

RUN apt-get update --fix-missing && apt-get install -y \
    git curl nano iputils-ping zip unzip \
    libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

RUN docker-php-ext-install mbstring exif pcntl pdo pdo_mysql mysqli opcache

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -G www-data,root -u $uid -d /home/$user $user

RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

WORKDIR /var/www

USER $user

EXPOSE 9000

CMD ["php-fpm"]
