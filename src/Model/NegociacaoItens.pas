unit NegociacaoItens;

interface

type
  TNegociacaoItens = class
  private
    FID: integer;
    FIdNegociacao: integer;
    FIdProduto: integer;
    FQuantidade: double;
    FValorUnitario: Double;
  public
    property ID: integer read FID;
    property IdNegociacao: integer read FIdNegociacao;
    property IdProduto: integer read FIdProduto;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    constructor Create(const AID, AIdNegociacao, AIdProduto: integer; AQuantiade, AValorUnitario: Double);
    destructor Destroy; override;
  end;

implementation

{ TNegociacaoItens }


{ TNegociacaoItens }

constructor TNegociacaoItens.Create(const AID, AIdNegociacao,
  AIdProduto: integer; AQuantiade, AValorUnitario: Double);
begin
  FID            := AID;
  FIdNegociacao  := AIdNegociacao;
  FIdProduto     := AIdProduto;
  FQuantidade    := AQuantiade;
  FValorUnitario := AValorUnitario;
end;

destructor TNegociacaoItens.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
