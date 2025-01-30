CREATE OR REPLACE FUNCTION DODAJ_WIEZNIA() RETURNS TRIGGER AS $$
DECLARE 
	ile INTEGER;
	pojemnosc INTEGER;
BEGIN
	SELECT count(*) INTO ile FROM wiezniowie w
	WHERE w.id_celi = NEW.id_celi AND w.data_wyjscia IS NULL;
	
	SELECT p.pojemnosc_celi INTO pojemnosc FROM cele p 
	WHERE p.id_celi = NEW.id_celi;
	
	IF (ile IS NULL) OR (pojemnosc IS NULL) THEN
		RAISE EXCEPTION 'Sprawdz czy dane wejsciowe są poprawne.';
	END IF;
	
	IF ile >= pojemnosc THEN
        RAISE EXCEPTION 'Cela jest juz pelna. Nie można dodać wiecej wiezniow.';
    END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION DODAJ() RETURNS TRIGGER AS $$
DECLARE 
	ido INTEGER;
BEGIN
	SELECT max(o.id_odbiorcy) + 1 INTO ido FROM odbiorcy o;
	
	IF ido IS NULL THEN 
	ido = 1;
	END IF;
	
	INSERT INTO odbiorcy VALUES(ido);
	
	NEW.id_odbiorcy = ido;
	
	RETURN NEW;
END
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION UZUPELNIJ(id_p INTEGER, amt INTEGER, id_m INTEGER)
RETURNS VOID AS $$
DECLARE
	ids_p INTEGER[];
	ids_m INTEGER[];
	curr_amt INTEGER;
	curr_cap INTEGER;
	id_o INTEGER;
	cena INTEGER;
	record_check INTEGER;
BEGIN

SELECT ARRAY(SELECT p.id_produktu FROM produkty p) INTO ids_p;
SELECT ARRAY(SELECT m.id_magazynu FROM magazyny m) INTO ids_m;

IF NOT (id_p = ANY(ids_p)) THEN
	RAISE EXCEPTION 'Produkt o takim id nie istnieje';
END IF;

IF NOT (id_m = ANY(ids_m)) THEN
	RAISE EXCEPTION 'Magazyn o takim id nie istnieje';
END IF;

SELECT sum(z.obecny_stan) INTO curr_amt FROM zaopatrzenie z WHERE z.id_magazynu = id_m;

IF curr_amt IS NULL THEN
	curr_amt = 0;
END IF;

SELECT m.pojemnosc_magazynu INTO curr_cap FROM magazyny m WHERE (m.id_magazynu = id_m);

IF curr_cap < curr_amt + amt THEN
	RAISE EXCEPTION 'Nie możesz tyle zamówić, nie starczy miejsca w magazynie';
END IF;

SELECT count(z.id_produktu) INTO record_check FROM zaopatrzenie z WHERE (z.id_produktu = id_p) and (z.id_magazynu = id_m);

IF record_check = 0 THEN
	INSERT INTO zaopatrzenie(id_produktu, id_magazynu, obecny_stan) VALUES(id_p, id_m, amt);
ELSE
	UPDATE zaopatrzenie SET obecny_stan = obecny_stan + amt WHERE (id_produktu=id_p) and (id_magazynu = id_m);
END IF;

SELECT k.id_odbiorcy INTO id_o FROM kontrahenci k WHERE k.id_produktu = id_p;
SELECT p.cena_produktu into cena FROM produkty p WHERE p.id_produktu = id_p;

INSERT INTO finanse(kwota, data_transakcji, id_odbiorcy) VALUES (amt*cena, '2025-01-25', id_o);
 
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION TRANSFER_WIEZNIA(id_w INTEGER, cela_in INTEGER, cela_out INTEGER) RETURNS VOID AS $$
DECLARE
	transferowany INTEGER;
	ile_out INTEGER;
	pojemnosc_out INTEGER;
BEGIN
	
	SELECT count(*) INTO transferowany FROM wiezniowie w 
	WHERE w.id_wieznia = id_w AND w.id_celi = cela_in;
	
	SELECT count(*) INTO ile_out FROM wiezniowie w
	WHERE w.id_celi = cela_out 
	AND w.data_wyjscia IS NULL;
	
	SELECT p.pojemnosc_celi INTO pojemnosc_out FROM cele p 
	WHERE p.id_celi = cela_out ;
	
	IF (ile_out IS NULL) OR (pojemnosc_out IS NULL) THEN
		RAISE EXCEPTION 'Niepoprawne dane, upewnij sie czy wiezien jest w danej celi, oraz ze cela do ktorej chcesz go przeniesc istnieje i ma wolne miejsce';
	END IF;
	
	IF (transferowany = 1) AND (pojemnosc_out > ile_out) THEN 
		INSERT INTO TRANSFERY(id_celi_in, id_celi_out, id_wieznia, data_transferu) 
		VALUES (cela_in, cela_out, id_w, '2025-01-25');
		
		UPDATE wiezniowie SET  id_celi = cela_out 
		WHERE id_wieznia = id_w;
		
	ELSE 
		RAISE EXCEPTION 'Niepoprawne dane, upewnij sie czy wiezien jest w danej placowce i celi, oraz ze cela do ktorej chcesz go przeniesc istnieje i ma wolne miejsce';
	END IF;
	
END;
$$ LANGUAGE 'plpgsql';
