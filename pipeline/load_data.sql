INSERT INTO placowki(nazwa, adres, longitude, latitude) VALUES 
('Zakład karny nr 1 we Wrocławiu', 'Kleczkowska 35, Wrocław 50-211', 51.127434, 17.0269411),
('Zakład karny w Wołowie', 'Więzienna 6, Wołow 56-100', 51.2581917, 16.5629008);

INSERT INTO straznicy(id_placowki, wyplata) VALUES 
(1, 7500), (1, 5000), (1, 6000), (1, 5000), (1, 5500), (1, 5000), (2, 5000), (2, 4500), (2, 5000), (2, 5500), (2, 7000), (2, 6000);

INSERT INTO pomieszczenia(id_placowki, typ_sali, pojemnosc_magazynu, pojemnosc_celi, id_straznika_1, id_straznika_2, id_straznika_3) VALUES 
(1, 'cela', NULL, 6, 1, 2, 3), (1, 'cela', NULL, 6, 4, 5, 6), (2, 'cela', NULL, 4, 7, 8, 9), (2, 'cela', NULL, 4, 10, 11, 12);

INSERT INTO PRZESTEPSTWA (wykroczenie, stopien_zagrozenia)
VALUES 
    ('Kradzież', 2),
    ('Podpalenie', 4),
    ('Napad', 5),
    ('Włamanie', 3),
    ('Oszustwa podatkowe', 1),
    ('Pobicie', 3),
    ('Fałszerstwo', 3),
    ('Przemyt', 4),
    ('Morderstwo', 5),
    ('Dzielenie przez 0', 1),
    ('Zakłócanie porządku', 1);
	
INSERT INTO WIEZNIOWIE (id_wieznia, imie, nazwisko, pseudonim, wykroczenie, data_przybycia, wyrok, gang, id_celi, id_stolowki, id_placowki, data_wyjscia, adres_zdjecia)
VALUES
    (1, 'Jan', 'Kowalski', 'Janek Spryciarz', 'Kradzież', '2024-01-01', 2, 'Gang Kieszonkowców', 1, 1, 1, NULL, 'zdjecie1.jpg'),
    (2, 'Adam', 'Nowak', 'Podpalacz', 'Podpalenie', '2024-02-15', 5, 'Gang Płomienia', 1, 1, 1, NULL, 'zdjecie2.jpg'),
    (3, 'Paweł', 'Wiśniewski', 'Napadator', 'Napad', '2024-03-10', 7, 'Napadacze', 1, 1, 1, NULL, 'zdjecie3.jpg'),
    (4, 'Karol', 'Zieliński', 'Włamywacz', 'Włamanie', '2024-04-20', 4, 'Gang Złodziei', 1, 1, 1, NULL, 'zdjecie4.jpg'),
    (5, 'Michał', 'Wójcik', 'Fałszerz', 'Fałszerstwo', '2024-05-25', 3, 'Fałszerze Profesjonalni', 1, 1, 1, NULL, 'zdjecie5.jpg'),
    (6, 'Tomasz', 'Kamiński', 'Przemytnik', 'Przemyt', '2024-06-30', 6, 'Gang Przemytników', 1, 1, 1, NULL, 'zdjecie6.jpg');
    (7, 'Piotr', 'Lewandowski', 'Chemik', 'Morderstwo', '2024-07-15', 8, 'Pospolity gang', 1, 1, 1, NULL, 'zdjecie7.jpg'),
    (8, 'Anna', 'Wiśniewska', 'Królowa Fałszerzy', 'Fałszerstwo', '2024-08-01', 3, 'Fałszerze Profesjonalni', 1, 1, 1, NULL, 'zdjecie8.jpg'),
    (9, 'Katarzyna', 'Zając', 'Podpalaczka', 'Podpalenie', '2024-09-10', 5, 'Gang Płomienia', 1, 1, 1, NULL, 'zdjecie9.jpg'),
    (10, 'Grzegorz', 'Mazur', NULL, 'Zakłócanie porządku', '2024-10-05', 1, NULL, 1, 1, 1, NULL, 'zdjecie10.jpg'),
    (11, 'Marcin', 'Dąbrowski', 'Matematyk', 'Dzielenie przez 0', '2024-11-15', 1, 'Gang Paradoksu', 1, 1, 1, NULL, 'zdjecie11.jpg'),
    (12, 'Dominik', 'Kowalczyk', 'Włamywacz Junior', 'Włamanie', '2024-12-20', 4, 'Gang Złodziei', 1, 1, 1, NULL, 'zdjecie12.jpg'),
    (13, 'Agnieszka', 'Pawlak', 'Przemytniczka', 'Przemyt', '2025-01-03', 6, 'Gang Przemytników', 1, 1, 1, NULL, 'zdjecie13.jpg'),
    (14, 'Łukasz', 'Sokołowski', 'Napadnik', 'Napad', '2025-01-15', 7, 'Napadacze', 1, 1, 1, NULL, 'zdjecie14.jpg'),
    (15, 'Joanna', 'Czarnecka', 'Oszuściara', 'Oszustwa podatkowe', '2025-02-10', 1, 'Gang Finansiści', 1, 1, 1, NULL, 'zdjecie15.jpg'),
    (16, 'Barbara', 'Krawczyk', NULL, 'Kradzież', '2025-03-05', 2, NULL, 1, 1, 1, NULL, 'zdjecie16.jpg'),
    (17, 'Krzysztof', 'Piotrowski', 'Piroman', 'Podpalenie', '2025-04-10', 5, 'Gang Płomienia', 1, 1, 1, NULL, 'zdjecie17.jpg'),
    (18, 'Sylwia', 'Włodarczyk', 'Fałszerka', 'Fałszerstwo', '2025-05-15', 3, 'Fałszerze Profesjonalni', 1, 1, 1, NULL, 'zdjecie18.jpg'),
    (19, 'Marek', 'Król', 'Napadacz', 'Napad', '2025-06-20', 7, 'Napadacze', 1, 1, 1, NULL, 'zdjecie19.jpg'),
    (20, 'Ewelina', 'Szymańska', 'Przemytniczka', 'Przemyt', '2025-07-25', 6, 'Gang Przemytników', 1, 1, 1, NULL, 'zdjecie20.jpg'),
    (21, 'Patryk', 'Głowacki', 'Matematyk Chaosu', 'Dzielenie przez 0', '2025-08-30', 1, 'Gang Paradoksu', 1, 1, 1, NULL, 'zdjecie21.jpg'),
    (22, 'Rafał', 'Chmielewski', 'Zakłócacz Ciszy', 'Zakłócanie porządku', '2025-09-15', 1, 'Gang Hałasu', 1, 1, 1, NULL, 'zdjecie22.jpg'),
    (23, 'Beata', 'Jabłońska', 'Włamywaczka', 'Włamanie', '2025-10-10', 4, 'Gang Złodziei', 1, 1, 1, NULL, 'zdjecie23.jpg'),
    (24, 'Wojciech', 'Lis', 'Mistrz Fałszerstw', 'Fałszerstwo', '2025-11-20', 3, 'Fałszerze Profesjonalni', 1, 1, 1, NULL, 'zdjecie24.jpg'),
    (25, 'Natalia', 'Nowicka', 'Podpalaczka Pro', 'Podpalenie', '2025-12-25', 5, 'Gang Płomienia', 1, 1, 1, NULL, 'zdjecie25.jpg');
	
-- TEST triggera dodaj wieznia
	
INSERT INTO WIEZNIOWIE (id_wieznia, imie, nazwisko, pseudonim, wykroczenie, data_przybycia, wyrok, gang, id_celi, id_stolowki, id_placowki, data_wyjscia, adres_zdjecia)
VALUES
	 (26, 'Krzysztof', 'Lewandowski', 'Zakłócacz', 'Zakłócanie porządku', '2024-07-15', 1, 'Gang Hałasowników', 1, 1, 1, NULL, 'zdjecie7.jpg');
	
-- TEST triggera dodaj cele

INSERT INTO pomieszczenia(id_placowki, typ_sali, pojemnosc_magazynu, pojemnosc_celi, id_straznika_1, id_straznika_2, id_straznika_3) VALUES 
(1, 'cela', NULL, 6, 7, 8, 9);

-- TEST transfer_wieznia

select transfer_wieznia(1, 1, 1, 2, 1); -- powinno nie przejsc

select transfer_wieznia(1, 1, 1, 2, 2); -- powinno przejsc
