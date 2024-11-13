unit uNegociacaoDAO;

interface

uses
  uConexao,
  uNegociacaoModel,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client;

type
  TNegociacaoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Inserir(pNegociacao: TNegociacaoModel): Boolean;
    function Alterar(pNegociacao: TNegociacaoModel): Boolean;
    function Deletar(pNegociacao: TNegociacaoModel): Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function Obter: TFDQuery;
  end;

implementation

{ TNegociacaoDAO }

uses
  uSistemaController;

constructor TNegociacaoDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TNegociacaoDAO.Deletar(pNegociacao: TNegociacaoModel): Boolean;
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
    vQry := FConexao.CreateQuery;
    try
      vQry.SQL.Text := 'DELETE FROM tab_negociacao WHERE negociacao_id = :negociacao_id';
      vQry.ParamByName('negociacao_id').AsInteger := pNegociacao.Id;
      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código da negociação é válida.');
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
      raise Exception.Create('Erro ao deletar a negociação : [' + E.Message + ']');
    end;
  end;
end;

function TNegociacaoDAO.GetId(pAutoIncremento: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.Open('SELECT COALESCE(MAX(negociacao_id), 0) + ' + IntToStr(pAutoIncremento) + ' FROM tab_negociacao');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TNegociacaoDAO.Inserir(pNegociacao: TNegociacaoModel): Boolean;
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
      vQry.SQL.Text :=
        'INSERT INTO tab_negociacao ( ' +
        '  negociacao_id, ' +
        '  produtor_id, ' +
        '  distribuidor_id, ' +
        '  data_cadastro, ' +
        '  data_aprovacao, ' +
        '  data_conclusao, ' +
        '  data_cancelamento, ' +
        '  status, ' +
        '  valor_total) ' +
        ' VALUES ( '+
        '  :negociacao_id,' +
        '  :produtor_id, ' +
        '  :distribuidor_id, ' +
        '  :data_cadastro, ' +
        '  :data_aprovacao, ' +
        '  :data_conclusao, ' +
        '  :data_cancelamento, ' +
        '  :status, ' +
        '  :valor_total) ';

      vQry.ParamByName('negociacao_id').AsInteger   := pNegociacao.Id;
      vQry.ParamByName('produtor_id').AsInteger     := pNegociacao.ProdutorId;
      vQry.ParamByName('distribuidor_id').AsInteger := pNegociacao.DistribuidorId;
      vQry.ParamByName('data_cadastro').AsDateTime  := pNegociacao.DataCadastro;
      vQry.ParamByName('data_aprovacao').Clear;
      vQry.ParamByName('data_conclusao').Clear;
      vQry.ParamByName('data_cancelamento').Clear;
      vQry.ParamByName('status').AsString           := pNegociacao.Status;
      vQry.ParamByName('valor_total').AsFloat       := pNegociacao.ValorTotal;

      vQry.ExecSQL;

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao inserir a negociação: ' + E.Message);
    end;
  end;
end;

function TNegociacaoDAO.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();

  vQry.Open('SELECT negociacao_id, produtor_id, distribuidor_id, status, valor_total FROM tab_negociacao ORDER BY negociacao_id');

  Result := vQry;
end;

function TNegociacaoDAO.Alterar(pNegociacao: TNegociacaoModel): Boolean;
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
        'UPDATE tab_negociacao SET ' +
        '  produtor_id           = :produtor_id, ' +
        '  distribuidor_id       = :distribuidor_id, ' +
        '  valor_total           = :valor_total ' +
        'WHERE negociacao_id     = :negociacao_id';

      vQry.ParamByName('produtor_id').AsInteger     := pNegociacao.ProdutorId;
      vQry.ParamByName('distribuidor_id').AsInteger := pNegociacao.distribuidorId;
      vQry.ParamByName('valor_total').AsCurrency    := pNegociacao.ValorTotal;
      vQry.ParamByName('negociacao_id').AsInteger   := pNegociacao.Id;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código da negociação é válido.');
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
      raise Exception.Create('Erro ao atualizar o código da negociação: ' + E.Message);
    end;
  end;
end;

end.
