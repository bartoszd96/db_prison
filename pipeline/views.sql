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

CREATE VIEW stan_cele_1 AS
SELECT 
    c.id_celi, 
    -- Window function to calculate the cell's occupation rate per cell
    COUNT(w.id_wieznia) OVER (PARTITION BY c.id_celi) AS zapelnienie_celi,
    c.pojemnosc_celi,
    z.id_straznika AS pilnujacy_straznik,
    w.id_wieznia, 
    w.imie, 
    w.nazwisko
FROM cele c
LEFT JOIN wiezniowie w ON c.id_celi = w.id_celi
LEFT JOIN zmiany z ON z.id_sektor = c.id_sektor
WHERE c.id_placowki = 1;

CREATE VIEW stan_cele_2 AS
SELECT 
    c.id_celi, 
    -- Window function to calculate the cell's occupation rate per cell
    COUNT(w.id_wieznia) OVER (PARTITION BY c.id_celi) AS zapelnienie_celi,
    c.pojemnosc_celi,
    z.id_straznika AS pilnujacy_straznik,
    w.id_wieznia, 
    w.imie, 
    w.nazwisko
FROM cele c
LEFT JOIN wiezniowie w ON c.id_celi = w.id_celi
LEFT JOIN zmiany z ON z.id_sektor = c.id_sektor
WHERE c.id_placowki = 2;


CREATE OR REPLACE VIEW zmiany_braki AS
SELECT a.id_placowki, a.id_sektor, a.id_zmiany, 'Brak strażnika na zmianie' as Braki FROM (SELECT * FROM sektory s CROSS JOIN (SELECT 1 AS id_zmiany UNION ALL SELECT 2 UNION ALL SELECT 3)) a LEFT OUTER JOIN 
zmiany b ON a.id_sektor = b.id_sektor and a.id_zmiany = b.id_zmiany where (b.id_zmiany is null) or (b.id_straznika is null);
