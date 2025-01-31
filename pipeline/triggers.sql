CREATE TRIGGER sprawdz_miejsce_w_celi
BEFORE INSERT ON wiezniowie
FOR EACH ROW
EXECUTE FUNCTION DODAJ_WIEZNIA();

CREATE TRIGGER dodaj_id_kontrahent
BEFORE INSERT ON kontrahenci
FOR EACH ROW
EXECUTE FUNCTION DODAJ();

CREATE TRIGGER dodaj_id_straznik
BEFORE INSERT ON straznicy
FOR EACH ROW
EXECUTE FUNCTION DODAJ();

CREATE TRIGGER dodaj_id_pracownik
BEFORE INSERT ON pozostali_pracownicy
FOR EACH ROW
EXECUTE FUNCTION DODAJ();
