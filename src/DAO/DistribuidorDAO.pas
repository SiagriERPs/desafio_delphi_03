unit DistribuidorDAO;

interface

uses Distribuidor, FireDAC.Comp.Client, UDM, System.Generics.Collections;

type
  TDistribuidorDAO = class
  public
    procedure Salvar(const Distribuidor: TDistribuidor);
    function BuscarTodos: TObjectList<TDistribuidor>;
    procedure Atualizar(const Distribuidor: TDistribuidor);
    procedure Excluir(const ID: integer);
    function BuscarDistribuidor(const ID: integer): TDistribuidor;
  end;

implementation

{ TDistribuidorDAO }

uses Funcoes;


procedure TDistribuidorDAO.Atualizar(const Distribuidor: TDistribuidor);
const
  sSQL = 'update distribuidor SET nome = :nome, cnpj = :cnpj WHERE id_distribuidor = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('nome').AsString  := Distribuidor.Nome;
    Query.ParamByName('cnpj').AsString  := Distribuidor.CNPJ;
    Query.ParamByName('id').AsInteger   := Distribuidor.ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TDistribuidorDAO.BuscarDistribuidor(const ID: integer): TDistribuidor;
const
  sSQL = 'select * from distribuidor where id_distribuidor = :id';
var
  Query: TFDQuery;
  Distribuidor: TDistribuidor;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := ID;
    Query.Open;
    if not Query.IsEmpty then
    begin
      Distribuidor := TDistribuidor.Create(Query.FieldByName('id_distribuidor').AsInteger, Query.FieldByName('nome').AsString, query.FieldByName('cnpj').AsString);
      Result := Distribuidor;
    end;
  finally
    Query.Free;
  end;
end;

function TDistribuidorDAO.BuscarTodos: TObjectList<TDistribuidor>;
const
  sSQL = 'select * from distribuidor';
var
  Query: TFDQuery;
  Distribuidor: TDistribuidor;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TDistribuidor>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.Open;
    while not Query.Eof do
    begin
      Distribuidor := TDistribuidor.Create(
        Query.FieldByName('id_distribuidor').AsInteger,
        Query.FieldByName('nome').AsString,
        Query.FieldByName('cnpj').AsString
      );
      Result.Add(Distribuidor);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TDistribuidorDAO.Excluir(const ID: integer);
const
  sSQL = 'delete from distribuidor where id_distribuidor = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TDistribuidorDAO.Salvar(const Distribuidor: TDistribuidor);
const
  sSQL = 'insert into distribuidor(id_distribuidor, nome, cnpj) values (:id_distribuidor, :nome, :cnpj)';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_distribuidor').AsInteger := Funcoes.VerificarProxID('distribuidor');
    query.ParamByName('nome').AsString             := Distribuidor.Nome;
    Query.ParamByName('cnpj').AsString             := Distribuidor.CNPJ;
    Query.ExecSQL;
  finally
    Query.Free
  end;
end;

end.
