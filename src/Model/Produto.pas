unit Produto;

interface

type
  TProduto = class
  private
    FID: integer;
    FNome: string;
    FPreco: Double;
  public
    property ID: integer read FID;
    property Nome: string read FNome write FNome;
    property Preco: Double read FPreco write FPreco;
    constructor Create(const AID: integer; const ANome: string; APreco: Double);
    destructor Destroy; override;
  end;

implementation

{ TProduto }

constructor TProduto.Create(const AID: integer; const ANome: string;
  APreco: Double);
begin
  FID    := AID;
  FNome  := ANome;
  FPreco := APreco;
end;

destructor TProduto.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
