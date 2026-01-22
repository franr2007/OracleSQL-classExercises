--41663903R
--Francisco Javier Rodriguez
--21/01/26

CREATE TABLE empleat(
    nss NUMBER GENERATED AS IDENTITY PRIMARY KEY, --pk
    nom VARCHAR2(50) NOT NULL,
    llinatges VARCHAR2(50) NOT NULL,
    email VARCHAR2(50),
    iban VARCHAR2(50) NOT NULL UNIQUE CHECK (iban LIKE 'ES%')
);

CREATE TABLE tipusDePlaza(
    nom VARCHAR2(50) PRIMARY KEY, --pk
    funcio VARCHAR2(50) NOT NULL
);

CREATE TABLE plaza(
    codi NUMBER GENERATED AS IDENTITY PRIMARY KEY, --pk
    nom VARCHAR2(50) NOT NULL,
    salariCod VARCHAR2(50) NOT NULL,
    codiPlazaSupervisora NUMBER, --fk
    informeSupervisio VARCHAR2(50),
    nomTipusPlaza VARCHAR2(50) NOT NULL, --fk
    FOREIGN KEY (codiPlazaSupervisora) REFERENCES plaza (codi),
    FOREIGN KEY (nomTipusPlaza) REFERENCES tipusDePlaza (nom)
);

CREATE TABLE ocupa(
    nssEmpleat NUMBER NOT NULL, --pk fk
    codiPlaza NUMBER NOT NULL, --pk fk
    dataInici DATE NOT NULL,
    dataFi DATE,
    PRIMARY KEY (nssEmpleat,codiPlaza),
    FOREIGN KEY (nssEmpleat) REFERENCES empleat (nss),
    FOREIGN KEY (codiPlaza) REFERENCES plaza (codi)
);

CREATE TABLE nomina(
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY, --pk
    ibanPagament VARCHAR2(50) NOT NULL CHECK (ibanPagament LIKE 'ES%'),
    import NUMBER NOT NULL,
    nssEmpleat NUMBER NOT NULL, --fk
    codiPlaza NUMBER NOT NULL, --fk
    FOREIGN KEY (nssEmpleat) REFERENCES empleat (nss),
    FOREIGN KEY (codiPlaza) REFERENCES plaza (codi)
);
