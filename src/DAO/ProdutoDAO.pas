unit ProdutoDAO;

interface

uses Produto, System.Generics.Collections, FireDAC.Comp.Client, UDM, Funcoes;

type
  TProdutoDAO = class
  public
    procedure Salvar(const Produto: TProduto);
    function BuscarTodos: TObjectList<TProduto>;
    procedure Atualizar(const Produto: TProduto);
    procedure Excluir(const ID: integer);
    function BuscarProduto(const ID: integer): TProduto;
  end;

implementation

{ TProdutoDAO }

{ TProdutoDAO }

procedure TProdutoDAO.Atualizar(const Produto: TProduto);
const
  sSQL = 'update produto SET nome = :nome, preco = :preco WHERE id_produto = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('nome').AsString  := Produto.Nome;
    Query.ParamByName('preco').AsFloat  := Produto.Preco;
    Query.ParamByName('id').AsInteger   := Produto.ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TProdutoDAO.BuscarProduto(const ID: integer): TProduto;
const
  sSQL = 'select * from produto where id_produto = :id';
var
  Query: TFDQuery;
  Produto: TProduto;
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
      Produto := TProduto.Create(Query.FieldByName('id_produto').AsInteger, Query.FieldByName('nome').AsString, Query.FieldByName('preco').AsFloat);
      Result  := Produto;
    end;
  finally
    Query.Free;
  end;
end;

function TProdutoDAO.BuscarTodos: TObjectList<TProduto>;
const
  sSQL = 'select * from produto';
var
  Query: TFDQuery;
  Produto: TProduto;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TProduto>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.Open;
    while not Query.Eof do
    begin
      Produto := TProduto.Create(
        Query.FieldByName('id_produto').AsInteger,
        Query.FieldByName('nome').AsString,
        Query.FieldByName('preco').AsFloat
      );
      Result.Add(Produto);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TProdutoDAO.Excluir(const ID: integer);
const
  sSQL = 'delete from produto where id_produto = :id';
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

procedure TProdutoDAO.Salvar(const Produto: TProduto);
const
  sSQL = 'insert into produto (id_produto, nome, preco) values (:id_produto, :nome, :preco)';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_produto').AsInteger      := Funcoes.VerificarProxID('produto');
    query.ParamByName('nome').AsString             := Produto.Nome;
    Query.ParamByName('preco').AsFloat             := Produto.Preco;
    Query.ExecSQL;
  finally
    Query.Free
  end;
end;

end.
