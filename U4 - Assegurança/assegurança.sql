--41663903R
--Francisco Javier Rodriguez Magaña
--25/01/26

--LOS INSERTS INTO SON PARA PONER VALORES DENTRO DE LAS TABLAS EXISTENTES

INSERT INTO PERSONA VALUES(
    '12345667Q','Carla','Rodriguez','Carrer els olivios 5','07013',678345423,25/05/23
);

INSERT INTO PERSONA VALUES(
    '54902347I','Xisco','Ramirez','Carrer amazonas 6','07020',645098912,15/12/21
);

INSERT INTO VEHICLE VALUES(
    '1234RMB','BMW','mfn-345234','54902347I'
);

INSERT INTO VEHICLE VALUES(
    '0987UYI','Nissan','nis-98754323','54902347I'
);

INSERT INTO VEHICLE VALUES(
    '5467IOP','Jeep','jpp-234575','12345667Q'
);

INSERT INTO MULTA VALUES(
    25/07/22,'Barcelona',4959,'0987UYI'
);

INSERT INTO ACCIDENT VALUES(
    'Palma',05/03/26
);

INSERT INTO ACCIDENT_VEHICLE(
    '12345667Q',1,'Choque automovilistico, en una rotonda'
);

INSERT INTO ACCIDENT_VEHICLE(
    '54902347I',1,'Choque automovilistico, en una rotonda'
);

ALTER TABLE MULTA ADD DATA_PAGAMENT DATE; -- modifica la tabla añadiendo data_pagament como fecha

ALTER TABLE ACCIDENT_VEHICLE MODIFY INFORME_PARTICIPACIO VARCHAR2(2000); -- modifica en la tabla una columna existente el tipo de valor que tiene

ALTER TABLE PERSONA DROP DATA_ALTA; -- modifica la tabla eliminando la columna data_alta

UPDATE PERSONA SET NOM  = 'SOFIA' WHERE DNI = '12345667Q'; -- actualiza los datos dentro de una tabla el nombre que contenga ese dni

DELETE FROM MULTA WHERE MATRICULA_VEHICLE = '0987UYI'; -- elimina de multa donde la matricula del vehiculo 