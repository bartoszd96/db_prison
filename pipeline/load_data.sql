INSERT INTO placowki(nazwa, miasto, ulica, nr_budynku, longitude, latitude) VALUES 
('Zaklad karny nr 1 we Wroclawiu', 'Wroclaw', 'Kleczkowska', 35, 51.127434, 17.0269411),
('Zaklad karny w Wolowie', 'Wolow', 'Wiezienna', 6,  51.2581917, 16.5629008);


-- Insert into SEKTORY (5 sectors per facility)
INSERT INTO SEKTORY (id_placowki, id_sektor) VALUES
(1, 101), (1, 102), (1, 103), (1, 104), (1, 105),
(2, 201), (2, 202), (2, 203), (2, 204), (2, 205);

INSERT INTO CELE (id_sektor, id_placowki, pojemnosc_celi) VALUES
(101, 1, 4), (101, 1, 5), (101, 1, 6),
(102, 1, 6), (102, 1, 4), (102, 1, 5),
(103, 1, 5), (103, 1, 6), (103, 1, 4),
(104, 1, 4), (104, 1, 6), (104, 1, 5),
(105, 1, 6), (105, 1, 5), (105, 1, 4),
(201, 2, 5), (201, 2, 4), (201, 2, 6),
(202, 2, 6), (202, 2, 5), (202, 2, 4),
(203, 2, 4), (203, 2, 6), (203, 2, 5),
(204, 2, 5), (204, 2, 4), (204, 2, 6),
(205, 2, 6), (205, 2, 4), (205, 2, 5);

-- Insert into STRAZNICY (5 existing guards + 5 new ones)
INSERT INTO STRAZNICY (imie, nazwisko, id_placowki, wyplata) VALUES
-- Placówka 1
('Karol', 'Majewski', 1, 5000),
('Damian', 'Stepien', 1, 5500),
('Krzysztof', 'Baran', 1, 5100),
('Tomasz', 'Wilczek', 1, 5200),
('Sebastian', 'Nowosielski', 1, 5300),
('Marek', 'Ostrowski', 1, 5100),
('Adam', 'Nowak', 1, 5000),
('Piotr', 'Lis', 1, 5500),
('Daniel', 'Wojcik', 1, 5200),
('Lukasz', 'Zielinski', 1, 5400),
('Maciej', 'Borkowski', 1, 5300),
('Mateusz', 'Kaczmarek', 1, 5100),
('Jakub', 'Adamski', 1, 5200),
('Michal', 'Sobczak', 1, 5400),
('Patryk', 'Michalski', 1, 5500),
-- Placówka 2
('Rafal', 'Dudek', 2, 5200),
('Mariusz', 'Czerwinski', 2, 5300),
('Grzegorz', 'Lisowski', 2, 5400),
('Pawel', 'Jastrzebski', 2, 5500),
('Jakub', 'Szymanski', 2, 5100),
('Bartek', 'Wroblewski', 2, 5200),
('Tadeusz', 'Nowacki', 2, 5300),
('Filip', 'Kowalski', 2, 5400),
('Kamil', 'Gorski', 2, 5000),
('Andrzej', 'Lewandowski', 2, 5100),
('Szymon', 'Pietrzak', 2, 5200),
('Oskar', 'Bielawski', 2, 5300),
('Wiktor', 'Zawadzki', 2, 5500),
('Dominik', 'Kot', 2, 5400),
('Igor', 'Zielonka', 2, 5200);


-- Insert into PRZESTEPSTWA (Crimes)
INSERT INTO PRZESTEPSTWA (wykroczenie, stopien_zagrozenia) VALUES
('Kradziez', 2), ('Napad', 3), ('Zabojstwo', 5), ('Handel narkotykami', 4), ('Przekret finansowy', 3), ('Podpalenie', 4), ('Pobicie', 3), ('Falszerstwo', 3), ('Morderstwo', 5), ('Dzielenie przez 0', 1),  ('Zaklocanie porzadku', 1);


-- Insert into WIEZNIOWIE (20 prisoners)
INSERT INTO WIEZNIOWIE (id_wieznia, imie, nazwisko, pseudonim, id_przestepstwa, data_przybycia, wyrok, gang, id_celi, id_stolowki, adres_zdjecia) VALUES
(1, 'Jan', 'Kowalski', 'Rekin', 2, '2023-05-10', 7, 'Bracia', 101, 1, 'C:\Users\koszm\OneDrive\Documents\ugh\bazki\zdjecie5.jpg'),
(2, 'Piotr', 'Nowak', 'Lis', 3, '2022-06-20', 15, 'Wilki', 101, 1, 'piotr_n.jpg'),
(3, 'Andrzej', 'Wisniewski', 'Tygrys', 1, '2021-03-15', 5, 'Bracia', 102, 1, 'andrzej_w.jpg'),
(4, 'Kamil', 'Lewandowski', NULL, 4, '2020-12-01', 10, NULL, 102, 1, 'kamil_l.jpg'),
(5, 'Tomasz', 'Dabrowski', 'Smok', 3, '2019-07-14', 20, 'Smoki', 103, 2, 'tomasz_d.jpg'),
(6, 'Robert', 'Zielinski', NULL, 5, '2021-02-28', 8, NULL, 103, 2, 'robert_z.jpg'),
(7, 'Marek', 'Szymanski', 'Sowa', 1, '2020-09-19', 4, 'Wilki', 104, 2, 'marek_s.jpg'),
(8, 'Adam', 'Wojcik', NULL, 8, '2022-04-10', 12, NULL, 104, 2, 'adam_w.jpg'),
(9, 'Lukasz', 'Mazur', 'Wilk', 5, '2018-10-25', 25, 'Bracia', 105, 1, 'lukasz_m.jpg'),
(10, 'Pawel', 'Krawczyk', NULL, 4, '2019-01-11', 18, NULL, 105, 1, 'pawel_k.jpg'),
(11, 'Mateusz', 'Piotrowski', NULL, 1, '2023-08-15', 6, NULL, 201, 2, 'mateusz_p.jpg'),
(12, 'Grzegorz', 'Nowicki', 'Czapla', 2, '2022-10-12', 9, 'Bracia', 201, 2, 'grzegorz_n.jpg'),
(13, 'Jakub', 'Pawlak', NULL, 3, '2021-06-20', 14, NULL, 202, 1, 'jakub_p.jpg'),
(14, 'Michal', 'Zajac', 'Dzik', 5, '2020-05-17', 11, 'Wilki', 202, 1, 'michal_z.jpg'),
(15, 'Marcin', 'Krol', NULL, 4, '2019-12-22', 17, NULL, 203, 2, 'marcin_k.jpg'),
(16, 'Szymon', 'Wieczorek', NULL, 2, '2023-03-30', 7, NULL, 203, 2, 'szymon_w.jpg'),
(17, 'Bartosz', 'Jablonski', 'Orzel', 10, '2021-07-29', 5, 'Bracia', 204, 1, 'bartosz_j.jpg'),
(18, 'Wojciech', 'Wrobel', NULL, 9, '2020-11-02', 16, NULL, 204, 1, 'wojciech_w.jpg'),
(19, 'Dariusz', 'Wlodarczyk', 'Niedzwiedz', 5, '2018-08-14', 30, 'Wilki', 205, 2, 'dariusz_w.jpg'),
(20, 'Filip', 'Kot', NULL, 4, '2019-09-09', 20, NULL, 205, 2, 'filip_k.jpg');


-- Insert into STOLOWKI (2 cafeterias)
INSERT INTO STOLOWKI (id_placowki, pojemnosc_stolowki) VALUES
(1, 50), (2, 40);

-- Insert into MAGAZYNY (3 storage rooms)
INSERT INTO MAGAZYNY (id_placowki, pojemnosc_magazynu) VALUES
(1, 100), (2, 120), (1, 90);


-- Insert into FINANSE (3 existing transactions + 5 new ones)
INSERT INTO FINANSE (kwota, data_transakcji, id_odbiorcy) VALUES
(5000, '2024-01-15', 1),
(3000, '2024-01-18', 2),
(7000, '2024-01-20', 3),
(4500, '2024-02-05', 4),
(6000, '2024-02-10', 5),
(3200, '2024-02-12', 6),
(4100, '2024-02-15', 7),
(5300, '2024-02-20', 8);


INSERT INTO POZOSTALI_PRACOWNICY (imie, nazwisko, wyplata, id_placowki, stanowisko) VALUES
('Anna', 'Nowak', 4500, 1, 'Kucharz'),
('Janusz', 'Kowalczyk', 4800, 2, 'Lekarz'),
('Ewa', 'Sikorska', 4600, 1, 'Psycholog'),
('Mateusz', 'Dabrowski', 4700, 2, 'Opiekun'),
('Barbara', 'Kaczmarek', 4900, 1, 'Administrator'),
('Tadeusz', 'Nowosad', 5000, 2, 'Mechanik'),
('Zofia', 'Pawlowska', 5100, 1, 'Ksiegowa');


INSERT INTO ZMIANY (id_zmiany, id_sektor, id_straznika) VALUES
(1, 103, 1),
(2, 105, 5),
(1, 201, 3);
