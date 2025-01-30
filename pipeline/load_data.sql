INSERT INTO placowki(nazwa, miasto, ulica, nr_budynku, longitude, latitude) VALUES 
('Zaklad karny nr 1 we Wroclawiu', 'Wroclaw', 'Kleczkowska', 35, 51.127434, 17.0269411),
('Zaklad karny w Wolowie', 'Wolow', 'Wiezienna', 6,  51.2581917, 16.5629008);

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


INSERT INTO STRAZNICY (imie, nazwisko, id_placowki, wyplata) VALUES

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



INSERT INTO PRZESTEPSTWA (wykroczenie, stopien_zagrozenia) VALUES
('Kradziez', 2), ('Napad', 3), ('Zabojstwo', 5), ('Handel narkotykami', 4), ('Przekret finansowy', 3), ('Podpalenie', 4), ('Pobicie', 3), ('Falszerstwo', 3), ('Morderstwo', 5), ('Dzielenie przez 0', 1),  ('Zaklocanie porzadku', 1);


INSERT INTO STOLOWKI (id_placowki, pojemnosc_stolowki, id_sektor) VALUES
(1, 50, 103), (2, 40, 202);


INSERT INTO WIEZNIOWIE (imie, nazwisko, pseudonim, id_przestepstwa, data_przybycia, wyrok, gang, id_celi, id_stolowki, adres_zdjecia) VALUES

('Piotr', 'Kowalski', 'Wilk', 1, '2018-05-01', 6, 'Wilki', 1, 1, 'piotr_kowalski.jpg'),
('Adam', 'Nowak', 'Rekin', 2, '2021-07-15', 10, 'Rekiny', 1, 1, 'adam_nowak.jpg'),
('Marek', 'Zielinski', 'Jastrzab', 3, '2009-03-11', 15, 'Orly', 1, 1, 'marek_zielinski.jpg'),
('Tomasz', 'Lis', NULL, 4, '2023-01-25', 8, 'Hieny', 1, 1, 'tomasz_lis.jpg'),


('Sebastian', 'Mazur', 'Tygrys', 6, '2023-03-20', 7, 'Wilki', 2, 1, 'sebastian_mazur.jpg'),
('Grzegorz', 'Nowak', NULL, 8, '2022-04-15', 12, NULL, 2, 1, 'grzegorz_nowak.jpg'),
('Karol', 'Krawczyk', 'Dzik', 5, '2021-02-10', 8, 'Hieny', 2, 1, 'karol_krawczyk.jpg'),
('Artur', 'Kot', NULL, 7, '2022-05-11', 9, NULL, 2, 1, 'artur_kot.jpg'),
('Jakub', 'Lis', 'Orzel', 9, '2020-08-15', 14, 'Wilki', 2, 1, 'jakub_lis.jpg'),


('Andrzej', 'Adamski', 'Wilk', 10, '2023-06-10', 15, 'Rekiny', 3, 1, 'andrzej_adamski.jpg'),
('Bartosz', 'Szymanski', NULL, 3, '2021-03-20', 7, NULL, 3, 1, 'bartosz_szymanski.jpg'),
('Dominik', 'Bielawski', 'Jastrzab', 4, '2022-07-05', 10, 'Orly', 3, 1, 'dominik_bielawski.jpg'),
('Patryk', 'Michalski', 'Sokol', 6, '2021-01-15', 12, 'Zubry', 3, 1, 'patryk_michalski.jpg'),
('Lukasz', 'Mazur', 'Rekin', 5, '2022-11-20', 8, 'Wilki', 3, 1, 'lukasz_mazur.jpg'),
('Tadeusz', 'Wroblewski', NULL, 8, '2023-03-30', 14, NULL, 3, 1, 'tadeusz_wroblewski.jpg'),

  
('Jan', 'Wojcik', 'Lis', 4, '2023-02-10', 12, 'Wilki', 5, 1, 'jan_wojcik.jpg'),
('Maciej', 'Wisniewski', NULL, 5, '2022-08-22', 8, NULL, 5, 1, 'maciej_wisniewski.jpg'),
('Tomasz', 'Adamski', 'Orzel', 6, '2021-05-18', 10, 'Orly', 5, 1, 'tomasz_adamski.jpg'),
('Wojciech', 'Zajac', 'Dzik', 7, '2022-07-15', 6, 'Wilki', 5, 1, 'wojciech_zajac.jpg'),


('Bartlomiej', 'Kot', 'Rekin', 10, '2023-01-05', 18, 'Rekiny', 6, 1, 'bartlomiej_kot.jpg'),
('Grzegorz', 'Lis', 'Wilk', 3, '2021-09-22', 11, 'Wilki', 6, 1, 'grzegorz_lis.jpg'),
('Piotr', 'Mazur', NULL, 4, '2020-06-14', 10, NULL, 6, 1, 'piotr_mazur.jpg'),
('Janusz', 'Adamski', 'Lis', 6, '2022-04-20', 8, 'Wilki', 6, 1, 'janusz_adamski.jpg'),


('Sebastian', 'Zajac', 'Dzik', 6, '2022-09-19', 9, 'Wilki', 16, 2, 'sebastian_zajac.jpg'),
('Adrian', 'Szymanski', 'Wilk', 7, '2021-12-07', 11, 'Wilki', 16, 2, 'adrian_szymanski.jpg'),


('Grzegorz', 'Kot', 'Tygrys', 8, '2023-05-20', 13, 'Tygrysy', 19, 1, 'grzegorz_kot_2.jpg'),
('Patryk', 'Pietrzak', NULL, 9, '2022-01-03', 16, NULL, 19, 1, 'patryk_pietrzak.jpg'),
('Piotr', 'Michalski', 'Harpun', 10, '2021-06-22', 14, 'Rekiny', 19, 1, 'piotr_michalski.jpg'),
('Jan', 'Bielawski', 'Wilk', 3, '2020-03-12', 12, 'Wilki', 19, 1, 'jan_bielawski.jpg'),
('Bartosz', 'Nowak', NULL, 4, '2022-08-15', 7, NULL, 19, 1, 'bartosz_nowak.jpg'),


('Dariusz', 'Kowalski', 'Jastrzab', 5, '2023-02-28', 7, 'Orly', 20, 1, 'dariusz_kowalski.jpg'),
('Marek', 'Zielinski', 'Wilk', 6, '2022-09-20', 10, 'Wilki', 20, 1, 'marek_zielinski_2.jpg'),
('Daniel', 'Adamski', NULL, 9, '2021-10-22', 8, NULL, 20, 1, 'daniel_adamski.jpg');


INSERT INTO MAGAZYNY (id_placowki, pojemnosc_magazynu) VALUES
(1, 100), (2, 120), (1, 90), (1, 100), (2, 130), (2, 100);

INSERT INTO PRODUKTY(typ_produktu, cena_produktu) VALUES 
('Jedzenie', 20), ('Ubrania', 100), ('Artykuly higieniczne', 30), ('Napoje', 10), ('Środki bezpieczeństwa', 150);

INSERT INTO ZAOPATRZENIE(id_produktu, id_magazynu, obecny_stan) VALUES
  (1, 1, 20),
  (1, 2, 13),
  (2, 2, 23), 
  (2, 1, 10), 
  (3, 1, 10), 
  (4, 2, 30), 
  (5, 3, 30), 
  (1, 4, 50);

INSERT INTO KONTRAHENCI(nazwa, id_produktu) VALUES
  ('Nestle', 1), ('Hugo Boss', 2), ('PHU Czysty Dom', 3), ('Dr Pepper Inc.', 4), ('Militaria', 5);

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

(1, 101, 1),
(2, 101, 2),


(1, 102, 3),
(2, 102, 4),
(3, 102, 5),


(1, 103, 6),
(2, 103, 7),


(1, 104, 8),
(2, 104, 9),


(1, 105, 10),
(2, 105, 11),


(1, 201, 18),
(2, 201, 19),
(3, 201, 20),


(1, 202, 21),
(2, 202, 22),


(1, 203, 23),
(2, 203, 24),
(3, 203, 25),


(1, 204, 26),
(2, 204, 27),


(1, 205, 28),
(2, 205, 29),
(3, 205, 30);

