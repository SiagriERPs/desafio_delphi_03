unit UControllerDistribuidor;

interface

uses UModelDistribuidor, FireDAC.Comp.Client, SysUtils;

type
  TControllerDistribuidor = class
  private
    FModelDistribuidor: TModelDistribuidor;
  public
    property ModelDistribuidor: TModelDistribuidor read FModelDistribuidor write FModelDistribuidor;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;

    function buscarId: Integer;

    constructor Create;
    destructor destroy; override;
  end;

implementation

{ TControllerDistribuidor }

constructor TControllerDistribuidor.Create;
begin
  FModelDistribuidor := TModelDistribuidor.Create;
  inherited Create;
end;

destructor TControllerDistribuidor.destroy;
begin
  FreeAndNil(FModelDistribuidor);
  inherited;
end;

function TControllerDistribuidor.persistir: Boolean;
begin
  result := FModelDistribuidor.persistir;
end;

function TControllerDistribuidor.selecionar: TFDQuery;
begin
  result := FModelDistribuidor.selecionar;
end;

function TControllerDistribuidor.validar: Boolean;
begin
  result := FModelDistribuidor.validar;
end;

function TControllerDistribuidor.buscarId: Integer;
begin
  result := FModelDistribuidor.buscarId;
end;

end.
