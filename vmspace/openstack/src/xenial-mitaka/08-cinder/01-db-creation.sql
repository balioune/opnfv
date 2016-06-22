CREATE DATABASE cinderdb;
GRANT ALL ON cinderdb.* TO 'cinder'@'%' IDENTIFIED BY 'password';
GRANT ALL ON cinderdb.* TO 'cinder'@'localhost' IDENTIFIED BY 'password';
