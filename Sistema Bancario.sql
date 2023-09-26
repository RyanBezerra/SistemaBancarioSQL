CREATE DATABASE sistema_bancario;
USE sistema_bancario;

CREATE TABLE BANCO (
    codigo INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE AGENCIA (
    cod_banco INT NOT NULL AUTO_INCREMENT,
    numero_agencia varchar(4) NOT NULL,
    endereco VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (numero_agencia),
    FOREIGN KEY (cod_banco) REFERENCES banco (codigo)
);

CREATE TABLE CLIENTE (
    cpf CHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1) NOT NULL,
    endereco VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (cpf),
    CHECK (sexo IN ('M', 'F'))
);

CREATE TABLE CONTA (
    numero_conta CHAR(7) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL,
    tipo_conta CHAR(1) DEFAULT NULL,
    num_agencia varchar(4) NOT NULL,
    CHECK (tipo_conta IN ('1', '2', '3')),
    PRIMARY KEY (numero_conta),
    FOREIGN KEY (num_agencia) REFERENCES agencia (numero_agencia)
);

CREATE TABLE HISTORICO (
    cpf_cliente CHAR(14) NOT NULL UNIQUE,
    num_conta CHAR(7) NOT NULL,
    data_inicio DATE DEFAULT NULL,
    PRIMARY KEY (cpf_cliente, num_conta),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente (cpf),
    FOREIGN KEY (num_conta) REFERENCES conta (numero_conta)
);

CREATE TABLE TELEFONE_CLIENTE (
    cpf_cli CHAR(14) NOT NULL,
    telefone CHAR(15) NOT NULL,
    PRIMARY KEY (cpf_cli, telefone),
    FOREIGN KEY (cpf_cli) REFERENCES cliente (cpf)
);

INSERT INTO BANCO (codigo, nome) value ('1','Banco do Brasil');
INSERT INTO BANCO (codigo, nome) value ('4','CEF');

INSERT INTO AGENCIA (cod_banco, numero_agencia, endereco) values
('4', '322', 'Av. Walfredo Macedo Brandao, 1139'),
('1', '1253', 'R. Bancário Sérgio Guerra, 17');

INSERT INTO CLIENTE (cpf, nome, sexo, endereco) values 
('111.222.333-44', 'Bruna Andrade', 'F', 'Rua José Firmino Ferreira, 1050 '),
('666.777.888-99', 'Radegondes Silva', 'M', 'Av. Epitácio Pessoa, 1008 '),
('555.444.777-33', 'Ryan Nascimento', 'M', 'Rua Bancário Sérgio Guerra, 640');

INSERT INTO CONTA (numero_conta, saldo, tipo_conta, num_agencia) values 
('11765-2', '22745.05', '2', '322'),
('21010-7', '3100.96', '1', '1253');

INSERT INTO HISTORICO (cpf_cliente, num_conta, data_inicio) values 
('111.222.333-44', '11765-2', '2015-12-22'),
('666.777.888-99', '11765-2', '2016-10-05'),
('555.444.777-33', '21010-7', '2012-08-29');

INSERT INTO TELEFONE_CLIENTE (cpf_cli, telefone) values 
('111.222.333-44', '(83) 3222-1234'),
('666.777.888-99', '(83) 99443-9999'),
('555.444.777-33', '(83) 3233-2267');

ALTER TABLE CLIENTE ADD COLUMN país char(3) DEFAULT 'BRA';

ALTER TABLE CLIENTE ADD COLUMN email varchar(30) not null;

ALTER TABLE HISTORICO DROP FOREIGN KEY historico_ibfk_2;
DELETE FROM CONTA WHERE numero_conta = '11765-2';

UPDATE AGENCIA SET numero_agencia = '6342' WHERE numero_agencia = '322';

ALTER TABLE CONTA MODIFY numero_conta char(7);

UPDATE CLIENTE SET email = 'radegondes.silva@gmail.com' WHERE cpf = '666.777.888-99';

UPDATE CONTA SET saldo = saldo * 1.10 WHERE numero_conta = '21010-7';

UPDATE CLIENTE SET nome = 'Bruna Fernandes' WHERE cpf = '111.222.333-44';

UPDATE CONTA SET tipo_conta = '3' WHERE saldo > 10000.00;

 SELECT nome, sexo FROM CLIENTE ORDER BY nome DESC;

SELECT A.numero_agencia, SUM(CO.saldo) AS saldo_total_da_agencia FROM AGENCIA A LEFT JOIN CONTA CO ON A.numero_agencia = CO.num_agencia GROUP BY A.numero_agencia;

SELECT A.numero_agencia, COUNT(DISTINCT C.cpf) AS quantidade_de_clientes FROM AGENCIA A LEFT JOIN CONTA CO ON A.numero_agencia = CO.num_agencia LEFT JOIN HISTORICO H ON CO.numero_conta = H.num_conta LEFT JOIN CLIENTE C ON H.cpf_cliente = C.cpf GROUP BY A.numero_agencia;

SELECT CLIENTE.nome, CLIENTE.endereco, HISTORICO.num_conta FROM CLIENTE JOIN HISTORICO ON CLIENTE.cpf = HISTORICO.cpf_cliente;

SELECT sexo, COUNT(*) as quantidade FROM CLIENTE GROUP BY sexo;

SELECT CLIENTE.nome, CONTA.saldo FROM CLIENTE JOIN HISTORICO ON CLIENTE.cpf = HISTORICO.cpf_cliente JOIN CONTA ON HISTORICO.num_conta = CONTA.numero_conta WHERE CONTA.saldo = (SELECT MAX(saldo) FROM CONTA);

SELECT CLIENTE.nome, CONTA.saldo AS saldo_atual, CONTA.saldo * 1.035 AS saldo_com_aumento FROM CLIENTE JOIN HISTORICO ON CLIENTE.cpf = HISTORICO.cpf_cliente JOIN CONTA ON HISTORICO.num_conta = CONTA.numero_conta;

SELECT nome FROM CLIENTE WHERE endereco LIKE 'Av.%';
