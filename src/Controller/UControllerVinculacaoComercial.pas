unit UControllerVinculacaoComercial;

interface

uses UModelVinculacaoComercial, FireDAC.Comp.Client, SysUtils;

type
  TControllerVinculacaoComercial = class
  private
    FModelVinculacaoComercial: TModelVinculacaoComercial;
  public
    property ModelVinculacaoComercial: TModelVinculacaoComercial read FModelVinculacaoComercial write FModelVinculacaoComercial;

    function persistir: Boolean;
    function selecionar: TFDQuery;

    function getLimiteCredito: Double;

    function buscarId: Integer;

    constructor Create;
    destructor destroy; override;
  end;

implementation

{ TControllerVinculacaoComercial }

constructor TControllerVinculacaoComercial.Create;
begin
  FModelVinculacaoComercial := TModelVinculacaoComercial.Create;
  inherited Create;
end;

destructor TControllerVinculacaoComercial.destroy;
begin
  FreeAndNil(FModelVinculacaoComercial);
  inherited;
end;

function TControllerVinculacaoComercial.getLimiteCredito: Double;
begin
  result := FModelVinculacaoComercial.getLimiteCredito;
end;

function TControllerVinculacaoComercial.persistir: Boolean;
begin
  result := FModelVinculacaoComercial.persistir;
end;

function TControllerVinculacaoComercial.selecionar: TFDQuery;
begin
  result := FModelVinculacaoComercial.selecionar;
end;

function TControllerVinculacaoComercial.buscarId: Integer;
begin
  result := FModelVinculacaoComercial.buscarId;
end;

end.
