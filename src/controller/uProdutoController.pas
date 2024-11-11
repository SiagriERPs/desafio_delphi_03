unit uProdutoController;

interface

uses
  uProdutoModel,
  System.SysUtils,
  FireDAC.Comp.Client;

type
  TProdutoController = class
  private
    FProdutoModel: TProdutoModel;
  public
    constructor Create;
    destructor Destroy; Override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(pAutoIncremento: Integer): Integer;

    property ProdutoModel: TProdutoModel read FProdutoModel write FProdutoModel;
  end;

implementation

{ TProdutoController }

constructor TProdutoController.Create;
begin
  FProdutoModel := TProdutoModel.Create;
end;

destructor TProdutoController.Destroy;
begin
  FProdutoModel.Free;
  inherited;
end;

function TProdutoController.GetId(pAutoIncremento: Integer): Integer;
begin
  Result := FProdutoModel.GetId(pAutoIncremento);
end;

function TProdutoController.Obter: TFDQuery;
begin
  Result := FProdutoModel.obter;
end;

function TProdutoController.Salvar: Boolean;
begin
  Result := FProdutoModel.Salvar;
end;

end.
