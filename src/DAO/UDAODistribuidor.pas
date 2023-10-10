unit UDAODistribuidor;

interface

uses FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, SysUtils,
  UControllerConexao, uModelDistribuidor;

type
  TDAODistribuidor = class
  private

  protected
  public
    function selecionarDistribuidor: TFDQuery;

    function buscarId(modelDistribuidor: TModelDistribuidor): Integer;

    function validar(modelDistribuidor: TModelDistribuidor): boolean;
    function incluir(modelDistribuidor: TModelDistribuidor): boolean;
    function excluir(modelDistribuidor: TModelDistribuidor): boolean;
    function alterar(modelDistribuidor: TModelDistribuidor): boolean;

  published
  end;

implementation

{ TDAODistribuidor }

function TDAODistribuidor.alterar(modelDistribuidor: TModelDistribuidor): boolean;
var
  qrDistribuidor: TFDQuery;
begin
  try
    try
      qrDistribuidor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrDistribuidor.ExecSQL
        ('UPDATE Cad_Distribuidor set NOME = :NOME, CNPJ = :CNPJ WHERE ID = :ID',
        [uppercase(modelDistribuidor.NOME), modelDistribuidor.CNPJ, modelDistribuidor.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrDistribuidor.Free;
  end;
end;

function TDAODistribuidor.buscarId(modelDistribuidor: TModelDistribuidor): Integer;
var
  qrDistribuidor: TFDQuery;
begin
  try
    try
      qrDistribuidor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrDistribuidor.SQL.Text := 'Select * from Cad_Distribuidor where NOME = ' +
        QuotedStr(uppercase(modelDistribuidor.NOME)) +
        ' and CNPJ = ' + QuotedStr(modelDistribuidor.CNPJ);
      qrDistribuidor.Open();
      if qrDistribuidor.RecordCount > 0 then
        result := strtoint(qrDistribuidor.FieldByName('ID').Text);
      qrDistribuidor.Close;
    except
      result := 0;
    end;
  finally
    qrDistribuidor.Free;
  end;
end;

function TDAODistribuidor.excluir(modelDistribuidor: TModelDistribuidor): boolean;
var
  qrDistribuidor: TFDQuery;
begin
  try
    try
      qrDistribuidor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrDistribuidor.ExecSQL('DELETE from Cad_Distribuidor WHERE ID = :ID',
        [modelDistribuidor.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrDistribuidor.Free;
  end;
end;

function TDAODistribuidor.incluir(modelDistribuidor: TModelDistribuidor): boolean;
var
  qrDistribuidor: TFDQuery;
begin
  try
    try
      qrDistribuidor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrDistribuidor.ExecSQL
        ('insert into Cad_Distribuidor (NOME, CNPJ) values (:NOME, :CNPJ)',
        [uppercase(modelDistribuidor.NOME), modelDistribuidor.CNPJ]);
      result := true;
    except
      result := false;
    end;
  finally
    qrDistribuidor.Free;
  end;
end;

function TDAODistribuidor.selecionarDistribuidor: TFDQuery;
var
  qrDistribuidor: TFDQuery;
begin

  qrDistribuidor := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrDistribuidor.Open('select * from Cad_Distribuidor order by Nome');
  result := qrDistribuidor;

end;

function TDAODistribuidor.validar(modelDistribuidor: TModelDistribuidor): boolean;
var
  qrDistribuidor: TFDQuery;
begin
  result := true;
  try
    try
      qrDistribuidor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrDistribuidor.SQL.Text := 'Select * from Cad_Distribuidor where CNPJ = ' +
        QuotedStr(uppercase(modelDistribuidor.CNPJ));
      qrDistribuidor.Open();
      if qrDistribuidor.RecordCount > 0 then
        result := false;
      qrDistribuidor.Close;
    except
      result := false;
    end;
  finally
    qrDistribuidor.Free;
  end;
end;

end.
