unit ProdutorDAO;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  System.Generics.Collections,
  FireDAC.Comp.UI,
  uDMConexao,
  uProdutor;

type
  TProdutorDAO = class
  private
    FConn: TFDConnection;
  public
    constructor Create;
    procedure Inserir(const Nome, CNPJ: string);
    function PesquisarTodos: TObjectList<TProdutor>;
  end;

implementation

constructor TProdutorDAO.Create;
begin
  FConn := TDMConexao.GetInstance.GetConnection;
end;

procedure TProdutorDAO.Inserir(const Nome, CNPJ: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConn;
    Query.SQL.Text :=
      'insert into produtor (nome, cnpj) values (:nome, :cnpj)';
    Query.Params.ParamByName('nome').AsString := Nome;
    Query.Params.ParamByName('cnpj').AsString := CNPJ;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TProdutorDAO.PesquisarTodos: TObjectList<TProdutor>;
var
  Query: TFDQuery;
  Produtor: TProdutor;
  Lista: TObjectList<TProdutor>;
begin
  Lista := TObjectList<TProdutor>.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConn;
    Query.SQL.Text := 'select id, nome, cnpj from produtor';
    Query.Open;
    while not Query.Eof do
    begin
      Produtor := TProdutor.Create(Query.FieldByName('id').AsInteger, Query.FieldByName('nome').AsString, Query.FieldByName('cnpj').AsString);
      Produtor.id := Query.FieldByName('id').AsInteger;
      Produtor.Nome := Query.FieldByName('nome').AsString;
      Produtor.CPFCNPJ := Query.FieldByName('cnpj').AsString;
      Lista.Add(Produtor);
      Query.Next;
    end;
    Result := Lista;
  finally
    Query.Free;
  end;
end;

end.
