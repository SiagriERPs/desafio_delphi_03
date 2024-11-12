unit DistribuidorDAO;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  System.Generics.Collections,
  FireDAC.Comp.UI,
  uDMConexao,
  uDistribuidor;

type
  TDistribuidorDAO = class
  private
    FConn: TFDConnection;
  public
    constructor Create;
    procedure Inserir(const Nome, CNPJ: string);
    function PesquisarTodos: TObjectList<TDistribuidor>;
  end;

implementation

constructor TDistribuidorDAO.Create;
begin
  FConn := TDMConexao.GetInstance.GetConnection;
end;

procedure TDistribuidorDAO.Inserir(const Nome, CNPJ: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConn;
    Query.SQL.Text :=
      'INSERT INTO Distribuidor (nome, cnpj) VALUES (:nome, :cnpj)';
    Query.Params.ParamByName('nome').AsString := Nome;
    Query.Params.ParamByName('cnpj').AsString := CNPJ;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TDistribuidorDAO.PesquisarTodos: TObjectList<TDistribuidor>;
var
  Query: TFDQuery;
  Distribuidor: TDistribuidor;
  Lista: TObjectList<TDistribuidor>;
begin
  Lista := TObjectList<TDistribuidor>.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConn;
    Query.SQL.Text := 'SELECT id, nome, cnpj FROM distribuidor';
    Query.Open;
    while not Query.Eof do
    begin
      Distribuidor := TDistribuidor.Create(Query.FieldByName('id').AsInteger, Query.FieldByName('nome').AsString, Query.FieldByName('cnpj').AsString);
      Distribuidor.id := Query.FieldByName('id').AsInteger;
      Distribuidor.Nome := Query.FieldByName('nome').AsString;
      Distribuidor.CNPJ := Query.FieldByName('cnpj').AsString;
      Lista.Add(Distribuidor);
      Query.Next;
    end;
    Result := Lista;
  finally
    Query.Free;
  end;
end;

end.
