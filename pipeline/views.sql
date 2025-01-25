CREATE VIEW wydatki AS
SELECT 
    id_transakcji, 
    kwota, 
    data_transakcji, 
    f.id_odbiorcy, 
    'kontrahent' AS status, 
    id_kontrahenta AS id_podmiotu, 
    nazwa AS nazwa_podmiotu
FROM KONTRAHENCI k
JOIN FINANSE f ON f.id_odbiorcy = k.id_odbiorcy

UNION

SELECT 
    id_transakcji, 
    kwota, 
    data_transakcji, 
    f.id_odbiorcy, 
    'pracownik administracyjny' AS status, 
    id_pracownika AS id_podmiotu, 
    nazwisko AS nazwa_podmiotu
FROM pozostali_pracownicy p
JOIN FINANSE f ON f.id_odbiorcy = p.id_odbiorcy

UNION

SELECT 
    id_transakcji, 
    kwota, 
    data_transakcji, 
    f.id_odbiorcy, 
    'straznik' AS status, 
    id_straznika AS id_podmiotu, 
    nazwisko AS nazwa_podmiotu
FROM STRAZNICY s
JOIN FINANSE f ON f.id_odbiorcy = s.id_odbiorcy;
