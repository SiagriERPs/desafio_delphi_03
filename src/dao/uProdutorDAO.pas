unit uProdutorDAO;

interface

uses
  uConexao,
  uProdutorModel,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client;

type
  TProdutorDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Inserir(pProdutor: TProdutorModel): Boolean;
    function Alterar(pProdutor: TProdutorModel): Boolean;
    function Deletar(pProdutor: TProdutorModel): Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function Obter: TFDQuery;
  end;


implementation

{ TProdutorDAO }

uses
  uSistemaController;

constructor TProdutorDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TProdutorDAO.Deletar(pProdutor: TProdutorModel): Boolean;
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
      vQry.SQL.Text := 'SELECT COUNT(*) as qtd FROM tab_negociacao WHERE produtor_id = :produtor_id';
      vQry.ParamByName('produtor_id').AsInteger := pProdutor.Id;
      vQry.Open;

      vCountNegociacao := vQry.Fields[0].AsInteger;

      if vCountNegociacao > 0 then
      begin
        raise Exception.Create('Este produtor está vinculado a um ou mais negociações e não pode ser excluído.');
      end;

      vQry.SQL.Text := 'DELETE FROM tab_produtor WHERE produtor_id = :produtor_id';
      vQry.ParamByName('produtor_id').AsInteger := pProdutor.Id;
      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do produtor é válido.');
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
      raise Exception.Create('Erro ao deletar o produtor: [' + E.Message + ']');
    end;
  end;
end;

function TProdutorDAO.GetId(pAutoIncremento: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.Open('SELECT COALESCE(MAX(produtor_id), 0) + ' + IntToStr(pAutoIncremento) + ' FROM tab_produtor');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TProdutorDAO.Inserir(pProdutor: TProdutorModel): Boolean;
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
        'INSERT INTO tab_produtor (' +
        '  produtor_id, ' +
        '  nome, ' +
        '  cpf_cnpj, ' +
        '  limite_credito) ' +
        'VALUES (' +
        '  :produtor_id,' +
        '  :nome,' +
        '  :cpf_cnpj,' +
        '  :limite_credito) ',
        [
          pProdutor.Id,
          pProdutor.Nome,
          pProdutor.CpfCnpj,
          pProdutor.LimiteCredito
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
      raise Exception.Create('Erro ao inserir o produtor: ' + E.Message);
    end;
  end;
end;

function TProdutorDAO.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();

  vQry.Open('SELECT produtor_id, nome, cpf_cnpj, limite_credito FROM tab_produtor ORDER BY produtor_id');

  Result := vQry;
end;

function TProdutorDAO.Alterar(pProdutor: TProdutorModel): Boolean;
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
        'UPDATE tab_produtor SET ' +
        '  nome            = :nome, ' +
        '  cpf_cnpj        = :cpf_cnpj, ' +
        '  limite_credito  = :limite_credito ' +
        'WHERE produtor_id = :produtor_id';

      vQry.ParamByName('nome').AsString          := pProdutor.Nome;
      vQry.ParamByName('cpf_cnpj').AsString      := pProdutor.CpfCnpj;
      vQry.ParamByName('limite_credito').AsFloat := pProdutor.LimiteCredito;
      vQry.ParamByName('produtor_id').AsInteger  := pProdutor.Id;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do produtor é válido.');
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
      raise Exception.Create('Erro ao atualizar o produtor: ' + E.Message);
    end;
  end;
end;

end.
