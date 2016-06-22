CREATE DATABASE neutrondb;
GRANT ALL ON neutrondb.* TO 'neutron'@'%' IDENTIFIED BY 'password';
GRANT ALL ON neutrondb.* TO 'neutron'@'localhost' IDENTIFIED BY 'password';
