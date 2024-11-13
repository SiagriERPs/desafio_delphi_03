unit uStatusDAO;

interface

uses
  uConexao,
  uEnumerado,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  uBiblioteca;

type
  TStatusDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    procedure AtualizarStatus(const pNegociacaoId: Integer; const NovoStatus: TStatus);

    function ObterStatusNegociacao(const pNegociacaoId: Integer): string;
  end;

implementation

{ TStatusDao }

uses
  uSistemaController;

constructor TStatusDao.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TStatusDao.ObterStatusNegociacao(const pNegociacaoId: Integer): string;
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
    Result := 'Pendente';

    vQry := FConexao.CreateQuery();
    try
      vQry.SQL.Text :=
        'SELECT status FROM tab_negociacao WHERE negociacao_id = :negociacao_id';

      vQry.ParamByName('negociacao_id').AsInteger  := pNegociacaoId;

      vQry.Open;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do contrato "Negociação" é válido.');
      end;

      Result := vQry.FieldByName('status').AsString;
      FConexao.CommitTransaction;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao obter o status da negociação: ' + E.Message);
    end;
  end;
end;

procedure TStatusDao.AtualizarStatus(
  const pNegociacaoId: Integer;
  const NovoStatus: TStatus);
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
    vQry := FConexao.CreateQuery();
    try
      vQry.SQL.Text :=
        'UPDATE tab_negociacao SET ' +
        '  status            = :status ' +
        'WHERE negociacao_id = :negociacao_id';

      vQry.ParamByName('status').AsString          := uBiblioteca.GetStringStatus(NovoStatus);
      vQry.ParamByName('negociacao_id').AsInteger  := pNegociacaoId;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do contrato "Negociação" é válido.');
      end;

      FConexao.CommitTransaction;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao atualizar o status da negociação: ' + E.Message);
    end;
  end;
end;

end.
