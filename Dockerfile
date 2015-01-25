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
	git clone -b devel https://github.com/fspc/Yellow-Bike-Database.git .

COPY YBDB.php /var/www/html/Connections/
# COPY populate.sql /var/www/html/sql/

# mysql_install_db solves a problem which occurs if bikebike/bikebike has not 
# been updated in a long time where mysql cannot find Table mysql.db when 
# started with mysqld_safe

RUN service mysql start; \
	mysql_install_db; \ 
	mysqladmin create ybdb; \
	mysql -e "GRANT ALL PRIVILEGES ON ybdb.* TO 'admin'@'%' IDENTIFIED BY 'yblcatx' with grant option"; \
	mysql ybdb < /var/www/html/sql/MySQL_Structure.sql; \
	mysql ybdb < /var/www/html/sql/populate.sql;	

## Will need to mkdir csv dir, change perms to www-data, and chmod 0700

COPY  mysql.conf /etc/supervisor/conf.d/
COPY  apache2.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

# docker run -d -p 81:80 --name="ybdb" bikebike/ybdb 
