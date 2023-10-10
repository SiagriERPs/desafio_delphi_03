unit UModelDistribuidor;

interface

uses UEnumerador, SysUtils, FireDAC.Comp.Client;

type
  TModelDistribuidor = class
  private

    FID         : Integer;
    FNOME       : String;
    FCNPJ   : String;
    FEnumerador : TEnumerador;

  protected
  public

    property ID       : Integer     read FID         write FID;
    property NOME     : String      read FNOME       write FNOME;
    property CNPJ : String          read FCNPJ       write FCNPJ;
    property enuTipo  : TEnumerador read FEnumerador write FEnumerador;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;
    function buscarId: Integer;

  end;

implementation

{ TModelDistribuidor }

uses UDAODistribuidor;

function TModelDistribuidor.buscarId: Integer;
var
  DAODistribuidor: TDAODistribuidor;
begin
  DAODistribuidor := TDAODistribuidor.Create;
  try
    result := DAODistribuidor.buscarId(Self);
  finally
    FreeAndNil(DAODistribuidor);
  end;
end;

function TModelDistribuidor.persistir: Boolean;
var
  DAODistribuidor: TDAODistribuidor;
begin
  DAODistribuidor := TDAODistribuidor.Create;
  try
    case FEnumerador of
      tipoInclusao:
        result := DAODistribuidor.incluir(Self);
      tipoExclusao:
        result := DAODistribuidor.excluir(Self);
      tipoAlteracao:
        result := DAODistribuidor.alterar(Self);
    end;
  finally
    FreeAndNil(DAODistribuidor);
  end;
end;

function TModelDistribuidor.selecionar: TFDQuery;
var
  DAODistribuidor: TDAODistribuidor;
begin
  DAODistribuidor := TDAODistribuidor.Create;
  try
    result := DAODistribuidor.selecionarDistribuidor;
  finally
    FreeAndNil(DAODistribuidor);
  end;
end;

function TModelDistribuidor.validar: Boolean;
var
  DAODistribuidor: TDAODistribuidor;
begin
  DAODistribuidor := TDAODistribuidor.Create;
  try
    result := DAODistribuidor.validar(Self);
  finally
    FreeAndNil(DAODistribuidor);
  end;
end;


end.
