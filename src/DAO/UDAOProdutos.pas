unit UDAOProdutos;

interface

uses FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, SysUtils,
  UControllerConexao, UModelprodutos;

type
  TDAOprodutos = class
  private

  protected
  public
    function selecionarprodutos: TFDQuery;

    function buscarId(modelprodutos: TModelprodutos): Integer;

    function validar(modelprodutos: TModelprodutos): boolean;
    function incluir(modelprodutos: TModelprodutos): boolean;
    function excluir(modelprodutos: TModelprodutos): boolean;
    function alterar(modelprodutos: TModelprodutos): boolean;

  published
  end;

implementation

{ TDAOprodutos }

function TDAOprodutos.alterar(modelprodutos: TModelprodutos): boolean;
var
  qrprodutos: TFDQuery;
begin
  try
    try
      qrprodutos := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrprodutos.ExecSQL
        ('UPDATE Cad_produto set DESCRICAO = :DESCRICAO, PRECO_VENDA = :PRECO_VENDA WHERE ID = :ID',
        [uppercase(modelprodutos.DESCRICAO), modelprodutos.PRECO_VENDA, modelprodutos.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrprodutos.Free;
  end;
end;

function TDAOprodutos.buscarId(modelprodutos: TModelprodutos): Integer;
var
  qrprodutos: TFDQuery;
begin
  try
    try
      qrprodutos := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrprodutos.SQL.Text := 'Select * from Cad_produto where DESCRICAO = ' +
        QuotedStr(uppercase(modelprodutos.DESCRICAO)) +
        ' and PRECO_VENDA = ' + quotedStr(FloatToStr(modelprodutos.PRECO_VENDA));
      qrprodutos.Open();
      if qrprodutos.RecordCount > 0 then
        result := strtoint(qrprodutos.FieldByName('ID').Text);
      qrprodutos.Close;
    except
      result := 0;
    end;
  finally
    qrprodutos.Free;
  end;
end;

function TDAOprodutos.excluir(modelprodutos: TModelprodutos): boolean;
var
  qrprodutos: TFDQuery;
begin
  try
    try
      qrprodutos := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrprodutos.ExecSQL('DELETE from Cad_produto WHERE ID = :ID',
        [modelprodutos.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrprodutos.Free;
  end;
end;

function TDAOprodutos.incluir(modelprodutos: TModelprodutos): boolean;
var
  qrprodutos: TFDQuery;
begin
  try
    try
      qrprodutos := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrprodutos.ExecSQL
        ('insert into Cad_produto (DESCRICAO, PRECO_VENDA) values (:DESCRICAO, :PRECO_VENDA)',
        [uppercase(modelprodutos.DESCRICAO), modelprodutos.PRECO_VENDA]);
      result := true;
    except
      result := false;
    end;
  finally
    qrprodutos.Free;
  end;
end;

function TDAOprodutos.selecionarprodutos: TFDQuery;
var
  qrprodutos: TFDQuery;
begin

  qrprodutos := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrprodutos.Open('select * from Cad_produto order by DESCRICAO');
  result := qrprodutos;

end;

function TDAOprodutos.validar(modelprodutos: TModelprodutos): boolean;
var
  qrprodutos: TFDQuery;
begin
  result := true;
  try
    try
      qrprodutos := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrprodutos.SQL.Text := 'Select * from Cad_produto where DESCRICAO = ' +
        QuotedStr(uppercase(modelprodutos.DESCRICAO));
      qrprodutos.Open();
      if qrprodutos.RecordCount > 0 then
        result := false;
      qrprodutos.Close;
    except
      result := false;
    end;
  finally
    qrprodutos.Free;
  end;
end;

end.
