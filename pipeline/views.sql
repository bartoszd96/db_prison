CREATE VIEW wydatki AS
SELECT 
    f.id_transakcji, 
    p.cena_produktu*kwota, 
    f.data_transakcji, 
    f.id_odbiorcy, 
    'kontrahent' AS rodzaj_odbiorcy, 
    k.nazwa AS nazwa_podmiotu
FROM KONTRAHENCI k
JOIN FINANSE f ON f.id_odbiorcy = k.id_odbiorcy
JOIN PRODUKTY p ON p.id_produktu = k.id_produktu

UNION

SELECT 
    f.id_transakcji, 
    p.wyplata AS kwota, 
    f.data_transakcji, 
    f.id_odbiorcy, 
    'pracownik administracyjny' AS rodzaj_odbiorcy, 
    p.nazwisko AS nazwa_podmiotu
FROM pozostali_pracownicy p
JOIN FINANSE f ON f.id_odbiorcy = p.id_odbiorcy

UNION

SELECT 
    f.id_transakcji, 
   s.wyplata AS kwota, 
    f.data_transakcji, 
    f.id_odbiorcy, 
    'straznik' AS rodzaj_odbiorcy, 
    s.nazwisko AS nazwa_podmiotu
FROM STRAZNICY s
JOIN FINANSE f ON f.id_odbiorcy = s.id_odbiorcy;

CREATE VIEW oblozenie_cele AS
SELECT 
    c.id_celi, 
    c.id_placowki,
    COUNT(w.id_wieznia) OVER (PARTITION BY c.id_celi) AS zapelnienie_celi,
    c.pojemnosc_celi
FROM cele c
LEFT JOIN wiezniowie w ON c.id_celi = w.id_celi;


CREATE VIEW oblozenie_stolowki AS
SELECT 
    s.id_stolowki, 
    s.id_placowki,
    t.zapelnienie,
    s.pojemnosc_stolowki
FROM stolowki s
LEFT JOIN (select w.id_stolowki, count(w.id_wieznia) as zapelnienie from wiezniowie w group by id_stolowki) t ON s.id_stolowki = t.id_stolowki;

CREATE VIEW oblozenie_magazynu AS
SELECT 
    m.id_magazynu, 
    m.id_placowki,
    n.obecny_stan, --OVER (PARTITION BY m.id_magazynu) AS zapelnienie_magazynu,
    m.pojemnosc_magazynu
FROM magazyny m
LEFT JOIN (select z.id_magazynu, sum(z.obecny_stan) as obecny_stan from zaopatrzenie z group by id_magazynu) n ON n.id_magazynu = m.id_magazynu;


CREATE OR REPLACE VIEW zmiany_braki AS
SELECT a.id_placowki, a.id_sektor, a.id_zmiany, 'Brak strażnika na zmianie' as Braki FROM (SELECT * FROM sektory s CROSS JOIN (SELECT 1 AS id_zmiany UNION ALL SELECT 2 UNION ALL SELECT 3)) a LEFT OUTER JOIN 
zmiany b ON a.id_sektor = b.id_sektor and a.id_zmiany = b.id_zmiany where (b.id_zmiany is null) or (b.id_straznika is null);


CREATE VIEW lista_pracownikow AS
SELECT 
 'straznik' AS rodzaj_pracownika,
 id_straznika,
 id_odbiorcy, 
 imie,
 nazwisko,
 id_placowki,
 wyplata
FROM straznicy

UNION

SELECT 
 stanowisko AS rodzaj_pracownika,
 id_pracownika,
 id_odbiorcy, 
 imie,
 nazwisko,
 id_placowki,
 wyplata
FROM pozostali_pracownicy;
