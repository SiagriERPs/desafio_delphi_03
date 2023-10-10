unit UControllerCPFCNPJ;

interface

uses UModelCPFCNPJ, sysUtils;

type
  TControllerCPFCNPJ = class
  private
    FModelCPFCNPJ: TModelCPFCNPJ;
  public
    property ModelCPFCNPJ: TModelCPFCNPJ read FModelCPFCNPJ write FModelCPFCNPJ;
    function formatar    : String;

    constructor Create;
    destructor destroy; override;
  end;

implementation


{ TControllerCPFCNPJ }

constructor TControllerCPFCNPJ.Create;
begin
  FModelCPFCNPJ := TModelCPFCNPJ.Create;
  inherited Create;
end;

destructor TControllerCPFCNPJ.destroy;
begin
  FreeAndNil(FModelCPFCNPJ);
  inherited;
end;

function TControllerCPFCNPJ.formatar: String;
begin
  result := FModelCPFCNPJ.formatar;
end;

end.
