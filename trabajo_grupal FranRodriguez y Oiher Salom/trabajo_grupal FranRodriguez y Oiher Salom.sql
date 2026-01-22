--41663903R
--Francisco Javier Rodriguez
--21/01/26

create table Jugador(
    dni varchar2(9) PRIMARY KEY,
    nom_jugador varchar2(50),
    num_jugador NUMBER,
    tel_j varchar2(13),
    email_j varchar2(50)
);

create table Equipo(
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    num_e NUMBER,
    dni_j varchar2(9),
    FOREIGN KEY (dni_j) REFERENCES Jugador(dni)
);

create table Evento(
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    mapa varchar2(50),
    modo_juego varchar2(50),
    dia_evento date
);

create table Tienen(
    id_equipo NUMBER,
    id_evento NUMBER,
    PRIMARY KEY (id_equipo, id_evento),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id),
    FOREIGN KEY (id_evento) REFERENCES Evento(id)
);

create table Trabajador(
    dni varchar2(9) PRIMARY KEY,
    nom_t varchar2(50),
    tel_t varchar2(13),
    email_t varchar2(50)
);

create table Hay(
    id_evento NUMBER,
    dni_t varchar2(50),
    PRIMARY KEY (id_evento , dni_t),
    FOREIGN KEY (id_evento) REFERENCES Evento(id),
    FOREIGN KEY (dni_t) REFERENCES Trabajador(dni)
);

create table Proveedor(
    dni varchar2(9) PRIMARY KEY,
    tel_p varchar2(13),
    nom_p varchar2(50),
    email_p varchar2(50)
);

--Padre
create table Equipamiento( 
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    dni_p varchar2(9),
    FOREIGN KEY (dni_p) REFERENCES Proveedor(dni)
);

--Hijos

create table Proteccion(
    tipo_p varchar2(50),
    id_equipamiento NUMBER,
    grado_p varchar2(50),
    estado varchar2(50),
    FOREIGN KEY (id_equipamiento) REFERENCES Equipamiento(id),
    PRIMARY KEY (tipo_p,id_equipamiento)
);

create table Arma(
    tipo_a varchar2(50),
    id_equipamiento NUMBER,
    estado varchar2(50),
    FOREIGN KEY (id_equipamiento) REFERENCES Equipamiento(id),
    PRIMARY KEY (tipo_a,id_equipamiento)
);

create table Municion(
    tipo_m varchar2(50),
    id_equipamiento NUMBER,
    cantidad NUMBER,
    FOREIGN KEY (id_equipamiento) REFERENCES Equipamiento(id),
    PRIMARY KEY(tipo_m,id_equipamiento)
);