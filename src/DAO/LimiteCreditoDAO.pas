unit LimiteCreditoDAO;

interface

uses LimiteCredito, System.Generics.Collections, FireDAC.Comp.Client, UDM,
  Funcoes;

type
  TLimiteCreditoDAO = class
  public
    procedure Salvar(const LimiteCredito: TLimiteCredito);
    function Buscar(const IdProdutor, IdDistribuidor: integer): Double;
    procedure Atualizar(const LimiteCredito: TLimiteCredito);
  end;

implementation

{ TLimiteCreditoDAO }

procedure TLimiteCreditoDAO.Atualizar(const LimiteCredito: TLimiteCredito);
const
  sSQL = 'update limitecredito SET limitecredito = :limitecredito ' +
         ' WHERE id_produtor = :id_produtor and id_distribuidor = :id_distribuidor';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_produtor').AsInteger      := LimiteCredito.IdProdutor;
    Query.ParamByName('id_distribuidor').AsInteger  := LimiteCredito.IdDistribuidor;
    Query.ParamByName('limitecredito').AsFloat      := LimiteCredito.LimiteCredito;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TLimiteCreditoDAO.Buscar(const IdProdutor, IdDistribuidor: integer): Double;
const
  sSQL = 'select * '+
         'from limitecredito ' +
         'where id_produtor = :id_produtor ' +
         'and id_distribuidor = :id_distribuidor';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_produtor').AsInteger      := IdProdutor;
    Query.ParamByName('id_distribuidor').AsInteger  := IdDistribuidor;
    Query.Open;
    if Query.IsEmpty then
      Result := 0
    else
      Result := Query.FieldByName('limitecredito').AsFloat;
  finally
    Query.Free
  end;
end;

procedure TLimiteCreditoDAO.Salvar(const LimiteCredito: TLimiteCredito);
const
  sSQL = 'insert into limitecredito (id_limitecredito, id_produtor, id_distribuidor, limitecredito) '+
         'values (:id_limitecredito, :id_produtor, :id_distribuidor, :limitecredito)';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_limitecredito').AsInteger := Funcoes.VerificarProxID('limitecredito');
    Query.ParamByName('id_produtor').AsInteger      := LimiteCredito.IdProdutor;
    Query.ParamByName('id_distribuidor').AsInteger  := LimiteCredito.IdDistribuidor;
    Query.ParamByName('limitecredito').AsFloat      := LimiteCredito.LimiteCredito;
    Query.ExecSQL;
  finally
    Query.Free
  end;
end;

end.
