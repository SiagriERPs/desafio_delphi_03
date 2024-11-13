-- Trigger para tab_distribuidor
CREATE TRIGGER trg_tab_distribuidor_id FOR tab_distribuidor
BEFORE INSERT
AS
BEGIN
  IF (NEW.distribuidor_id IS NULL) THEN
    NEW.distribuidor_id = GEN_ID(gen_tab_distribuidor_id, 1);
END;