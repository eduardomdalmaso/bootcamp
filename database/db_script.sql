CREATE TABLE usuarios (
    id INT,
    nome VARCHAR(255) NOT NULL COMMENT 'Nome do usuário',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'E-mail do usuário',
    endereco VARCHAR(50) NOT NULL COMMENT 'Endereço do usuário',
    data_nascimento DATE NOT NULL COMMENT 'Data de nascimento do usuário'
);

CREATE TABLE viagens.destinos (
    id INT,
    nome VARCHAR(255) NOT NULL UNIQUE COMMENT 'Nome do destino',
    descricao VARCHAR(255) NOT NULL COMMENT 'Descrição do destino'
);

CREATE TABLE viagens.reservas (
    id INT COMMENT 'Identificador único da reserva',
    id_usuario INT COMMENT 'Referência ao ID do usuário que fez a reserva',
    id_destino INT COMMENT 'Referência ao ID do destino da reserva',
    data DATE COMMENT 'Data da reserva',
    status VARCHAR(255) DEFAULT 'pendente' COMMENT 'Status da reserva (confirmada, pendente, cancelada, etc..)'
);

INSERT INTO usuarios (id,nome,email,data_nascimento,endereco) VALUES (1,"Pâmela Apolinario","teste@teste.com","1992-10-05","Av das Rosas, 100 - Bairro Alto São Paulo")
                                                                     (2,"joão Silva","joao@silva.com","1990-01-01","Rua das Flores, 200 - Centro São Paulo"),
                                                                     (3,"Maria Souza","maria@souza","1995-03-08","Avenida Paulista, 300 - Bela Vista São Paulo");
INSERT INTO destinos (id,nome,descricao) VALUES (1,"Praia da Rosa","Linda Praia"),
                                                (2,"Praia do Sol","Praia com águas cristalinas"),
                                                (3,"Praia da Lua","Praia com areia branca");
INSERT INTO reservas (id,id_usuario,id_destino,status,data) VALUES (1,1,1,"2023-11-11","pendente"),
                                                                   (2,2,2,"2023-12-12","confirmada"),
                                                                   (3,3,3,"2023-10-10","cancelada");

SELECT * FROM usuarios;
WHERE id = 2;
WHERE id = 1 AND nome LIKE "%Pâmela%";
WHERE id = 1 OR nome LIKE "%Maria%";

UPDATE usuarios
SET id = 4
WHERE email = "teste@teste.com";

DELETE FROM usuarios
WHERE nome = "Praia do Rosa";


CREATE TABLE usuarios_nova (
    id INT,
    nome VARCHAR(255) NOT NULL COMMENT 'Nome do usuário',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'E-mail do usuário',
    endereco VARCHAR(50) NOT NULL COMMENT 'Endereço do usuário',
    data_nascimento DATE NOT NULL COMMENT 'Data de nascimento do usuário'
);

INSERT INTO usuarios_nova (id, nome, email, endereco, data_nascimento)
SELECT id, nome, email, endereco, data_nascimento
FROM usuarios;

SELECT usuarios_nova;

DROP TABLE usuarios;

ALTER TABLE usuarios_nova RENAME usuarios;
ALTER TABLE usuarios MODIFY COLUMN endereco VARCHAR(150);

ALTER TABLE usuarios
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

ALTER TABLE destinos
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

ALTER TABLE reservas
ADD CONSTRAINT fk_reservas_usuarios
FOREIGN KEY(id_usuario) REFERENCES usuarios (id);

ALTER TABLE reservas
ADD CONSTRAINT fk_reservas_destinos
FOREIGN KEY(id_destinos) REFERENCES destinos (id);

ALTER TABLE reservas
ADD CONSTRAINT fk_usuarios
FOREIGN KEY (id_usuario) REFERENCES usuarios (id)
ON DELETE CASCADE;

DELETE FROM usuarios WHERE id = 1;

ALTER TABLE reservas DROP CONSTRAINT fk_reservas_usuarios

DELETE FROM usuarios WHERE id = 1;

ALTER TABLE usuarios
ADD rua VARCHAR(100),
ADD numero VARCHAR(10),
ADD cidade VARCHAR(50),
ADD estado VARCHAR(20);

UPDATE usuarios
SET rua = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',',1),',',-1),
    numero = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',',2),',',-1),
    cidade = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',',3),',',-1),
    estado = SUBSTRING_INDEX(endereco, ',',-1);

ALTER TABLE usuarios
DROP COLUMN endereco;

INNER JOIN reservas ON usuarios.id = reservas.id_usuario,
INNER JOIN destinos ON reservas.id_destino = destinos.id;

INSERT INTO usuarios (nome, email, data_nascimento, rua, numero, cidade, estado)
VALUES ("Sem reservas","dio@teste.com","1992-05-10","Rua Teste","12","Cidade teste","São Paulo");

LEFT JOIN reservas ON usuarios.id = reservas.id_usuario;

INSERT INTO destinos (nome,descricao,)
VALUES ("Shopping","Compras");

RIGHT JOIN destinos ON reservas.id = destinos.id;

SELECT * FROM destinos
WHERE id NOT IN (SELECT id_destino FROM reserva);




