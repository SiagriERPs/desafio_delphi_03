unit UModelProdutos;

interface

uses UEnumerador, SysUtils, FireDAC.Comp.Client;

type
  TModelprodutos = class
  private

    FID         : Integer;
    FDESCRICAO: String;
    FPRECO_VENDA: Double;
    FEnumerador : TEnumerador;

  protected
  public

    property ID           : Integer     read FID          write FID;
    property DESCRICAO    : String      read FDESCRICAO   write FDESCRICAO;
    property PRECO_VENDA  : Double      read FPRECO_VENDA write FPRECO_VENDA;
    property enuTipo      : TEnumerador read FEnumerador  write FEnumerador;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;
    function buscarId: Integer;

  end;

implementation

{ TModelprodutos }

uses UDAOprodutos;

function TModelprodutos.buscarId: Integer;
var
  DAOprodutos: TDAOprodutos;
begin
  DAOprodutos := TDAOprodutos.Create;
  try
    result := DAOprodutos.buscarId(Self);
  finally
    FreeAndNil(DAOprodutos);
  end;
end;

function TModelprodutos.persistir: Boolean;
var
  DAOprodutos: TDAOprodutos;
begin
  DAOprodutos := TDAOprodutos.Create;
  try
    case FEnumerador of
      tipoInclusao:
        result := DAOprodutos.incluir(Self);
      tipoExclusao:
        result := DAOprodutos.excluir(Self);
      tipoAlteracao:
        result := DAOprodutos.alterar(Self);
    end;
  finally
    FreeAndNil(DAOprodutos);
  end;
end;

function TModelprodutos.selecionar: TFDQuery;
var
  DAOprodutos: TDAOprodutos;
begin
  DAOprodutos := TDAOprodutos.Create;
  try
    result := DAOprodutos.selecionarprodutos;
  finally
    FreeAndNil(DAOprodutos);
  end;
end;

function TModelprodutos.validar: Boolean;
var
  DAOprodutos: TDAOprodutos;
begin
  DAOprodutos := TDAOprodutos.Create;
  try
    result := DAOprodutos.validar(Self);
  finally
    FreeAndNil(DAOprodutos);
  end;
end;


end.
