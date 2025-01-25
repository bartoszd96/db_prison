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

CREATE OR REPLACE FUNCTION UZUPELNIJ(id INTEGER)
RETURNS VOID AS $$
DECLARE
    dokupic_1 INTEGER;
    dokupic_2 INTEGER;
    id_odbiorcy INTEGER;
BEGIN

    SELECT COALESCE(z.zapotrzebowanie_jednostkowe - z.obecny_stan, 0)
    INTO dokupic_1
    FROM zaopatrzenie z
    JOIN magazyny m ON z.id_sali=m.id_magazynu
    WHERE z.id_produktu = id AND m.id_placowki=1;

 SELECT COALESCE(z.zapotrzebowanie_jednostkowe - z.obecny_stan, 0)
    INTO dokupic_2
    FROM zaopatrzenie z
    JOIN magazyny m ON z.id_sali=m.id_magazynu
    WHERE z.id_produktu = id AND m.id_placowki=2;


    IF dokupic_1 > 0 THEN
        SELECT o.id_odbiorcy
        INTO id_odbiorcy
        FROM kontrahenci k
        JOIN odbiorcy o ON k.id_odbiorcy = o.id_odbiorcy
        WHERE k.id_produktu = id;

        IF id_odbiorcy IS NOT NULL THEN
            INSERT INTO FINANSE (kwota, data_transakcji, id_odbiorcy)
            VALUES (dokupic_1 * (SELECT cena_produktu FROM zaopatrzenie WHERE id_produktu = id), CURRENT_DATE, id_odbiorcy);
        END IF;
    END IF;

IF dokupic_2 > 0 THEN
        SELECT o.id_odbiorcy
        INTO id_odbiorcy
        FROM kontrahenci k
        JOIN odbiorcy o ON k.id_odbiorcy = o.id_odbiorcy
        WHERE k.id_produktu = id
        LIMIT 1;

        IF id_odbiorcy IS NOT NULL THEN
            INSERT INTO FINANSE (kwota, data_transakcji, id_odbiorcy)
            VALUES (dokupic_2 * (SELECT cena_produktu FROM zaopatrzenie WHERE id_produktu = id LIMIT 1), CURRENT_DATE, id_odbiorcy);
        END IF;
    END IF;
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

CREATE OR REPLACE FUNCTION WYSWIETL_OBECNYCH_WIEZNIOW(id_placowki_z INTEGER) RETURNS TABLE AS $$
BEGIN
RETURN
	SELECT *
	FROM wiezniowie w
	WHERE w.id_placowki=id_placowki_z AND w.data_wyjscia IS NOT NULL;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION WYSWIETL_BYŁYCH_WIEZNIOW(id_placowki_z INTEGER) RETURNS TABLE AS $$
BEGIN
RETURN
	SELECT *
	FROM wiezniowie w
	WHERE w.id_placowki=id_placowki_z AND w.data_wyjscia IS NULL;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION WYSWIETL_STRAZNIKOW(id_placowki_z INTEGER) RETURNS TABLE AS $$
BEGIN
RETURN
	SELECT *
	FROM straznicy
	WHERE w.id_placowki=id_placowki_z;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION WYSWIETL_PRACOWNIKOW(id_placowki_z INTEGER) RETURNS TABLE AS $$
BEGIN
RETURN
	SELECT *
	FROM pozostali_pracownicy
	WHERE w.id_placowki=id_placowki_z;
END;
$$ LANGUAGE 'plpgsql';
