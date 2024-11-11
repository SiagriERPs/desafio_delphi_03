unit uProdutorController;

interface

uses
  uProdutorModel,
  System.SysUtils,
  FireDAC.Comp.Client;

type
  TProdutorController = class
  private
    FProdutorModel: TProdutorModel;
  public
    constructor Create;
    destructor Destroy; Override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(pAutoIncremento: Integer): Integer;

    property ProdutorModel: TProdutorModel read FProdutorModel write FProdutorModel;
  end;

implementation

{ TProdutorController }

constructor TProdutorController.Create;
begin
  FProdutorModel := TProdutorModel.Create;
end;

destructor TProdutorController.Destroy;
begin
  FProdutorModel.Free;
  inherited;
end;

function TProdutorController.GetId(pAutoIncremento: Integer): Integer;
begin
  Result := FProdutorModel.GetId(pAutoIncremento);
end;

function TProdutorController.Obter: TFDQuery;
begin
  Result := FProdutorModel.obter;
end;

function TProdutorController.Salvar: Boolean;
begin
  Result := FProdutorModel.Salvar;
end;

end.
