unit UDAOVinculacaoComercial;

interface

uses FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, SysUtils,
  UControllerConexao, UModelVinculacaoComercial;

type
  TDAOVinculacaoComercial = class
  private

  protected
  public

    function selecionarVinculacaoComercial(modelVinculacaoComercial: TModelVinculacaoComercial): TFDQuery;
    function buscarId(modelVinculacaoComercial: TModelVinculacaoComercial): Integer;
    function incluir(modelVinculacaoComercial: TModelVinculacaoComercial): boolean;
    function excluir(modelVinculacaoComercial: TModelVinculacaoComercial): boolean;
    function alterar(modelVinculacaoComercial: TModelVinculacaoComercial): boolean;
    function getLimiteCredito(modelVinculacaoComercial: TModelVinculacaoComercial): Double;

  published
  end;

implementation

{ TDAOVinculacaoComercial }

function TDAOVinculacaoComercial.alterar(modelVinculacaoComercial: TModelVinculacaoComercial): boolean;
var
  qrVinculacaoComercial: TFDQuery;
begin
  try
    try
      qrVinculacaoComercial := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrVinculacaoComercial.ExecSQL
        ('UPDATE VINCULACAO_COMERCIAL set FK_PRODUTOR = :FK_PRODUTOR, FK_DISTRIBUIDOR = :FK_DISTRIBUIDOR, LIMITE_CREDITO = :LIMITE_CREDITO WHERE ID = :ID',
        [modelVinculacaoComercial.FK_PRODUTOR, modelVinculacaoComercial.FK_DISTRIBUIDOR, modelVinculacaoComercial.LIMITE, modelVinculacaoComercial.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrVinculacaoComercial.Free;
  end;
end;

function TDAOVinculacaoComercial.buscarId(modelVinculacaoComercial: TModelVinculacaoComercial): Integer;
var
  qrVinculacaoComercial: TFDQuery;
begin
  try
    try
      qrVinculacaoComercial := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrVinculacaoComercial.SQL.Text := 'SELECT * from VINCULACAO_COMERCIAL where FK_PRODUTOR = ' +
        IntToStr(modelVinculacaoComercial.FK_PRODUTOR) + ' and FK_DISTRIBUIDOR = ' +
        IntToStr(modelVinculacaoComercial.FK_DISTRIBUIDOR);
      qrVinculacaoComercial.Open();
      if qrVinculacaoComercial.RecordCount > 0 then
        result := strtoint(qrVinculacaoComercial.FieldByName('ID').Text)
      else
        result := 0;
      qrVinculacaoComercial.Close;
    except
      result := 0;
    end;
  finally
    qrVinculacaoComercial.Free;
  end;
end;

function TDAOVinculacaoComercial.excluir(modelVinculacaoComercial: TModelVinculacaoComercial): boolean;
var
  qrVinculacaoComercial: TFDQuery;
begin
  try
    try
      qrVinculacaoComercial := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrVinculacaoComercial.ExecSQL('DELETE from VINCULACAO_COMERCIAL WHERE ID = :ID',
        [modelVinculacaoComercial.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrVinculacaoComercial.Free;
  end;
end;

function TDAOVinculacaoComercial.getLimiteCredito(
  modelVinculacaoComercial: TModelVinculacaoComercial): Double;
var
  qrLimiteCredito: TFDQuery;
begin

  qrLimiteCredito := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrLimiteCredito.Open('Select (v.LIMITE_CREDITO - SUM(n.valor)) AS limite_Disponivel from negociacao n ' + #13 +
                       'inner join vinculacao_comercial v on (v.id = n.fk_vinculacao_comercial) ' + #13 +
                       'where n.FK_VINCULACAO_COMERCIAL = ' + intToStr(modelVinculacaoComercial.ID) + ' group by v.LIMITE_CREDITO, n.valor');
  result := qrLimiteCredito.FieldByName('limite_Disponivel').Value;

end;

function TDAOVinculacaoComercial.incluir(modelVinculacaoComercial: TModelVinculacaoComercial): boolean;
var
  qrVinculacaoComercial: TFDQuery;
begin
  try
    try
      qrVinculacaoComercial := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrVinculacaoComercial.ExecSQL
        ('insert into VINCULACAO_COMERCIAL (FK_PRODUTOR, FK_DISTRIBUIDOR, LIMITE_CREDITO) values (:FK_PRODUTOR, :FK_DISTRIBUIDOR, :LIMITE_CREDITO)',
        [IntToStr(modelVinculacaoComercial.FK_PRODUTOR), IntToStr(modelVinculacaoComercial.FK_DISTRIBUIDOR), modelVinculacaoComercial.LIMITE]);
      result := true;
    except
      result := false;
    end;
  finally
    qrVinculacaoComercial.Free;
  end;
end;


function TDAOVinculacaoComercial.selecionarVinculacaoComercial(modelVinculacaoComercial: TModelVinculacaoComercial): TFDQuery;
var
  qrVinculacaoComercial: TFDQuery;
  SqlAd: String;
begin

  if modelVinculacaoComercial.FK_DISTRIBUIDOR > 0 then
    SqlAd := 'AND v.fk_distribuidor = ' + inttostr(modelVinculacaoComercial.FK_DISTRIBUIDOR)
  else
    SqlAd := '';

  qrVinculacaoComercial := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrVinculacaoComercial.Open('select V.*, D.NOME as Distribuidor from VINCULACAO_COMERCIAL V ' + #13 +
                             'inner join cad_distribuidor D on (d.id = v.fk_distribuidor) ' + #13 +
                             'where v.fk_produtor = ' + intToStr(modelVinculacaoComercial.FK_PRODUTOR) + SqlAd + ' order by D.Nome');
  result := qrVinculacaoComercial;

end;


end.
