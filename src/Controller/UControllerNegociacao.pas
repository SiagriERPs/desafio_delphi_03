unit UControllerNegociacao;

interface

uses UModelNegociacao, FireDAC.Comp.Client, SysUtils;

type
  TControllerNegociacao = class
  private
    FModelNegociacao: TModelNegociacao;
  public
    property ModelNegociacao: TModelNegociacao read FModelNegociacao write FModelNegociacao;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;

    function buscarId: Integer;

    constructor Create;
    destructor destroy; override;
  end;

implementation

{ TControllerNegociacao }

constructor TControllerNegociacao.Create;
begin
  FModelNegociacao := TModelNegociacao.Create;
  inherited Create;
end;

destructor TControllerNegociacao.destroy;
begin
  FreeAndNil(FModelNegociacao);
  inherited;
end;

function TControllerNegociacao.persistir: Boolean;
begin
  result := FModelNegociacao.persistir;
end;

function TControllerNegociacao.selecionar: TFDQuery;
begin
  result := FModelNegociacao.selecionar;
end;

function TControllerNegociacao.validar: Boolean;
begin
  result := FModelNegociacao.validar;
end;

function TControllerNegociacao.buscarId: Integer;
begin
  result := FModelNegociacao.buscarId;
end;

end.
