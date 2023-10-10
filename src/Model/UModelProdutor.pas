unit UModelProdutor;

interface

uses UEnumerador, SysUtils, FireDAC.Comp.Client;

type
  TModelProdutor = class
  private

    FID         : Integer;
    FNOME       : String;
    FCPF_CNPJ   : String;
    FEnumerador : TEnumerador;

  protected
  public

    property ID       : Integer     read FID         write FID;
    property NOME     : String      read FNOME       write FNOME;
    property CPF_CNPJ : String      read FCPF_CNPJ   write FCPF_CNPJ;
    property enuTipo  : TEnumerador read FEnumerador write FEnumerador;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;
    function buscarId: Integer;

  end;

implementation

{ TModelProdutor }

uses UDAOProdutor;

function TModelProdutor.buscarId: Integer;
var
  DAOProdutor: TDAOProdutor;
begin
  DAOProdutor := TDAOProdutor.Create;
  try
    result := DAOProdutor.buscarId(Self);
  finally
    FreeAndNil(DAOProdutor);
  end;
end;

function TModelProdutor.persistir: Boolean;
var
  DAOProdutor: TDAOProdutor;
begin
  DAOProdutor := TDAOProdutor.Create;
  try
    case FEnumerador of
      tipoInclusao:
        result := DAOProdutor.incluir(Self);
      tipoExclusao:
        result := DAOProdutor.excluir(Self);
      tipoAlteracao:
        result := DAOProdutor.alterar(Self);
    end;
  finally
    FreeAndNil(DAOProdutor);
  end;
end;

function TModelProdutor.selecionar: TFDQuery;
var
  DAOProdutor: TDAOProdutor;
begin
  DAOProdutor := TDAOProdutor.Create;
  try
    result := DAOProdutor.selecionarProdutor;
  finally
    FreeAndNil(DAOProdutor);
  end;
end;

function TModelProdutor.validar: Boolean;
var
  DAOProdutor: TDAOProdutor;
begin
  DAOProdutor := TDAOProdutor.Create;
  try
    result := DAOProdutor.validar(Self);
  finally
    FreeAndNil(DAOProdutor);
  end;
end;


end.
