###########################################################################
# PHP-FPM Version Of Alpine:
###########################################################################

FROM php:7.4-fpm-alpine

LABEL maintainer="YanlongMa <json_vip@163.com>"


###########################################################################
# Alpine Aliyun Mirrors:
###########################################################################

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories


###########################################################################
# System Extensions:
###########################################################################

RUN apk --update add \
        autoconf \
        build-base \
        linux-headers \
        libaio-dev \
        zlib-dev \
        curl \
        git \
        freetype-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libtool \
        libbz2 \
        bzip2 \
        bzip2-dev \
        libstdc++ \
        libxslt-dev \
        openldap-dev \
        imagemagick-dev \
        libzip-dev \
        make \
        zip \
        unzip \
        wget \
        libmemcached-dev \
        gcc \
        libffi-dev \
        openssl-dev \
        libtool\
        libevent-dev

#docker alpine php iconv 扩展失效 解决
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

###########################################################################
# PHP Core Extensions:
###########################################################################

# Core Extensions For Default Installation:
RUN docker-php-ext-install \
        bcmath \
        pdo_mysql \
        mysqli \
        sockets \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd


# Core Extensions pcntl:
RUN docker-php-ext-install pcntl

# Core Extensions opcache:
RUN docker-php-ext-install opcache

# Core Extensions zip:
RUN docker-php-ext-configure zip --with-libzip \
            && docker-php-ext-install zip

###########################################################################
# PHP PECL Extensions:
###########################################################################

# PECL Extensions event:
RUN pecl install event \
        && rm -rf /tmp/pear \
        &&  docker-php-ext-enable --ini-name zz-event.ini event \

# PECL Extensions reids:
RUN pecl install redis-5.3.6 \
        && rm -rf /tmp/pear \
        && docker-php-ext-enable redis


# PECL Extensions mongodb:
RUN pecl install mongodb-1.5.4 \
        && rm -rf /tmp/pear \
        && docker-php-ext-enable mongodb


# PECL Extensions memcached:
RUN  pecl install memcached-3.1.2 \
       && rm -rf /tmp/pear \
       && docker-php-ext-enable memcached


# PECL Extensions swoole:
RUN  pecl install swoole-4.2.13 \
        && rm -rf /tmp/pear \
        && docker-php-ext-enable swoole


###########################################################################
# PHP Thrid Extensions:
###########################################################################

# Thrid Extensions Xunsearch:
#RUN curl 'http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2' -o scws.tar.bz2 \
#    && tar xvjf scws.tar.bz2 \
#    && cd scws-1.2.3 \
#    && ./configure --prefix=/usr/local/scws \
#    && make \
#    && make install \
#    && cd phpext \
#    && phpize \
#    && ./configure --with-scws=/usr/local/scws \
#    && make \
#    && make install \
#    && cd ../../ \
#    && rm -rf scws scws-1.2.3.tar.bz2 \
#    && docker-php-ext-enable scws \
#    && echo "scws.default.charset = utf8" >> /usr/local/etc/php/conf.d/docker-php-ext-scws.ini \
#    && echo "scws.default.fpath = /usr/local/scws/etc" >> /usr/local/etc/php/conf.d/docker-php-ext-scws.ini


# Composer:
RUN curl -sS http://getcomposer.org/installer | php \
        && mv ./composer.phar /usr/local/bin/composer \
        && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer \

RUN apk del build-base \
    	linux-headers \
    	libaio-dev \
    && rm -rf /var/cache/apk/*


VOLUME /var/www
WORKDIR /var/www


EXPOSE 9000
CMD ["php-fpm"]