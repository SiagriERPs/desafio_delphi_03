unit uNegociacaoItemController;

interface

uses
  uNegociacaoItemModel,
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TNegociacaoItemController = class
  private
    FNegociacaoItemModel: TNegociacaoItemModel;
  public
    constructor Create;
    destructor Destroy; Override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(pAutoIncremento: Integer): Integer;
    function ObterItensNegociacao(pNegociacaoId: Integer): TList<TNegociacaoItemModel>;

    property NegociacaoItemModel: TNegociacaoItemModel read FNegociacaoItemModel write FNegociacaoItemModel;
  end;

implementation

{ TNegociacaoItemController }

constructor TNegociacaoItemController.Create;
begin
  FNegociacaoItemModel := TNegociacaoItemModel.Create;
end;

destructor TNegociacaoItemController.Destroy;
begin
  FNegociacaoItemModel.Free;
  inherited;
end;

function TNegociacaoItemController.GetId(
  pAutoIncremento: Integer): Integer;
begin
  Result := FNegociacaoItemModel.GetId(pAutoIncremento);
end;

function TNegociacaoItemController.Obter: TFDQuery;
begin
  Result := FNegociacaoItemModel.obter;
end;

function TNegociacaoItemController.ObterItensNegociacao(pNegociacaoId: Integer): TList<TNegociacaoItemModel>;
begin
  Result := FNegociacaoItemModel.ObterItensNegociacao(pNegociacaoId);
end;

function TNegociacaoItemController.Salvar: Boolean;
begin
  Result := FNegociacaoItemModel.Salvar;
end;

end.
