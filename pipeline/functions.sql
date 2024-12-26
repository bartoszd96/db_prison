CREATE OR REPLACE FUNCTION DODAJ_WIEZNIA() RETURNS TRIGGER AS $$
DECLARE 
	ile INTEGER;
	pojemnosc INTEGER;
BEGIN
	SELECT count(*) INTO ile FROM wiezniowie w
	WHERE w.id_celi = NEW.id_celi 
	AND w.id_placowki = NEW.id_placowki AND w.data_wyjscia IS NULL;
	
	SELECT p.pojemnosc INTO pojemnosc FROM pomieszcznia p 
	WHERE p.typ_sali = 'cela' AND p.id_sali = NEW.id_sali 
	AND p.id_placowki = NEW.id_placowki;
	
	IF (ile IS NULL) OR (pojemnosc IS NULL) THEN
		RAISE EXCEPTION 'Sprawdz czy dane wejsciowe są poprawne.';
	END IF;
	
	IF ile >= pojemnosc THEN
        RAISE EXCEPTION 'Cela jest już pełna. Nie można dodać więcej więźniów.';
    END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';