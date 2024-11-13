unit uLimiteCreditoDAO;

interface

uses
  uConexao,
  uLimiteCreditoModel,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TLimiteCreditoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Inserir(pLimiteCredito: TLimiteCreditoModel): Boolean;
    function Alterar(pLimiteCredito: TLimiteCreditoModel): Boolean;
    function Deletar(pLimiteCredito: TLimiteCreditoModel): Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function Obter: TFDQuery;
    function CarregarLimitesCredito(pProdutorId: Integer): TList<TLimiteCreditoModel>;
    function CarregarLimiteCredito(pProdutorID: Integer): TFDQuery;
  end;

implementation

{ TLimiteCreditoDAO }
uses
  uSistemaController;

constructor TLimiteCreditoDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TLimiteCreditoDAO.Deletar(pLimiteCredito: TLimiteCreditoModel): Boolean;
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
      vQry.SQL.Text := 'DELETE FROM tab_limite_credito WHERE limite_credito_id = :limite_credito_id';
      vQry.ParamByName('limite_credito_id').AsInteger := pLimiteCredito.LimiteCreditoId;
      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do limite de crédito é válido.');
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
      raise Exception.Create('Erro ao deletar o limite de crédito: [' + E.Message + ']');
    end;
  end;
end;

function TLimiteCreditoDAO.GetId(pAutoIncremento: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.Open('SELECT COALESCE(MAX(limite_credito_id), 0) + ' + IntToStr(pAutoIncremento) + ' FROM tab_limite_credito');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TLimiteCreditoDAO.Inserir(pLimiteCredito: TLimiteCreditoModel): Boolean;
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
        'UPDATE tab_limite_credito ' +
        'SET limite_credito      = :limite_credito ' +
        'WHERE limite_credito_id = :limite_credito_id',
        [
          pLimiteCredito.LimiteCredito,
          pLimiteCredito.LimiteCreditoId
        ]
      );

      if vQry.RowsAffected = 0 then
      begin
        vQry.ExecSQL(
          'INSERT INTO tab_limite_credito ( ' +
          '  limite_credito_id, ' +
          '  produtor_id, ' +
          '  distribuidor_id, ' +
          '  limite_credito) ' +
          'VALUES ( ' +
          '  :limite_credito_id, ' +
          '  :produtor_id, ' +
          '  :distribuidor_id, ' +
          '  :limite_credito) ',
          [
            pLimiteCredito.LimiteCreditoId,
            pLimiteCredito.ProdutorId,
            pLimiteCredito.DistribuidorId,
            pLimiteCredito.LimiteCredito
          ]
        );
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
      raise Exception.Create('Erro ao inserir ou atualizar o limite de crédito: ' + E.Message);
    end;
  end;
end;

function TLimiteCreditoDAO.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();

  vQry.Open('SELECT limite_credito_id, produtor_id, distribuidor_id, limite_credito FROM tab_limite_credito ORDER BY limite_credito_id');

  Result := vQry;
end;

function TLimiteCreditoDAO.Alterar(pLimiteCredito: TLimiteCreditoModel): Boolean;
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
        'UPDATE tab_limite_credito SET ' +
        '  produtor_id            = :produtor_id, ' +
        '  distribuidor_id        = :distribuidor_id, ' +
        '  limite_credito         = :limite_credito ' +
        'WHERE limite_credito_id  = :limite_credito_id';

      vQry.ParamByName('produtor_id').AsInteger       := pLimiteCredito.ProdutorId;
      vQry.ParamByName('distribuidor_id').AsInteger   := pLimiteCredito.DistribuidorId;
      vQry.ParamByName('limite_credito').AsCurrency   := pLimiteCredito.LimiteCredito;
      vQry.ParamByName('limite_credito_id').AsInteger := pLimiteCredito.LimiteCreditoId;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código do limite de crédito é válido.');
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
      raise Exception.Create('Erro ao atualizar o limite de crédito: ' + E.Message);
    end;
  end;
end;

function TLimiteCreditoDAO.CarregarLimiteCredito(pProdutorID: Integer): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.SQL.Text :=
      'SELECT tp.produtor_id' +
      '     , tp.nome' +
      '     , tlc.distribuidor_id' +
      '     , SUM(tlc.limite_credito) limite_total' +
      '     , (SELECT tn.valor_total' +
      '          FROM tab_negociacao tn' +
      '         WHERE tn.produtor_id = tp.produtor_id) valor_total' +
      '  FROM tab_produtor tp' +

      ' INNER JOIN tab_limite_credito tlc' +
      ' ON tlc.produtor_id = tp.produtor_id' +

      ' WHERE tp.produtor_id = :produtor_id' +

      ' GROUP BY' +
      '       tp.produtor_id' +
      '     , tp.nome' +
      '     , tlc.distribuidor_id';

    vQry.ParamByName('produtor_id').AsInteger := pProdutorID;
    vQry.Open;

    Result := vQry;
  except
    on E: Exception do
    begin
      vQry.Free;
      raise Exception.Create('Erro ao carregar o limite de crédito: ' + E.Message);
    end;
  end;
end;

function TLimiteCreditoDAO.CarregarLimitesCredito(pProdutorId: Integer): TList<TLimiteCreditoModel>;
var
  vQry           : TFDQuery;
  vLimiteCredito : TLimiteCreditoModel;
  vListaLimites  : TList<TLimiteCreditoModel>;
begin
  vListaLimites := TList<TLimiteCreditoModel>.Create;
  vQry := FConexao.CreateQuery();

  try
    vQry.Open(
      'SELECT tlc.limite_credito_id ' +
      '     , tlc.produtor_id ' +
      '     , tlc.distribuidor_id ' +
      '     , tlc.limite_credito ' +
      '     , td.nome distribuidor ' +
      '  FROM tab_limite_credito tlc ' +

      '  INNER JOIN tab_distribuidor td ' +
      '  ON tlc.distribuidor_id = td.distribuidor_id ' +

      '  WHERE tlc.produtor_id = :ProdutorId',
      [pProdutorId]
    );

    while not vQry.Eof do
    begin
      vLimiteCredito := TLimiteCreditoModel.Create;

      vLimiteCredito.LimiteCreditoId := vQry.FieldByName('limite_credito_id').AsInteger;
      vLimiteCredito.ProdutorId      := vQry.FieldByName('produtor_id').AsInteger;
      vLimiteCredito.DistribuidorId  := vQry.FieldByName('distribuidor_id').AsInteger;
      vLimiteCredito.Distribuidor    := vQry.FieldByName('distribuidor').AsString;
      vLimiteCredito.LimiteCredito   := vQry.FieldByName('limite_credito').AsCurrency;

      vListaLimites.Add(vLimiteCredito);
      vQry.Next;
    end;
    Result := vListaLimites;
  finally
    vQry.Free;
  end;
end;

end.

