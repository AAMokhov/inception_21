FROM debian:buster

RUN	apt update && apt upgrade -y \
	&& apt install -y nginx openssl \
	&& mkdir -p /run/nginx \
	&& mkdir /etc/nginx/ssl

RUN	chown -R www-data:www-data /var/www/ && chmod 755 /var/www/

COPY	conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY	conf/nginx.conf /etc/nginx/sites-available/dtentaco.42.fr
COPY	conf/nginx.conf /etc/nginx/sites-enable/dtentaco.42.fr

RUN	openssl req -x509 -nodes -days 1 -newkey rsa:2048 \
	-subj "/C=RU/ST=Moscow/L=Moscow/O=school21/CN=dtentaco.42.fr" \
	-keyout /etc/ssl/private/nginx-cert.key \
	-out /etc/ssl/certs/nginx-cert.crt

CMD ["service", "nginx", "restart"]

CMD nginx -g "daemon off;"

EXPOSE 443
