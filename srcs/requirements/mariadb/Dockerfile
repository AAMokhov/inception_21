FROM debian:buster

RUN	apt update && apt upgrade -y \
	&& apt install mariadb-server mariadb-client -y \
	&& mkdir -p /var/run/mysqld \
	&& chown -R www-data:www-data /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./tools/create_db.sh /bin/
COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chmod 775 /etc/mysql/my.cnf
RUN chmod -R 775 /var/lib/mysql

CMD sh /bin/create_db.sh

EXPOSE 3306
