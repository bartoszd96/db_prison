CREATE VIEW AS wydatki
SELECT id_transakcji, kwota, data_transakcji, id_odbiorcy, 'kontrahent' AS status, id_kontrahenta, nazwa
FROM KONTRAHENCI k
JOIN FINANSE f ON f.id_odbiorcy=k.id_odbiorcy;
UNION
SELECT id_transakcji, kwota, data_transakcji, id_odbiorcy, 'pracownik administracyjny' AS status, id_pracownika, nazwisko, id_odbiorcy, nazwisko
FROM pozostali_pracownicy p
JOIN FINANSE f ON f.id_odbiorcy=p.id_odbiorcy;
UNION
SELECT id_transakcji, kwota, data_transakcji, id_odbiorcy, 'straznik' AS status, id_straznika, nazwisko
FROM STRAZNICY s
JOIN FINANSE f ON f.id_odbiorcy=s.id_odbiorcy;
