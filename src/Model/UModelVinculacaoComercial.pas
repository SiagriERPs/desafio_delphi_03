unit UModelVinculacaoComercial;

interface

uses UEnumerador, SysUtils, FireDAC.Comp.Client;

type
  TModelVinculacaoComercial = class
  private

    FID         : Integer;
    FFK_PRODUTOR: Integer;
    FFK_DISTRIBUIDOR: Integer;
    FLIMITE: Double;
    FEnumerador: TEnumerador;

  protected
  public

    property ID                  : Integer     read FID                write FID;
    property FK_PRODUTOR         : Integer     read FFK_PRODUTOR       write FFK_PRODUTOR;
    property FK_DISTRIBUIDOR     : Integer     read FFK_DISTRIBUIDOR   write FFK_DISTRIBUIDOR;
    property LIMITE              : Double      read FLIMITE            write FLIMITE;
    property enuTipo             : TEnumerador read FEnumerador write FEnumerador;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function buscarId: Integer;

    function getLimiteCredito: Double;

  end;

implementation

{ TModelVinculacaoComercial }

uses UDAOVinculacaoComercial;

function TModelVinculacaoComercial.buscarId: Integer;
var
  DAOVinculacaoComercial: TDAOVinculacaoComercial;
begin
  DAOVinculacaoComercial := TDAOVinculacaoComercial.Create;
  try
    result := DAOVinculacaoComercial.buscarId(Self);
  finally
    FreeAndNil(DAOVinculacaoComercial);
  end;
end;

function TModelVinculacaoComercial.getLimiteCredito: Double;
var
  DAOVinculacaoComercial: TDAOVinculacaoComercial;
begin
  DAOVinculacaoComercial := TDAOVinculacaoComercial.Create;
  try
    result := DAOVinculacaoComercial.getLimiteCredito(Self);
  finally
    FreeAndNil(DAOVinculacaoComercial);
  end;
end;
function TModelVinculacaoComercial.persistir: Boolean;
var
  DAOVinculacaoComercial: TDAOVinculacaoComercial;
begin
  DAOVinculacaoComercial := TDAOVinculacaoComercial.Create;
  try
    case FEnumerador of
      tipoInclusao:
        result := DAOVinculacaoComercial.incluir(Self);
      tipoExclusao:
        result := DAOVinculacaoComercial.excluir(Self);
      tipoAlteracao:
        result := DAOVinculacaoComercial.alterar(Self);
    end;
  finally
    FreeAndNil(DAOVinculacaoComercial);
  end;
end;

function TModelVinculacaoComercial.selecionar: TFDQuery;
var
  DAOVinculacaoComercial: TDAOVinculacaoComercial;
begin
  DAOVinculacaoComercial := TDAOVinculacaoComercial.Create;
  try
    result := DAOVinculacaoComercial.selecionarVinculacaoComercial(Self);
  finally
    FreeAndNil(DAOVinculacaoComercial);
  end;
end;

end.
