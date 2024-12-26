CREATE TABLE PLACOWKI (
 id_placowki INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 nazwa VARCHAR(100) UNIQUE NOT NULL,
 adres VARCHAR(100) UNIQUE NOT NULL,
 longitude DECIMAL(7, 5) UNIQUE NOT NULL,
 latitude DECIMAL(7, 5) UNIQUE NOT NULL
);

CREATE TABLE STRAZNICY (
 id_straznika INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 zmiana INTEGER NOT NULL,
 id_placowki INTEGER REFERENCES PLACOWKI(id_placowki),
 wyplata INTEGER NOT NULL
);

CREATE TABLE POMIESZCZENIA (
 id_sali INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_placowki INTEGER REFERENCES PLACOWKI(id_placowki),
 typ_sali VARCHAR(20),
 pojemnosc_magazynu INTEGER CHECK (pojemnosc_magazynu > 0),
 pojemnosc_celi INTEGER CHECK (pojemnosc_celi > 0),
 id_straznika_1 INTEGER REFERENCES STRAZNICY(id_straznika),
 id_straznika_2 INTEGER REFERENCES STRAZNICY(id_straznika),
 id_straznika_3 INTEGER REFERENCES STRAZNICY(id_straznika)
);

