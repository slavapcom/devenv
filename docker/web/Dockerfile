FROM php:7-apache

COPY ./php.ini /usr/local/etc/php/
COPY ./000-default.conf /etc/apache2/sites-available/
COPY ./apache2.conf /etc/apache2/
COPY ./config.json /root/.composer/

RUN usermod -u 1000 www-data

RUN a2enmod rewrite

WORKDIR /var/www/html

# Entrypoint for post-build runtime script
#COPY ./entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["apache2-foreground"]