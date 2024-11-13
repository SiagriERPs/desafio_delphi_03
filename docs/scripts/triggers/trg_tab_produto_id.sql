CREATE TRIGGER trg_tab_produto_id FOR tab_produto
BEFORE INSERT
AS
BEGIN
  IF (NEW.produto_id IS NULL) THEN
    NEW.produto_id = GEN_ID(gen_tab_produto_id, 1);
END;