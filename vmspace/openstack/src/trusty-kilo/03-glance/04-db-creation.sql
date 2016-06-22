CREATE DATABASE glancedb
 DEFAULT CHARACTER SET utf8
 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON glancedb.* TO 'glance'@'%' IDENTIFIED BY 'password';
GRANT ALL ON glancedb.* TO 'glance'@'localhost' IDENTIFIED BY 'password';
