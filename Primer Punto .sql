--Creacion de la tabla sucursal
CREATE TABLE sucursal(
codsuc NUMBER(8) PRIMARY KEY,
ganancia NUMBER(8) NOT NULL CHECK (ganancia > 0),
sucpadre NUMBER(8) REFERENCES sucursal
); 


--Insercion de datos en la tabla sucursal
INSERT INTO sucursal (codsuc, ganancia, sucpadre) 
VALUES (1,5000,NULL);

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (2, 200, 1

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (9, 300, 1);

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (11, 500, 1);

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (15, 800, 2);

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (16, 900, 2);

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (22, 50, 11);

INSERT INTO sucursal (codsuc, ganancia, sucpadre)
VALUES (29, 80, 16);
