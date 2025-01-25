CREATE VIEW wydatki AS
SELECT 
    id_transakcji, 
    k.cena_produktu*kwota, 
    data_transakcji, 
    f.id_odbiorcy, 
    'kontrahent' AS rodzaj_odbiorcy, 
    id_kontrahenta AS id_podmiotu, 
    nazwa AS nazwa_podmiotu
FROM KONTRAHENCI k
JOIN FINANSE f ON f.id_odbiorcy = k.id_odbiorcy

UNION

SELECT 
    id_transakcji, 
    p.wyplata AS kwota, 
    data_transakcji, 
    f.id_odbiorcy, 
    'pracownik administracyjny' AS rodzaj_odbiorcy, 
    id_pracownika AS id_podmiotu, 
    nazwisko AS nazwa_podmiotu
FROM pozostali_pracownicy p
JOIN FINANSE f ON f.id_odbiorcy = p.id_odbiorcy

UNION

SELECT 
    id_transakcji, 
   s.wyplata AS kwota, 
    data_transakcji, 
    f.id_odbiorcy, 
    'straznik' AS rodzaj_odbiorcy, 
    id_straznika AS id_podmiotu, 
    nazwisko AS nazwa_podmiotu
FROM STRAZNICY s
JOIN FINANSE f ON f.id_odbiorcy = s.id_odbiorcy;




CREATE VIEW stan_cele AS
SELECT 
    c.id_celi, 
    COUNT(w.id_wieznia) OVER (PARTITION BY c.id_celi) * 1.0 / c.pojemnosc_celi AS zapelnienie_celi,
	z.id_straznika AS pilnujacy_straznik,
    w.id_wieznia, 
    w.imie, 
    w.nazwisko
FROM cele c
LEFT JOIN wiezniowie w ON c.id_celi = w.id_celi
JOIN zmiany z ON z.id_sektor=c.id_sektor;
