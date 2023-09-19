CREATE DATABASE System_Bancario;
USE System_Bancario;

create table banco (
codigo int NOT NULL,
nome varchar(50) DEFAULT NULL,
PRIMARY KEY (codigo)
);

create table agencia(
cod_banco int DEFAULT NULL,
numero_agencia int NOT NULL,
endereco varchar(50) DEFAULT NULL,
PRIMARY KEY (numero_agencia),
foreign key (cod_banco) REFERENCES banco (codigo)
);

create table cliente (
cpf char(11) NOT NULL,
nome varchar(50) NOT NULL,
sexo char(1) NOT NULL,
endereco varchar(50) DEFAULT NULL,
primary key (cpf),
check (sexo in ('M', 'F'))
);

create table conta (
numero_conta char(7) NOT NULL,
saldo varchar(100) NOT NULL,
tipo_conta varchar(15) DEFAULT NULL,
num_agenci char(4) NOT NULL,
PRIMARY KEY (numero_conta)
);

create table historico(
cpf_cliente char(14) NOT NULL,
num_conta char(9) NOT NULL,
data_inicio date DEFAULT NULL,
PRIMARY KEY (cpf_cliente,num_conta)
);

create table telefone_cliente(
cpf_cli char(14) NOT NULL,
telefone char(14) NOT NULL,
PRIMARY KEY (cpf_cli, telefone)
);

