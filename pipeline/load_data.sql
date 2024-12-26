INSERT INTO placowki(nazwa, adres, longitude, latitude) VALUES 
('Zakład karny nr 1 we Wrocławiu', 'Kleczkowska 35, Wrocław 50-211', 51.127434, 17.0269411),
('Zakład karny w Wołowie', 'Więzienna 6, Wołow 56-100', 51.2581917, 16.5629008);

INSERT INTO straznicy(zmiana, id_placowki, wyplata) VALUES 
(1, 1, 5000), (2, 1, 5000), (3, 1, 5000), (1, 1, 5000), (2, 1, 5000), (3, 1, 5000), (1, 2, 5000), (2, 2, 5000), (3, 2, 5000), (1, 2, 5000), (2, 2, 5000), (3, 2, 5000);

INSERT INTO pomieszczenia(id_placowki, typ_sali, pojemnosc_magazynu, pojemnosc_celi, id_straznika_1, id_straznika_2, id_straznika_3) VALUES 
(1, 'cela', NULL, 6, 1, 2, 3), (1, 'cela', NULL, 6, 4, 5, 6), (2, 'cela', NULL, 4, 7, 8, 9), (2, 'cela', NULL, 4, 10, 11, 12);

INSERT INTO PRZESTEPSTWA (wykroczenie, stopien_zagrozenia)
VALUES 
    ('Kradzież', 2),
    ('Podpalenie', 4),
    ('Napad', 5),
    ('Włamanie', 3),
    ('Fałszerstwo', 3),
    ('Przemyt', 4),
    ('Zakłócanie porządku', 1);
	
INSERT INTO WIEZNIOWIE (id_wieznia, imie, nazwisko, pseudonim, wykroczenie, data_przybycia, wyrok, gang, id_celi, id_stolowki, id_placowki, data_wyjscia, adres_zdjecia)
VALUES
    (1, 'Jan', 'Kowalski', 'Janek Spryciarz', 'Kradzież', '2024-01-01', 2, 'Gang Kieszonkowców', 1, 1, 1, NULL, 'zdjecie1.jpg'),
    (2, 'Adam', 'Nowak', 'Podpalacz', 'Podpalenie', '2024-02-15', 5, 'Gang Płomienia', 1, 1, 1, NULL, 'zdjecie2.jpg'),
    (3, 'Paweł', 'Wiśniewski', 'Napadator', 'Napad', '2024-03-10', 7, 'Napadacze', 1, 1, 1, NULL, 'zdjecie3.jpg'),
    (4, 'Karol', 'Zieliński', 'Włamywacz', 'Włamanie', '2024-04-20', 4, 'Gang Złodziei', 1, 1, 1, NULL, 'zdjecie4.jpg'),
    (5, 'Michał', 'Wójcik', 'Fałszerz', 'Fałszerstwo', '2024-05-25', 3, 'Fałszerze Profesjonalni', 1, 1, 1, NULL, 'zdjecie5.jpg'),
    (6, 'Tomasz', 'Kamiński', 'Przemytnik', 'Przemyt', '2024-06-30', 6, 'Gang Przemytników', 1, 1, 1, NULL, 'zdjecie6.jpg');
	
-- TEST triggera dodaj wieznia
	
INSERT INTO WIEZNIOWIE (id_wieznia, imie, nazwisko, pseudonim, wykroczenie, data_przybycia, wyrok, gang, id_celi, id_stolowki, id_placowki, data_wyjscia, adres_zdjecia)
VALUES
	 (7, 'Krzysztof', 'Lewandowski', 'Zakłócacz', 'Zakłócanie porządku', '2024-07-15', 1, 'Gang Hałasowników', 1, 1, 1, NULL, 'zdjecie7.jpg');
	
-- TEST triggera dodaj cele

INSERT INTO pomieszczenia(id_placowki, typ_sali, pojemnosc_magazynu, pojemnosc_celi, id_straznika_1, id_straznika_2, id_straznika_3) VALUES 
(1, 'cela', NULL, 6, 7, 8, 9);

-- TEST transfer_wieznia

select transfer_wieznia(1, 1, 1, 2, 1); -- powinno nie przejsc

select transfer_wieznia(1, 1, 1, 2, 2); -- powinno przejsc