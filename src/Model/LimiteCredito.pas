unit LimiteCredito;

interface

type
  TLimiteCredito = class
  private
    FID: integer;
    FIdProdutor: integer;
    FIdDistribuidor: integer;
    FLimiteCredito: Double;
  public
    property ID: integer read FID;
    property IdProdutor: integer read FIdProdutor;
    property IdDistribuidor: integer read FIdDistribuidor;
    property LimiteCredito: Double read FLimiteCredito write FLimiteCredito;
    constructor Create(const AID, AIdProdutor, AIdDistribuidor: integer; ALimiteCredito: Double);
    destructor Destroy; override;
  end;

implementation

{ TLimiteCredito }

constructor TLimiteCredito.Create(const AID, AIdProdutor,
  AIdDistribuidor: integer; ALimiteCredito: Double);
begin
  FID             := AID;
  FIdProdutor     := AIdProdutor;
  FIdDistribuidor := AIdDistribuidor;
  FLimiteCredito  := ALimiteCredito;
end;

destructor TLimiteCredito.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
