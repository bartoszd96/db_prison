CREATE TRIGGER sprawdz_miejsce_w_celi
BEFORE INSERT ON wiezniowie
FOR EACH ROW
EXECUTE FUNCTION DODAJ_WIEZNIA();

CREATE TRIGGER sprawdz_zmiany_straznikow
BEFORE INSERT ON pomieszczenia
FOR EACH ROW
EXECUTE FUNCTION DODAJ_CELE();

