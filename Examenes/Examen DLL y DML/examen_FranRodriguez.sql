--41663903R
--Francisco Javier Rodriguez Magaña
-- 26/01/26

DROP TABLE REVISIO;
DROP TABLE COTXE;
DROP TABLE PROVA;
DROP TABLE MODEL;
DROP TABLE CLIENT;

CREATE TABLE CLIENT(
    DNI VARCHAR2(9) PRIMARY KEY, --PK
    Nom  VARCHAR2(50) NOT NULL,
    Direccio VARCHAR2(100) NOT NULL,
    Telefon NUMBER,
    Email VARCHAR2(100),
    CHECK(LENGTH(DNI) = 9)
);

CREATE TABLE MODEL(
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY, --PK
    Any_lanzamiento DATE NOT NULL,
    Nom VARCHAR2(50) NOT NULL,
    Marca VARCHAR2(50)NOT NULL,
    ID_Substitueix NUMBER NOT NULL, --FK
    FOREIGN KEY (ID_Substitueix) REFERENCES MODEL(ID),
    UNIQUE(Any_lanzamiento,Nom,Marca)
);

CREATE TABLE PROVA(
    ID_Model NUMBER, --PK FK
    DNI_Client VARCHAR2(9),--PK FK
    Data_prova DATE NOT NULL,
    PRIMARY KEY(ID_Model,DNI_Client),
    FOREIGN KEY (ID_Model) REFERENCES MODEL(ID),
    FOREIGN KEY (DNI_Client) REFERENCES CLIENT(DNI)
);

CREATE TABLE COTXE(
    Matricula VARCHAR2(7) PRIMARY KEY,--PK
    Preu NUMBER NOT NULL,
    Color VARCHAR2(50) NOT NULL,
    ID_Model NUMBER NOT NULL, --FK
    DNI_Client VARCHAR2(9) NOT NULL,--FK
    CHECK(LENGTH(Matricula) = 7),
    FOREIGN KEY (ID_Model) REFERENCES MODEL(ID),
    FOREIGN KEY (DNI_Client) REFERENCES CLIENT (DNI)
);

CREATE TABLE REVISIO(
    Codi NUMBER GENERATED AS IDENTITY PRIMARY KEY,--PK
    Descripcio VARCHAR2(500) NOT NULL,
    Data DATE NOT NULL,
    Matricula_Cotxe VARCHAR2(7) NOT NULL,--FK
    CHECK(LENGTH(Descripcio) > 100),
    FOREIGN KEY (Matricula_Cotxe) REFERENCES COTXE(Matricula)
);

--Informacion

INSERT INTO CLIENT VALUES('12345678p','Fran Rodriguez','Calle olmos 3',675221243,'asdfas@gmail.com');
INSERT INTO MODEL(Any_lanzamiento,Nom,Marca,ID_Substitueix) VALUES(DATE '1990-12-20','Speedy 1.0','Nissan',2);
INSERT INTO MODEL(Any_lanzamiento,Nom,Marca,ID_Substitueix) VALUES(DATE '2023-03-05','Speedy 2.0','Nissan',1);
INSERT INTO PROVA(ID_Model,DNI_Client,Data_prova) VALUES(1,'12345678p',DATE '2024-12-12');
INSERT INTO COTXE(DNI_Client,Matricula,Preu,Color,ID_Model) VALUES('12345678p','3456LFN',39999,'Ultra Violeta',1);
INSERT INTO REVISIO(Descripcio,Data,Matricula_Cotxe) VALUES('Revision completa al nuevo modelo de la marca Nissan Speedy 2.0, del cual propietario es Fran Rodriguez Magaña',DATE '2025-01-22','3456LFN');

--operaciones

ALTER TABLE CLIENT DROP COLUMN Telefon;
UPDATE CLIENT SET Nom = 'Carla Garcia' WHERE DNI = '12345678p';
ALTER TABLE PROVA ADD Observacions VARCHAR2(2000);
DELETE FROM PROVA WHERE Data_prova < DATE '2024-12-31';