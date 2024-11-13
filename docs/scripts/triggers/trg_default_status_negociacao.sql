-- Trigger para definir o valor padrão do campo status
CREATE TRIGGER trg_default_status_negociacao FOR tab_negociacao
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
  IF (NEW.status IS NULL) THEN
    NEW.status = 'Pendente';

  -- Verifica se o status foi alterado para "Aprovada" e define a data de aprovação
  IF (NEW.status = 'Aprovada' AND OLD.status <> 'Aprovada') THEN
    NEW.data_aprovacao = CURRENT_DATE;  
  
  -- Verifica se o status foi alterado para "Concluida" e define a data de conclusão
  IF (NEW.status = 'Concluida' AND OLD.status <> 'Concluida') THEN
    NEW.data_conclusao = CURRENT_DATE;  

  -- Verifica se o status foi alterado para "Cancelada" e define a data de cancelamento
  IF (NEW.status = 'Cancelada' AND OLD.status <> 'Cancelada') THEN
    NEW.data_cancelamento = CURRENT_DATE;    
END;
