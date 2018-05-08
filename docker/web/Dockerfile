FROM php:7-apache

COPY ./php.ini /usr/local/etc/php/
COPY ./000-default.conf /etc/apache2/sites-available/
COPY ./apache2.conf /etc/apache2/
COPY ./config.json /root/.composer/

RUN usermod -u 1000 www-data

RUN a2enmod rewrite

#TODO: avoid update and software install
#RUN apt-get update
#RUN apt-get install -y\
#        libfreetype6-dev \
#        libjpeg62-turbo-dev \
#        #libpng12-dev \
#        libmcrypt-dev\
#        zlib1g-dev \
#    && docker-php-ext-install pdo_mysql zip \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#    && docker-php-ext-install -j$(nproc) gd

WORKDIR /var/www/html

# Entrypoint for post-build runtime script
#COPY ./entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["apache2-foreground"]