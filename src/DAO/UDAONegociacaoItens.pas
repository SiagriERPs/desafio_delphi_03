unit UDAONegociacaoItens;

interface

uses FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, SysUtils,
  UControllerConexao, UModelNegociacaoItens;

type
  TDAONegociacaoItens = class
  private

  protected
  public
    function selecionarNegociacaoItens(modelNegociacaoItens: TModelNegociacaoItens): TFDQuery;

    function buscarId(modelNegociacaoItens: TModelNegociacaoItens): Integer;

    function validar(modelNegociacaoItens: TModelNegociacaoItens): boolean;
    function incluir(modelNegociacaoItens: TModelNegociacaoItens): boolean;
    function excluir(modelNegociacaoItens: TModelNegociacaoItens): boolean;


  published
  end;

implementation

{ TDAONegociacaoItens }



function TDAONegociacaoItens.buscarId(modelNegociacaoItens: TModelNegociacaoItens): Integer;
var
  qrNegociacaoItens: TFDQuery;
begin
  try
    try
      qrNegociacaoItens := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacaoItens.SQL.Text := 'Select * from NEGOCIACAO_PRODUTOS where FK_NEGOCIACAO = ' +
        IntToStr(modelNegociacaoItens.FK_NEGOCIACAO) +
        ' and FK_PRODUTO = ' + FloatToStr(modelNegociacaoItens.FK_PRODUTO);
      qrNegociacaoItens.Open();
      if qrNegociacaoItens.RecordCount > 0 then
        result := strtoint(qrNegociacaoItens.FieldByName('ID').Text);
      qrNegociacaoItens.Close;
    except
      result := 0;
    end;
  finally
    qrNegociacaoItens.Free;
  end;
end;

function TDAONegociacaoItens.excluir(modelNegociacaoItens: TModelNegociacaoItens): boolean;
var
  qrNegociacaoItens: TFDQuery;
begin
  try
    try
      qrNegociacaoItens := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacaoItens.ExecSQL('DELETE from NEGOCIACAO_PRODUTOS WHERE ID = :ID',
        [modelNegociacaoItens.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrNegociacaoItens.Free;
  end;
end;

function TDAONegociacaoItens.incluir(modelNegociacaoItens: TModelNegociacaoItens): boolean;
var
  qrNegociacaoItens: TFDQuery;
begin
  try
    try
      qrNegociacaoItens := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacaoItens.ExecSQL
        ('insert into NEGOCIACAO_PRODUTOS (FK_NEGOCIACAO, FK_PRODUTO, VALOR_UN, QTD, VALOR_TOTAL) values (:FK_NEGOCIACAO, :FK_PRODUTO, :VALOR_UN, :QTD, :VALOR_TOTAL)',
        [modelNegociacaoItens.FK_NEGOCIACAO, modelNegociacaoItens.FK_PRODUTO, modelNegociacaoItens.VALOR_UN, modelNegociacaoItens.QTD, modelNegociacaoItens.VALOR_TOTAL]);
      result := true;
    except
      result := false;
    end;
  finally
    qrNegociacaoItens.Free;
  end;
end;

function TDAONegociacaoItens.selecionarNegociacaoItens(modelNegociacaoItens: TModelNegociacaoItens): TFDQuery;
var
  qrNegociacaoItens: TFDQuery;
begin

  qrNegociacaoItens := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrNegociacaoItens.Open('Select np.*, p.descricao from negociacao_produtos np ' +
                    'inner join cad_produto p on (p.id = np.fk_produto) ' +
                    'where np.FK_NEGOCIACAO = ' + intToStr(modelNegociacaoItens.FK_NEGOCIACAO));
  result := qrNegociacaoItens;

end;

function TDAONegociacaoItens.validar(modelNegociacaoItens: TModelNegociacaoItens): boolean;
var
  qrNegociacaoItens: TFDQuery;
begin
  result := true;
  try
    try
      qrNegociacaoItens := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrNegociacaoItens.SQL.Text := 'Select * from NegociacaoItens where FK_NEGOCIACAO = ' +
        IntToStr(modelNegociacaoItens.FK_NEGOCIACAO) + ' AND FK_PRODUTO = ' + IntToStr(modelNegociacaoItens.FK_PRODUTO);
      qrNegociacaoItens.Open();
      if qrNegociacaoItens.RecordCount > 0 then
        result := false;
      qrNegociacaoItens.Close;
    except
      result := false;
    end;
  finally
    qrNegociacaoItens.Free;
  end;
end;

end.
