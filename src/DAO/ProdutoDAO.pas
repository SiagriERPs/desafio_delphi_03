unit ProdutoDAO;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  System.Generics.Collections,
  FireDAC.Comp.UI,
  uDMConexao,
  uProduto;

type
  TProdutoDAO = class
  private
    FConn: TFDConnection;
  public
    constructor Create;
    procedure Inserir(const Nome: string; PrecoVenda: currency);
    function PesquisarTodos: TObjectList<TProduto>;
  end;

implementation

constructor TProdutoDAO.Create;
begin
  FConn := TDMConexao.GetInstance.GetConnection;
end;

procedure TProdutoDAO.Inserir(const Nome: string; PrecoVenda: currency);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConn;
    Query.SQL.Text :=
      'insert into produto (nome, precovenda) values (:nome, :precovenda)';
    Query.Params.ParamByName('nome').AsString := Nome;
    Query.Params.ParamByName('precovenda').AsCurrency := PrecoVenda;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TProdutoDAO.PesquisarTodos: TObjectList<TProduto>;
var
  Query: TFDQuery;
  Produto: TProduto;
  Lista: TObjectList<TProduto>;
begin
  Lista := TObjectList<TProduto>.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConn;
    Query.SQL.Text := 'select id, nome, precovenda from produto';
    Query.Open;
    while not Query.Eof do
    begin
      Produto := TProduto.Create(Query.FieldByName('id').AsInteger, Query.FieldByName('nome').AsString, Query.FieldByName('precovenda').AsCurrency);
      Produto.id := Query.FieldByName('id').AsInteger;
      Produto.Nome := Query.FieldByName('nome').AsString;
      Produto.PrecoVenda := Query.FieldByName('precovenda').AsCurrency;
      Lista.Add(Produto);
      Query.Next;
    end;
    Result := Lista;
  finally
    Query.Free;
  end;
end;

end.
