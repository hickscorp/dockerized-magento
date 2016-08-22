FROM php:5.6-fpm

COPY files /usr/local

RUN set -x && \
    DEPS="curl git-core mysql-client netcat telnet vim wget zip libpng12-0 libjpeg62 libmcrypt4 libxml2 freetype*" && \
    BUILD_DEPS="libpng12-dev libjpeg-dev libmcrypt-dev libxml2-dev" && \
    apt-get update && \
    apt-get install -y --no-install-recommends $DEPS && \
    apt-get install -y --no-install-recommends $BUILD_DEPS && \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-freetype-dir && \
    docker-php-ext-install gd mbstring mysqli mcrypt mysql pdo_mysql soap zip  && \
    cd /tmp/ && git clone https://github.com/derickr/xdebug.git && \
    cd xdebug && \
    phpize && ./configure --enable-xdebug && make && \
    mkdir /usr/lib/php5/ && cp modules/xdebug.so /usr/lib/php5/xdebug.so && \
    touch /usr/local/etc/php/ext-xdebug.ini && \
    curl -o /usr/local/bin/magerun https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar && \
    chmod +x /usr/local/bin/magerun && \
    apt-get purge -y $BUILD_DEPS && apt-get autoremove -y --purge && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/www/html/* /tmp/xdebug
