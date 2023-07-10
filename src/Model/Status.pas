unit Status;

interface

type
 TStatus = class
  private
    FID: integer;
    FStatus: string;
  public
    property ID: integer read FID;
    property Status: string read FStatus write FStatus;
    constructor Create(const AID: integer; const AStatus: string);
    destructor Destroy; override;
 end;

implementation

{ TStatus }

constructor TStatus.Create(const AID: integer; const AStatus: string);
begin
  FID     := AID;
  FStatus := AStatus;
end;

destructor TStatus.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
