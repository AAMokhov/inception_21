#!/bin/bash

sleep 10

wp core install --path='/var/www/wordpress' --url=localhost --title="Inception" --admin_name=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
wp user create --path='/var/www/wordpress' ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=editor --allow-root

/usr/sbin/php-fpm7.3 -F
