unit UDAONegociacao;

interface

uses FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, SysUtils,
  UControllerConexao, UModelNegociacao;

type
  TDAONegociacao = class
  private

  protected
  public
    function selecionarNegociacao: TFDQuery;

    function buscarId(modelNegociacao: TModelNegociacao): Integer;

    function validar(modelNegociacao: TModelNegociacao): boolean;
    function incluir(modelNegociacao: TModelNegociacao): boolean;
    function excluir(modelNegociacao: TModelNegociacao): boolean;
    function alterar(modelNegociacao: TModelNegociacao): boolean;

  published
  end;

implementation

{ TDAONegociacao }

function TDAONegociacao.alterar(modelNegociacao: TModelNegociacao): boolean;
var
  qrNegociacao: TFDQuery;
begin
  try
    try
      qrNegociacao := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacao.ExecSQL
        ('UPDATE NEGOCIACAO set FK_VINCULACAO_COMERCIAL = :FK_VINCULACAO_COMERCIAL, VALOR = :VALOR, STATUS = :STATUS WHERE ID = :ID',
        [modelNegociacao.FK_VINCULACAO_COMERCIAL, modelNegociacao.VALOR, modelNegociacao.STATUS, modelNegociacao.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrNegociacao.Free;
  end;
end;

function TDAONegociacao.buscarId(modelNegociacao: TModelNegociacao): Integer;
var
  qrNegociacao: TFDQuery;
begin
  try
    try
      qrNegociacao := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacao.SQL.Text := 'Select * from NEGOCIACAO where FK_VINCULACAO_COMERCIAL = ' +
        IntToStr(modelNegociacao.FK_VINCULACAO_COMERCIAL) +
        ' and VALOR = ' + FloatToStr(modelNegociacao.VALOR);
      qrNegociacao.Open();
      if qrNegociacao.RecordCount > 0 then
        result := strtoint(qrNegociacao.FieldByName('ID').Text);
      qrNegociacao.Close;
    except
      result := 0;
    end;
  finally
    qrNegociacao.Free;
  end;
end;

function TDAONegociacao.excluir(modelNegociacao: TModelNegociacao): boolean;
var
  qrNegociacao: TFDQuery;
begin
  try
    try
      qrNegociacao := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacao.ExecSQL('DELETE from NEGOCIACAO WHERE ID = :ID',
        [modelNegociacao.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrNegociacao.Free;
  end;
end;

function TDAONegociacao.incluir(modelNegociacao: TModelNegociacao): boolean;
var
  qrNegociacao: TFDQuery;
begin
  try
    try
      qrNegociacao := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacao.ExecSQL
        ('insert into NEGOCIACAO (FK_VINCULACAO_COMERCIAL, VALOR, STATUS) values (:FK_VINCULACAO_COMERCIAL, :VALOR, :STATUS)',
        [modelNegociacao.FK_VINCULACAO_COMERCIAL, modelNegociacao.VALOR, modelNegociacao.STATUS]);
      result := true;
    except
      result := false;
    end;
  finally
    qrNegociacao.Free;
  end;
end;

function TDAONegociacao.selecionarNegociacao: TFDQuery;
var
  qrNegociacao: TFDQuery;
begin

  qrNegociacao := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrNegociacao.Open('select n.*, p.nome as Produtor, d.nome as Distribuidor ' +
                    'from NEGOCIACAO n ' +
                    'inner join vinculacao_comercial v on (v.id = n.fk_vinculacao_comercial)' +
                    'inner join cad_produtor p on (p.id = v.fk_produtor)' +
                    'inner join cad_distribuidor d on (d.id = v.fk_distribuidor)' +
                    'order by Produtor');
  result := qrNegociacao;

end;

function TDAONegociacao.validar(modelNegociacao: TModelNegociacao): boolean;
var
  qrNegociacao: TFDQuery;
begin
  result := true;
  try
    try
      qrNegociacao := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacao.SQL.Text := 'Select * from NEGOCIACAO where FK_VINCULACAO_COMERCIAL = ' +
        IntToStr(modelNegociacao.FK_VINCULACAO_COMERCIAL) + ' AND VALOR = ' + FloatToStr(modelNegociacao.VALOR);
      qrNegociacao.Open();
      if qrNegociacao.RecordCount > 0 then
        result := false;
      qrNegociacao.Close;
    except
      result := false;
    end;
  finally
    qrNegociacao.Free;
  end;
end;

end.
