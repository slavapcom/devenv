#!/bin/bash

#
# ONLY RAW IDEA, TOTALLY INCOMPLETE
# Problem: most of these installation steps should be performed outside of container
#

DB_ROOT_PASS=123
DB_HOST=mysql
DB_NAME='main'
ADMIN_ACC_USERNAME=admin
ADMIN_ACC_PASSWORD=123
SITE_NAME='DEV.websitename'

# Download composer
if [ ! -f ./composer.phar ]; then
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
fi

# Install/verify dependencies
php composer.phar install -n --prefer-dist

cd ./web

# Check if drupal is already installed
php -r "if ((new PDO('mysql:dbname=main;host=mysql', 'root', '123'))->prepare('SELECT * FROM users')->execute()) { exit(0); } else { exit(1); }" 2>/dev/null
isinstalled=$?

if [ "$isinstalled"  -eq "0" ]; then

    printf "Drupal already installed \n"

else

    #TODO: envision the case when db setup failed; need to abort installation process
    until mysql -uroot -p123 -hmysql -e "SHOW DATABASES;"; do
      >&2 echo "Waiting for db to be up and running ......"
      sleep 2
    done

    printf "\n*********************\n Installing website... \n*********************\n"

    chmod -R 777 .

    #../vendor/bin/drush si custom --db-url=mysqli://root:$DB_ROOT_PASS@$DB_HOST/$DB_NAME --account-name=$ADMIN_ACC_USERNAME --account-pass=$ADMIN_ACC_PASSWORD --site-name=$SITE_NAME -y
    #../vendor/bin/drush en general -y
    #../vendor/bin/drush en development -y

    # Install some content if db dump is present
    if [ ! -f ../docker/dump/content.mysql.gz ]; then
        ../vendor/bin/drush bam-restore db manual ./docker/dump/content.mysql.gz -y
    fi

    printf "\n*********************\n Website installed \n*********************\n"

fi

# Revert features to actualize configuration
#../vendor/bin/drush fr development -y
#../vendor/bin/drush fr general -y
#../vendor/bin/drush cc all
