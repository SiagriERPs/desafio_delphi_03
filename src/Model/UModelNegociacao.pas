unit UModelNegociacao;

interface

uses UEnumerador, SysUtils, FireDAC.Comp.Client;

type
  TModelNegociacao = class
  private

    FID         : Integer;
    FFK_VINCULACAO_COMERCIAL: Integer;
    FVALOR: Double;
    FSTATUS: String;

    FEnumerador : TEnumerador;


  protected
  public

    property ID                        : Integer     read FID                       write FID;
    property FK_VINCULACAO_COMERCIAL   : Integer     read FFK_VINCULACAO_COMERCIAL  write FFK_VINCULACAO_COMERCIAL;
    property VALOR                     : Double      read FVALOR                    write FVALOR;
    property STATUS                    : String      read FSTATUS                   write FSTATUS;

    property enuTipo      : TEnumerador read FEnumerador  write FEnumerador;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;
    function buscarId: Integer;

  end;

implementation

{ TModelNegociacao }

uses UDAONegociacao;

function TModelNegociacao.buscarId: Integer;
var
  DAONegociacao: TDAONegociacao;
begin
  DAONegociacao := TDAONegociacao.Create;
  try
    result := DAONegociacao.buscarId(Self);
  finally
    FreeAndNil(DAONegociacao);
  end;
end;

function TModelNegociacao.persistir: Boolean;
var
  DAONegociacao: TDAONegociacao;
begin
  DAONegociacao := TDAONegociacao.Create;
  try
    case FEnumerador of
      tipoInclusao:
        result := DAONegociacao.incluir(Self);
      tipoExclusao:
        result := DAONegociacao.excluir(Self);
      tipoAlteracao:
        result := DAONegociacao.alterar(Self);
    end;
  finally
    FreeAndNil(DAONegociacao);
  end;
end;

function TModelNegociacao.selecionar: TFDQuery;
var
  DAONegociacao: TDAONegociacao;
begin
  DAONegociacao := TDAONegociacao.Create;
  try
    result := DAONegociacao.selecionarNegociacao;
  finally
    FreeAndNil(DAONegociacao);
  end;
end;

function TModelNegociacao.validar: Boolean;
var
  DAONegociacao: TDAONegociacao;
begin
  DAONegociacao := TDAONegociacao.Create;
  try
    result := DAONegociacao.validar(Self);
  finally
    FreeAndNil(DAONegociacao);
  end;
end;


end.
