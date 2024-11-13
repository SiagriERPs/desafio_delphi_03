unit uDistribuidorController;

interface

uses
  uDistribuidorModel,
  System.SysUtils,
  FireDAC.Comp.Client;

type
  TDistribuidorController = class
  private
    FDistribuidorModel: TDistribuidorModel;
  public
    constructor Create;
    destructor Destroy; Override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(pAutoIncremento: Integer): Integer;

    property DistribuidorModel: TDistribuidorModel read FDistribuidorModel write FDistribuidorModel;
  end;

implementation

{ TDistribuidorController }

constructor TDistribuidorController.Create;
begin
  FDistribuidorModel := TDistribuidorModel.Create;
end;

destructor TDistribuidorController.Destroy;
begin
  FDistribuidorModel.Free;
  inherited;
end;

function TDistribuidorController.GetId(pAutoIncremento: Integer): Integer;
begin
  Result := FDistribuidorModel.GetId(pAutoIncremento);
end;

function TDistribuidorController.Obter: TFDQuery;
begin
  Result := FDistribuidorModel.obter;
end;

function TDistribuidorController.Salvar: Boolean;
begin
  Result := FDistribuidorModel.Salvar;
end;

end.
