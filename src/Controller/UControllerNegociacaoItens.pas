unit UControllerNegociacaoItens;

interface

uses UModelNegociacaoItens, FireDAC.Comp.Client, SysUtils;

type
  TControllerNegociacaoItens = class
  private
    FModelNegociacaoItens: TModelNegociacaoItens;
  public
    property ModelNegociacaoItens: TModelNegociacaoItens read FModelNegociacaoItens write FModelNegociacaoItens;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;

    function buscarId: Integer;

    constructor Create;
    destructor destroy; override;
  end;

implementation

{ TControllerNegociacaoItens }

constructor TControllerNegociacaoItens.Create;
begin
  FModelNegociacaoItens := TModelNegociacaoItens.Create;
  inherited Create;
end;

destructor TControllerNegociacaoItens.destroy;
begin
  FreeAndNil(FModelNegociacaoItens);
  inherited;
end;

function TControllerNegociacaoItens.persistir: Boolean;
begin
  result := FModelNegociacaoItens.persistir;
end;

function TControllerNegociacaoItens.selecionar: TFDQuery;
begin
  result := FModelNegociacaoItens.selecionar;
end;

function TControllerNegociacaoItens.validar: Boolean;
begin
  result := FModelNegociacaoItens.validar;
end;

function TControllerNegociacaoItens.buscarId: Integer;
begin
  result := FModelNegociacaoItens.buscarId;
end;

end.
