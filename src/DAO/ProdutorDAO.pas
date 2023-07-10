unit ProdutorDAO;

interface

uses Produtor, System.Generics.Collections, FireDAC.Comp.Client, UDM, Funcoes;

type
  TProdutorDAO = class
  public
    procedure Salvar(const Produtor: TProdutor);
    function BuscarTodos: TObjectList<TProdutor>;
    procedure Atualizar(const Produtor: TProdutor);
    procedure Excluir(const ID: integer);
    function BuscarProdutor(const ID: integer): TProdutor;
  end;

implementation

{ TProdutorDAO }

procedure TProdutorDAO.Atualizar(const Produtor: TProdutor);
const
  sSQL = 'update produtor SET nome = :nome, cpfcnpj = :cpfcnpj WHERE id_produtor = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('nome').AsString  := Produtor.Nome;
    Query.ParamByName('cpfcnpj').AsString  := Produtor.CPFCNPJ;
    Query.ParamByName('id').AsInteger   := Produtor.ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TProdutorDAO.BuscarProdutor(const ID: integer): TProdutor;
const
  sSQL = 'select * from produtor where id_produtor = :id';
var
  Query: TFDQuery;
  Produtor: TProdutor;
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
      Produtor := TProdutor.Create(Query.FieldByName('id_produtor').AsInteger, Query.FieldByName('nome').AsString, query.FieldByName('cpfcnpj').AsString);
      Result := Produtor;
    end;
  finally
    Query.Free;
  end;
end;

function TProdutorDAO.BuscarTodos: TObjectList<TProdutor>;
const
  sSQL = 'select * from produtor';
var
  Query: TFDQuery;
  Produtor: TProdutor;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TProdutor>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.Open;
    while not Query.Eof do
    begin
      Produtor := TProdutor.Create(
        Query.FieldByName('id_produtor').AsInteger,
        Query.FieldByName('nome').AsString,
        Query.FieldByName('cpfcnpj').AsString
      );
      Result.Add(Produtor);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TProdutorDAO.Excluir(const ID: integer);
const
  sSQL = 'delete from produtor where id_produtor = :id';
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

procedure TProdutorDAO.Salvar(const Produtor: TProdutor);
const
  sSQL = 'insert into produtor (id_produtor, nome, cpfcnpj) values (:id_produtor, :nome, :cpfcnpj)';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_produtor').AsInteger     := Funcoes.VerificarProxID('produtor');
    query.ParamByName('nome').AsString             := Produtor.Nome;
    Query.ParamByName('cpfcnpj').AsString          := Produtor.CPFCNPJ;
    Query.ExecSQL;
  finally
    Query.Free
  end;
end;

end.
