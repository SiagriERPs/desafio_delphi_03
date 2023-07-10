unit Produtor;

interface

type
  TProdutor = class
  private
    FID: integer;
    FNome: string;
    FCPFCNPJ: string;
  public
    property ID: integer read FID;
    property Nome: string read FNome write FNome;
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    constructor Create(const AID: integer; const ANome, ACPFCNPJ: string);
    destructor Destroy; override;
  end;

implementation

{ TProdutor }

constructor TProdutor.Create(const AID: integer; const ANome, ACPFCNPJ: string);
begin
  FID      := AID;
  FNome    := ANome;
  FCPFCNPJ := ACPFCNPJ;
end;

destructor TProdutor.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
