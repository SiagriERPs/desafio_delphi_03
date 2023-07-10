unit Distribuidor;

interface

type
  TDistribuidor = class
  private
    FID: integer;
    FNome: string;
    FCNPJ: string;
  public
    property ID: integer read FID;
    property Nome: string read FNome write FNome;
    property CNPJ: string read FCNPJ write FCNPJ;
    constructor Create(const AID: integer; const ANome, ACNPJ: string);
    destructor Destroy; override;
  end;

implementation

{ TDistribuidor }

constructor TDistribuidor.Create(const AID: integer; const ANome, ACNPJ: string);
begin
  FID   := AID;
  FNome := ANome;
  FCNPJ := ACNPJ;
end;

destructor TDistribuidor.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
