CREATE TABLE PLACOWKI (
 id_placowki INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 nazwa VARCHAR(100) UNIQUE NOT NULL,
 miasto VARCHAR(100) UNIQUE NOT NULL,
 ulica VARCHAR(100) UNIQUE NOT NULL,
 nr_budynku INTEGER UNIQUE NOT NULL,
 longitude DECIMAL(9, 7) UNIQUE NOT NULL,
 latitude DECIMAL(9, 7) UNIQUE NOT NULL
);

CREATE TABLE ODBIORCY (
id_odbiorcy INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY
 );

CREATE TABLE SEKTORY(
id_placowki INTEGER NOT NULL REFERENCES PLACOWKI(id_placowki),
id_sektor INTEGER NOT NULL UNIQUE
);

CREATE TABLE STRAZNICY (
 id_straznika INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_odbiorcy INTEGER NOT NULL REFERENCES ODBIORCY(id_odbiorcy),
 imie VARCHAR(20) NOT NULL,
 nazwisko VARCHAR(20) NOT NULL,
 id_placowki INTEGER NOT NULL REFERENCES PLACOWKI(id_placowki),
 wyplata INTEGER NOT NULL
);

CREATE TABLE CELE (
 id_celi INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_sektor INTEGER NOT NULL REFERENCES SEKTORY(id_sektor), 
 id_placowki INTEGER NOT NULL REFERENCES PLACOWKI(id_placowki),
 pojemnosc_celi INTEGER NOT NULL CHECK (pojemnosc_celi > 0)
);

CREATE TABLE ZMIANY (
id_zmiany INTEGER NOT NULL,
id_sektor INTEGER NOT NULL REFERENCES SEKTORY(id_sektor),
id_straznika INTEGER NOT NULL REFERENCES STRAZNICY(id_straznika)
);

CREATE TABLE MAGAZYNY (
 id_magazynu INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_placowki INTEGER NOT NULL REFERENCES PLACOWKI(id_placowki),
 pojemnosc_magazynu INTEGER NOT NULL CHECK (pojemnosc_magazynu > 0)
);

CREATE TABLE STOLOWKI (
 id_stolowki INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_placowki INTEGER NOT NULL REFERENCES PLACOWKI(id_placowki),
 pojemnosc_stolowki INTEGER NOT NULL CHECK (pojemnosc_stolowki > 0)
);

CREATE TABLE PRZESTEPSTWA (
 id_przestepstwa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 wykroczenie VARCHAR(50) UNIQUE NOT NULL,
 stopien_zagrozenia INTEGER NOT NULL
);

CREATE TABLE WIEZNIOWIE (
 id_wieznia INTEGER PRIMARY KEY,
 imie VARCHAR(50) NOT NULL,
 nazwisko VARCHAR(50) NOT NULL,
 pseudonim VARCHAR(50),
 id_przestepstwa INTEGER NOT NULL REFERENCES PRZESTEPSTWA(id_przestepstwa),
 data_przybycia DATE NOT NULL,
 wyrok INTEGER NOT NULL CHECK (wyrok > 0),
 gang VARCHAR(50),
 id_celi INTEGER REFERENCES CELE(id_celi),
 id_stolowki INTEGER REFERENCES STOLOWKI(id_stolowki),
 data_wyjscia DATE CHECK (data_wyjscia > data_przybycia),
 adres_zdjecia VARCHAR(20) UNIQUE
);

CREATE TABLE TRANSFERY (
 id_transferu INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 data_transferu DATE NOT NULL, 
 id_wieznia INTEGER REFERENCES WIEZNIOWIE(id_wieznia),
 id_celi_in INTEGER NOT NULL REFERENCES CELE(id_celi),
 id_celi_out INTEGER NOT NULL REFERENCES CELE(id_celi)
);

CREATE TABLE POZOSTALI_PRACOWNICY (
 id_pracownika INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_odbiorcy INTEGER NOT NULL REFERENCES ODBIORCY(id_odbiorcy),
 imie VARCHAR(20) NOT NULL,
 nazwisko VARCHAR(20) NOT NULL,
 wyplata INTEGER NOT NULL,
 id_placowki INTEGER REFERENCES PLACOWKI(id_placowki),
 stanowisko VARCHAR(20) NOT NULL
);

CREATE TABLE ZAOPATRZENIE (
 id_produktu INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 id_sali INTEGER REFERENCES MAGAZYNY(id_magazynu),
 typ_produktu VARCHAR(20) NOT NULL,
 zapotrzebowanie_jednostkowe INTEGER NOT NULL,
 obecny_stan INTEGER NOT NULL
);

CREATE TABLE KONTRAHENCI (
 id_kontrahenta INTEGER PRIMARY KEY,
 id_odbiorcy INTEGER NOT NULL REFERENCES ODBIORCY(id_odbiorcy),
 nazwa VARCHAR UNIQUE NOT NULL,
 id_produktu INTEGER REFERENCES ZAOPATRZENIE(id_produktu),
 cena_produktu INTEGER NOT NULL
);


CREATE TABLE FINANSE (
 id_transakcji INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 kwota INTEGER NOT NULL CHECK (kwota > 0),
 data_transakcji DATE NOT NULL,
 id_odbiorcy INTEGER NOT NULL REFERENCES ODBIORCY(id_odbiorcy)
);
