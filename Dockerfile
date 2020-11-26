FROM php:7.3-fpm

ARG user
ARG uid

COPY composer.json /var/www/

WORKDIR /var/www

RUN apt-get update --fix-missing && apt-get install -y \
    git \
    curl \
    nano \
    libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev \
    iputils-ping \
    zip unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd
RUN docker-php-ext-install mbstring exif pcntl pdo pdo_mysql mysqli

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

USER $user

EXPOSE 9000

CMD ["php-fpm"]
