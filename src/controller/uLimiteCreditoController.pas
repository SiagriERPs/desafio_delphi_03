unit uLimiteCreditoController;

interface

uses
  uLimiteCreditoModel,
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TLimiteCreditoController = class
  private
    FLimiteCreditoModel: TLimiteCreditoModel;
  public
    constructor Create;
    destructor Destroy; Override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(pAutoIncremento: Integer): Integer;
    function ObterLimitesCredito(pProdutorId: Integer): TList<TLimiteCreditoModel>;

    property LimiteCreditoModel: TLimiteCreditoModel read FLimiteCreditoModel write FLimiteCreditoModel;
  end;

implementation

{ TLimiteCreditoController }

constructor TLimiteCreditoController.Create;
begin
  FLimiteCreditoModel := TLimiteCreditoModel.Create;
end;

destructor TLimiteCreditoController.Destroy;
begin
  FLimiteCreditoModel.Free;
  inherited;
end;

function TLimiteCreditoController.GetId(pAutoIncremento: Integer): Integer;
begin
  Result := FLimiteCreditoModel.GetId(pAutoIncremento);
end;

function TLimiteCreditoController.Obter: TFDQuery;
begin
 Result := FLimiteCreditoModel.obter;
end;

function TLimiteCreditoController.ObterLimitesCredito(pProdutorId: Integer): TList<TLimiteCreditoModel>;
begin
  Result := FLimiteCreditoModel.ObterLimitesCredito(pProdutorId);
end;

function TLimiteCreditoController.Salvar: Boolean;
begin
  Result := FLimiteCreditoModel.Salvar;
end;

end.

