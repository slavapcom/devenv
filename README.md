devenv
======
Drop-in solution allowing to quickly start a new project

**Not for production**

Installation
------------
- copy & paste into your project
- customize software configs:
    - `ServerName` in web/000-default.conf
    - db root password and db name in docker-compose.yml
    - if necessary, add initial db dump to db/dump
- optional: packages installation `composer install` and/or `npm i`
- `docker-compose up`

TODOs
-----
[] fix web/entrypoint.sh
[] make mysql data directory shareable with the host
[] add configuration for nginx and php-fpm
[] add mongo
[] add more useful stuff: gitattributes, editorconfig, etc