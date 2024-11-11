unit uProdutoDAO;

interface

uses
  uConexao,
  uProdutoModel,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client;

type
  TProdutoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Inserir(pProduto: TProdutoModel): Boolean;
    function Alterar(pProduto: TProdutoModel): Boolean;
    function Deletar(pProduto: TProdutoModel): Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function Obter: TFDQuery;
  end;

implementation

{ TProdutoDAO }

uses
  uSistemaController;

constructor TProdutoDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TProdutoDAO.Deletar(pProduto: TProdutoModel): Boolean;
var
  vQry: TFDQuery;
  vCountItensNegociacao: Integer;
begin
  Result := False;
  if not FConexao.GetConn.Connected then
  begin
    raise Exception.Create('A conexão com o banco de dados não está ativa.');
    Exit;
  end;

  FConexao.StartTransaction;
  try
    vQry := FConexao.CreateQuery;
    try
      vQry.SQL.Text := 'SELECT COUNT(*) as qtd FROM tab_item_negociacao WHERE produto_id = :produto_id';
      vQry.ParamByName('produto_id').AsInteger := pProduto.Id;
      vQry.Open;

      vCountItensNegociacao := vQry.Fields[0].AsInteger;

      if vCountItensNegociacao > 0 then
      begin
        raise Exception.Create('Este produto está vinculado a um ou mais negociações e não pode ser excluído.');
      end;

      vQry.SQL.Text := 'DELETE FROM tab_produto WHERE produto_id = :produto_id';
      vQry.ParamByName('produto_id').AsInteger := pProduto.Id;
      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do produto é válido.');
      end;

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao deletar o produto: [' + E.Message + ']');
    end;
  end;
end;

function TProdutoDAO.GetId(pAutoIncremento: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.Open('SELECT COALESCE(MAX(produto_id), 0) + ' + IntToStr(pAutoIncremento) + ' FROM tab_produto');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TProdutoDAO.Inserir(pProduto: TProdutoModel): Boolean;
var
  vQry: TFDQuery;
begin
  if not FConexao.GetConn.Connected then
  begin
    raise Exception.Create('A conexão com o banco de dados não está ativa.');
    Exit;
  end;

  FConexao.StartTransaction;
  try
    vQry := FConexao.CreateQuery;
    try
      vQry.ExecSQL(
        'INSERT INTO tab_produto (' +
        '  produto_id, ' +
        '  nome, ' +
        '  preco_venda) ' +
        'VALUES (' +
        '  :produto_id,' +
        '  :nome,' +
        '  :preco_venda) ',
        [
          pProduto.Id,
          pProduto.Nome,
          pProduto.PrecoVenda
        ]
      );

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao inserir o produto: ' + E.Message);
    end;
  end;
end;

function TProdutoDAO.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();

  vQry.Open('SELECT produto_id, nome, preco_venda FROM tab_produto ORDER BY produto_id');

  Result := vQry;
end;

function TProdutoDAO.Alterar(pProduto: TProdutoModel): Boolean;
var
  vQry: TFDQuery;
begin
  Result := False;
  if not FConexao.GetConn.Connected then
  begin
    raise Exception.Create('A conexão com o banco de dados não está ativa.');
    Exit;
  end;

  FConexao.StartTransaction;
  try
    vQry := FConexao.CreateQuery();
    try
      vQry.SQL.Text :=
        'UPDATE tab_produto SET ' +
        '  nome           = :nome, ' +
        '  preco_venda    = :preco_venda ' +
        'WHERE produto_id = :produto_id';

      vQry.ParamByName('nome').AsString        := pProduto.Nome;
      vQry.ParamByName('preco_venda').AsFloat  := pProduto.PrecoVenda;
      vQry.ParamByName('produto_id').AsInteger := pProduto.Id;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do produto é válido.');
      end;

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao atualizar o produto: ' + E.Message);
    end;
  end;
end;

end.
