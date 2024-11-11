unit uDistribuidorDAO;

interface

uses
  uConexao,
  uDistribuidorModel,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client;

type
  TDistribuidorDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Inserir(pDistribuidor: TDistribuidorModel): Boolean;
    function Alterar(pDistribuidor: TDistribuidorModel): Boolean;
    function Deletar(pDistribuidor: TDistribuidorModel): Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function Obter: TFDQuery;
  end;

implementation

{ TProdutoDAO }

uses
  uSistemaController;

constructor TDistribuidorDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TDistribuidorDAO.Deletar(pDistribuidor: TDistribuidorModel): Boolean;
var
  vQry: TFDQuery;
  vCountNegociacao: Integer;
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
      vQry.SQL.Text := 'SELECT COUNT(*) as qtd FROM tab_negociacao WHERE distribuidor_id = :distribuidor_id';
      vQry.ParamByName('distribuidor_id').AsInteger := pDistribuidor.Id;
      vQry.Open;

      vCountNegociacao := vQry.Fields[0].AsInteger;

      if vCountNegociacao > 0 then
      begin
        raise Exception.Create('Este distribuidor está vinculado a um ou mais negociações e não pode ser excluído.');
      end;

      vQry.SQL.Text := 'DELETE FROM tab_distribuidor WHERE distribuidor_id = :distribuidor_id';
      vQry.ParamByName('distribuidor_id').AsInteger := pDistribuidor.Id;
      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do distribuidor é válido.');
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
      raise Exception.Create('Erro ao deletar o distribuidor: [' + E.Message + ']');
    end;
  end;
end;

function TDistribuidorDAO.GetId(pAutoIncremento: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.Open('SELECT COALESCE(MAX(distribuidor_id), 0) + ' + IntToStr(pAutoIncremento) + ' FROM tab_distribuidor');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TDistribuidorDAO.Inserir(pDistribuidor: TDistribuidorModel): Boolean;
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
        'INSERT INTO tab_distribuidor (' +
        '  distribuidor_id, ' +
        '  nome, ' +
        '  cnpj) ' +
        'VALUES (' +
        '  :distribuidor_id,' +
        '  :nome,' +
        '  :cnpj) ',
        [
          pDistribuidor.Id,
          pDistribuidor.Nome,
          pDistribuidor.CpfCnpj
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
      raise Exception.Create('Erro ao inserir o distribuidor: ' + E.Message);
    end;
  end;
end;

function TDistribuidorDAO.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();

  vQry.Open('SELECT distribuidor_id, nome, cnpj FROM tab_distribuidor ORDER BY distribuidor_id');

  Result := vQry;
end;

function TDistribuidorDAO.Alterar(pDistribuidor: TDistribuidorModel): Boolean;
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
        'UPDATE tab_distribuidor SET ' +
        '  nome  = :nome, ' +
        '  cnpj  = :cnpj ' +
        'WHERE distribuidor_id = :distribuidor_id';

      vQry.ParamByName('nome').AsString             := pDistribuidor.Nome;
      vQry.ParamByName('cnpj').AsString             := pDistribuidor.CpfCnpj;
      vQry.ParamByName('distribuidor_id').AsInteger := pDistribuidor.Id;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do distribuidor é válido.');
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
      raise Exception.Create('Erro ao atualizar o distribuidor: ' + E.Message);
    end;
  end;
end;

end.
