########
# YBDB #
########
# YBP Hours and Transaction Database
# Password is

FROM bikebike/bikebike
MAINTAINER Jonathan Rosenbaum <gnuser@gmail.com>

RUN apt-get update && apt-get -y install apache2-mpm-prefork php5 php5-mysql;
RUN cd /var/www/html/; \
	rm index.html; \
	git clone -b devel https://github.com/fspc/Yellow-Bike-Database.git .; \

COPY YBDB.php /var/www/html/Connections/
RUN service mysql start; \ 
	mysqladmin create ybdb; \
	mysql -e "GRANT ALL PRIVILEGES ON ybdb.* TO 'admin'@'%' IDENTIFIED BY 'yblcatx' with grant option"; \
	mysql ybdb < /var/www/html/MySQL_Structure.sql; \
	mysql ybdb < /var/www/html/populate.sql;	

COPY  mysql.conf /etc/supervisor/conf.d/
COPY  apache2.conf /etc/supervisor/conf.d/
COPY  sshd.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

# docker run -d -p 81:80 --name="ybdb" bikebike/ybdb 
