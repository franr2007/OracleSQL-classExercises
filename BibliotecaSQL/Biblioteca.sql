--41663903R
--Francisco Javier Rodriguez
--21/01/26

create table Autor(
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    nom VARCHAR2(50),
    cognoms VARCHAR2(50),
    data_naix DATE,
    nacionalitat VARCHAR2(50)
);

CREATE TABLE Editorial(
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    nom VARCHAR2(50)
);

CREATE TABLE Llibre(
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    titol VARCHAR2(50),
    ano NUMBER CHECK (ano<=2023),
    exemplars NUMBER (10,0) CHECK (exemplars>0),
    id_editorial NUMBER NOT NULL,
    id_sequela NUMBER,
    UNIQUE (titol,ano),
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id),
    FOREIGN KEY (id_sequela) REFERENCES Llibre (id)
);

CREATE TABLE Autor_llibre(
    id_autor NUMBER,
    id_llibre NUMBER,
    PRIMARY KEY (id_autor,id_llibre),
    FOREIGN KEY (id_autor) REFERENCES Autor (id),
    FOREIGN KEY (id_llibre) REFERENCES Llibre (id)
);

CREATE TABLE Genere(
    nom VARCHAR2 PRIMARY KEY
);

CREATE TABLE Llibre_genere(
    id_llibre NUMBER,
    nom_genere VARCHAR2,
    PRIMARY KEY (id_llibre,nom_genere),
    FOREIGN KEY (id_llibre) REFERENCES Llibre(id),
    FOREIGN KEY (nom_genere) REFERENCES Genere(nom)
);