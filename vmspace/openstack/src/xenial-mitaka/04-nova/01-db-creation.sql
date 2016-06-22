CREATE DATABASE novadb;
GRANT ALL ON novadb.* TO 'nova'@'%' IDENTIFIED BY 'password';
GRANT ALL ON novadb.* TO 'nova'@'localhost' IDENTIFIED BY 'password';

CREATE DATABASE nova_api;
GRANT ALL ON nova_api.* TO 'nova'@'%' IDENTIFIED BY 'password';
GRANT ALL ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'password';
