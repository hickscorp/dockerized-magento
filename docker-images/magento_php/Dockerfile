FROM php:5.6-fpm
MAINTAINER Pierre Martin <HicksCorp@GMail.com>

COPY files /usr/local

RUN set -ex &&\
  DEPS="curl git-core mysql-client netcat telnet vim wget zip libfreetype6 libpng12-0 libjpeg62 libjpeg62-turbo libmcrypt4 libxml2 sendmail freetype*" &&\
  BUILD_DEPS="libfreetype6-dev libpng12-dev libjpeg-dev libmcrypt-dev libxml2-dev zlib1g-dev" &&\
  apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS $DEPS &&\
  docker-php-ext-configure gd --enable-gd-native-ttf \
                              --with-jpeg-dir=/usr/lib/x86_64-linux-gnu \
                              --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu &&\
  docker-php-ext-install gd \
                         mbstring \
                         mysqli \
                         mcrypt \
                         mysql \
                         pdo_mysql \
                         soap \
                         zip &&\
  curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer &&\
  chmod +x /usr/local/bin/composer &&\
  apt-get purge -y $BUILD_DEPS && apt-get autoremove -y --purge &&\
  apt-get clean && rm -rf /var/lib/apt/lists/* /var/www/html/*

WORKDIR /var/www
