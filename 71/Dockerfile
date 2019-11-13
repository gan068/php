FROM php:7.1.33-fpm-alpine3.10

ENV PHPIZE_DEPS \
        autoconf \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c

ENV TZ=Asia/Taipei

RUN \
    apk update ; \
    apk add \
            freetype-dev \
            libpng \
            libjpeg \
            libmcrypt \
            libxml2 \
            openldap-dev \
            imagemagick \
            poppler-utils \
            pcre \
            gmp \
            ; \
    apk add --virtual .build-deps \
            $PHPIZE_DEPS \
            libpng-dev \
            libjpeg-turbo-dev \
            libmcrypt-dev \
            imagemagick-dev \
            libtool \
            libxml2-dev \
            pcre-dev \
            gmp-dev \
            ; \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/local --with-png-dir=/usr/local --with-freetype-dir=/usr/local ; \
    docker-php-ext-install gd ; \
    docker-php-ext-install \
            exif \
            ldap \
            bcmath \
            mbstring \
            mcrypt \
            opcache \
            pdo_mysql \
            soap \
            zip \
            gmp \
            ; \
    pecl install \
            redis \
            imagick \
            msgpack \
            igbinary \
            ; \
    docker-php-ext-enable \
            exif \
            gd \
            igbinary \
            imagick \
            ldap \
            bcmath \
            mbstring \
            mcrypt \
            msgpack \
            opcache \
            pdo_mysql \
            redis \
            soap \
            zip \
            gmp \
            ; \
    apk del .build-deps ; \
    docker-php-source delete ; \
    echo 'session.serialize_handler=igbinary' >> /usr/local/etc/php/conf.d/docker-php-ext-igbinary.ini ; \
    addgroup --gid 498 nginx \
    && adduser --uid 498 -D nginx -G nginx \
    && mkdir -p /var/log/php-fpm \
    && chown -R nginx:nginx /var/log/php-fpm \
    && rm -rf /usr/local/etc/php.ini /usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.d/* \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk del tzdata \
    && rm -rf /tmp/pear

COPY php.ini /usr/local/etc/php/php.ini
COPY php-fpm.conf /usr/local/etc/php-fpm.conf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000/tcp

CMD ["php-fpm","--nodaemonize"]
