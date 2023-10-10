unit UModelNegociacaoItens;

interface

uses UEnumerador, SysUtils, FireDAC.Comp.Client;

type
  TModelNegociacaoItens = class
  private

    FID         : Integer;
    FQTD: Integer;
    FVALOR_TOTAL: Double;
    FFK_NEGOCIACAO: Integer;
    FVALOR_UN: Double;
    FFK_PRODUTO: Integer;

    FEnumerador : TEnumerador;
  protected
  public

    property ID              : Integer     read FID                       write FID;
    property FK_NEGOCIACAO   : Integer     read FFK_NEGOCIACAO  write FFK_NEGOCIACAO;
    property FK_PRODUTO      : Integer     read FFK_PRODUTO  write FFK_PRODUTO;
    property VALOR_UN        : Double      read FVALOR_UN  write FVALOR_UN;
    property QTD             : Integer     read FQTD  write FQTD;
    property VALOR_TOTAL     : Double      read FVALOR_TOTAL  write FVALOR_TOTAL;


    property enuTipo      : TEnumerador read FEnumerador  write FEnumerador;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;
    function buscarId: Integer;

  end;

implementation

{ TModelNegociacaoItens }

uses UDAONegociacaoItens;

function TModelNegociacaoItens.buscarId: Integer;
var
  DAONegociacaoItens: TDAONegociacaoItens;
begin
  DAONegociacaoItens := TDAONegociacaoItens.Create;
  try
    result := DAONegociacaoItens.buscarId(Self);
  finally
    FreeAndNil(DAONegociacaoItens);
  end;
end;

function TModelNegociacaoItens.persistir: Boolean;
var
  DAONegociacaoItens: TDAONegociacaoItens;
begin
  DAONegociacaoItens := TDAONegociacaoItens.Create;
  try
    case FEnumerador of
      tipoInclusao:
        result := DAONegociacaoItens.incluir(Self);
      tipoExclusao:
        result := DAONegociacaoItens.excluir(Self);
    end;
  finally
    FreeAndNil(DAONegociacaoItens);
  end;
end;

function TModelNegociacaoItens.selecionar: TFDQuery;
var
  DAONegociacaoItens: TDAONegociacaoItens;
begin
  DAONegociacaoItens := TDAONegociacaoItens.Create;
  try
    result := DAONegociacaoItens.selecionarNegociacaoItens(Self);
  finally
    FreeAndNil(DAONegociacaoItens);
  end;
end;

function TModelNegociacaoItens.validar: Boolean;
var
  DAONegociacaoItens: TDAONegociacaoItens;
begin
  DAONegociacaoItens := TDAONegociacaoItens.Create;
  try
    result := DAONegociacaoItens.validar(Self);
  finally
    FreeAndNil(DAONegociacaoItens);
  end;
end;


end.
