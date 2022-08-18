FROM debian:buster

RUN	apt update && apt upgrade -y \
	&& apt install -y php7.3-fpm php-mysql mariadb-client tar wget curl\
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/

RUN	wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm -rf latest.tar.gz

COPY	tools/config.sh ./
COPY	conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY	conf/wp-config.php /var/www/wordpress/wp-config.php

RUN	ls /etc/php/7.3/fpm/pool.d/

RUN	mkdir -p /run/php && mkdir /var/log/php7.3-fpm

EXPOSE	9000

ENTRYPOINT sh config.sh
