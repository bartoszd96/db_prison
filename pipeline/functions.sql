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
        RAISE EXCEPTION 'Cela jest już pełna. Nie można dodać więcej więźniów.';
    END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION DODAJ_CELE() RETURNS TRIGGER AS $$
DECLARE 
	Z1 INTEGER;
	Z2 INTEGER;
	Z3 INTEGER;
BEGIN
	
	SELECT s.zmiana INTO Z1 FROM straznicy s 
	WHERE s.id_straznika = NEW.id_straznika_1 and s.id_placowki = NEW.id_placowki;
	
	SELECT s.zmiana INTO Z2 FROM straznicy s 
	WHERE s.id_straznika = NEW.id_straznika_2 and s.id_placowki = NEW.id_placowki;
	
	SELECT s.zmiana INTO Z3 FROM straznicy s 
	WHERE s.id_straznika = NEW.id_straznika_3 and s.id_placowki = NEW.id_placowki;
	
	IF (Z1 = 1) AND (Z2 = 2) AND (Z3 = 3) THEN 
		RETURN NEW;
	ELSE 
		RAISE EXCEPTION 'Błąd w danych, albo któryś strażnik nie istnieje, albo próbowano przypisać do go złej zmiany';
	END IF;
END;
$$ LANGUAGE 'plpgsql';

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
		RAISE EXCEPTION 'Niepoprawne dane, upewnij się czy więzień jest w danej celi, oraz że cela do której chcesz go przenieść istnieje i ma wolne miejsce';
	END IF;
	
	IF (transferowany = 1) AND (pojemnosc_out > ile_out) THEN 
		INSERT INTO TRANSFERY(id_celi_in, id_celi_out, id_wieznia) 
		VALUES (cela_in, cela_out, id_w);
		
		UPDATE wiezniowie SET  id_celi = cela_out 
		WHERE id_wieznia = id_w;
		
	ELSE 
		RAISE EXCEPTION 'Niepoprawne dane, upewnij się czy więzień jest w danej placówce i celi, oraz że cela do której chcesz go przenieść istnieje i ma wolne miejsce';
	END IF;
	
END;
$$ LANGUAGE 'plpgsql';


//przetestowac
CREATE OR REPLACE FUNCTION NOWA_PLACOWKA(id_placowki_z INTEGER, nazwa_z VARCHAR(100), miasto_z VARCHAR(100), ulica_z VARCHAR(100), nr_budynku_z INTEGER , longitude_z DECIMAL(9, 7),
 latitude_z DECIMAL(9, 7) RETURNS VOID AS $$

BEGIN
	
	IF (id_p IS NULL) OR (nazwa IS NULL) or (miasto IS NULL) OR (ulica IS NULL) or (nr_budynku IS NULL) or (longitude IS NULL) or (latitude IS NULL) THEN
		RAISE EXCEPTION 'Niepoprawne dane, upewnij się czy na pewno wpisałeś nazwę, miasto i ulicę (słowa) oraz numer budynku i obie współrzędne (liczby)';
	END IF;
	
	IF (SELECT * FROM placowki p
	WHERE p.id_placowki = id_placowki_z OR p.nazwa = nazwa_z OR (p.miasto=miasto_z AND p.ulica=ulica_z AND p.nr_budynku=nr_budynku_z) OR (p.longitude=longitude_z AND p.latitude=latitude_z) IS NOT NULL THEN 
		RAISE EXCEPTION 'Niepoprawne dane, istnieje już placówka o tym numerze/nazwie/adresie/współrzędnych';
        ELSE
		INSERT INTO PLACOWKI(id_placowki, nazwa, miasto, ulica, nr_budynku, longitude, latitude) 
		VALUES (id_placowki_z, nazwa_z, miasto_z, ulica_z, nr_budynku_z, longitude_z, latitude_z);

INSERT INTO CELE(id_celi, id_placowki, pojemnosc_celi) 
		VALUES (1, id_placowki_z, 2);

INSERT INTO MAGAZYNY(id_magazynu, id_placowki, pojemnosc_magazynu) 
		VALUES (1, id_placowki_z, 20);

INSERT INTO STOLOWKI(id_stolowki, id_placowki, pojemnosc_stolowki) 
		VALUES (1, id_placowki_z, 20);

	END IF;

	
END;
$$ LANGUAGE 'plpgsql';

//przetestowac

