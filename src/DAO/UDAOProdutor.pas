unit UDAOProdutor;

interface

uses FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, SysUtils,
  UControllerConexao, UModelProdutor;

type
  TDAOProdutor = class
  private

  protected
  public
    function selecionarProdutor: TFDQuery;

    function buscarId(modelProdutor: TModelProdutor): Integer;

    function validar(modelProdutor: TModelProdutor): boolean;
    function incluir(modelProdutor: TModelProdutor): boolean;
    function excluir(modelProdutor: TModelProdutor): boolean;
    function alterar(modelProdutor: TModelProdutor): boolean;

  published
  end;

implementation

{ TDAOProdutor }

function TDAOProdutor.alterar(modelProdutor: TModelProdutor): boolean;
var
  qrProdutor: TFDQuery;
begin
  try
    try
      qrProdutor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrProdutor.ExecSQL
        ('UPDATE Cad_Produtor set NOME = :NOME, CPF_CNPJ = :CPF_CNPJ WHERE ID = :ID',
        [uppercase(modelProdutor.NOME), modelProdutor.CPF_CNPJ, modelProdutor.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrProdutor.Free;
  end;
end;

function TDAOProdutor.buscarId(modelProdutor: TModelProdutor): Integer;
var
  qrProdutor: TFDQuery;
begin
  try
    try
      qrProdutor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrProdutor.SQL.Text := 'Select * from Cad_Produtor where NOME = ' +
        QuotedStr(uppercase(modelProdutor.NOME)) +
        ' and CPF_CNPJ = ' + QuotedStr(modelProdutor.CPF_CNPJ);
      qrProdutor.Open();
      if qrProdutor.RecordCount > 0 then
        result := strtoint(qrProdutor.FieldByName('ID').Text);
      qrProdutor.Close;
    except
      result := 0;
    end;
  finally
    qrProdutor.Free;
  end;
end;

function TDAOProdutor.excluir(modelProdutor: TModelProdutor): boolean;
var
  qrProdutor: TFDQuery;
begin
  try
    try
      qrProdutor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrProdutor.ExecSQL('DELETE from Cad_Produtor WHERE ID = :ID',
        [modelProdutor.ID]);
      result := true;
    except
      result := false;
    end;
  finally
    qrProdutor.Free;
  end;
end;

function TDAOProdutor.incluir(modelProdutor: TModelProdutor): boolean;
var
  qrProdutor: TFDQuery;
begin
  try
    try
      qrProdutor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrProdutor.ExecSQL
        ('insert into Cad_Produtor (NOME, CPF_CNPJ) values (:NOME, :CPF_CNPJ)',
        [uppercase(modelProdutor.NOME), modelProdutor.CPF_CNPJ]);
      result := true;
    except
      result := false;
    end;
  finally
    qrProdutor.Free;
  end;
end;

function TDAOProdutor.selecionarProdutor: TFDQuery;
var
  qrProdutor: TFDQuery;
begin

  qrProdutor := TControllerConexao.getInstance().daoConexao.criarQuery;
  qrProdutor.Open('select * from Cad_Produtor order by Nome');
  result := qrProdutor;

end;

function TDAOProdutor.validar(modelProdutor: TModelProdutor): boolean;
var
  qrProdutor: TFDQuery;
begin
  result := true;
  try
    try
      qrProdutor := TControllerConexao.getInstance().daoConexao.criarQuery;
      qrProdutor.SQL.Text := 'Select * from Cad_Produtor where CPF_CNPJ = ' +
        QuotedStr(uppercase(modelProdutor.CPF_CNPJ));
      qrProdutor.Open();
      if qrProdutor.RecordCount > 0 then
        result := false;
      qrProdutor.Close;
    except
      result := false;
    end;
  finally
    qrProdutor.Free;
  end;
end;

end.
