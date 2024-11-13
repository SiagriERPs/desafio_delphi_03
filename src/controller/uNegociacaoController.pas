unit uNegociacaoController;

interface

uses
  uNegociacaoModel,
  System.SysUtils,
  FireDAC.Comp.Client;

type
  TNegociacaoController = class
  private
    FNegociacaoModel: TNegociacaoModel;
  public
    constructor Create;
    destructor Destroy; Override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(pAutoIncremento: Integer): Integer;

    property NegociacaoModel: TNegociacaoModel read FNegociacaoModel write FNegociacaoModel;
  end;

implementation

{ TNegociacaoController }

constructor TNegociacaoController.Create;
begin
  FNegociacaoModel := TNegociacaoModel.Create;
end;

destructor TNegociacaoController.Destroy;
begin
  FNegociacaoModel.Free;
  inherited;
end;

function TNegociacaoController.GetId(pAutoIncremento: Integer): Integer;
begin
  Result := FNegociacaoModel.GetId(pAutoIncremento);
end;

function TNegociacaoController.Obter: TFDQuery;
begin
  Result := FNegociacaoModel.obter;
end;

function TNegociacaoController.Salvar: Boolean;
begin
  Result := FNegociacaoModel.Salvar;
end;

end.
