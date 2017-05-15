#!/bin/bash

__mysql_config() {
# Hack to get MySQL up and running... I need to look into it more.
echo "Running the mysql_config function."
yum -y erase mysql mysql-server
rm -rf /var/lib/mysql/ /etc/my.cnf
yum -y install mysql mysql-server
mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe & 
sleep 10
}

__start_mysql() {
echo "Running the start_mysql function."
#mysqladmin -u root password test
#mysql -uroot -ptest -e "CREATE DATABASE testdb"
#mysql -uroot -ptest -e "GRANT ALL PRIVILEGES ON testdb.* TO 'testdb'@'localhost' IDENTIFIED BY 'test'; FLUSH PRIVILEGES;"
#mysql -uroot -ptest -e "GRANT ALL PRIVILEGES ON *.* TO 'testdb'@'%' IDENTIFIED BY 'test' WITH GRANT OPTION; FLUSH PRIVILEGES;"
#mysql -uroot -ptest -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'test' WITH GRANT OPTION; FLUSH PRIVILEGES;"
#mysql -uroot -ptest -e "select user, host FROM mysql.user;"
killall mysqld
sleep 10
}

# Call all functions
__mysql_config
__start_mysql
