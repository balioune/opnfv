CREATE DATABASE novadb;
GRANT ALL ON novadb.* TO 'nova'@'%' IDENTIFIED BY 'password';
GRANT ALL ON novadb.* TO 'nova'@'localhost' IDENTIFIED BY 'password';
