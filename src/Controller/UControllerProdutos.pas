unit UControllerProdutos;

interface

uses UModelprodutos, FireDAC.Comp.Client, SysUtils;

type
  TControllerprodutos = class
  private
    FModelprodutos: TModelprodutos;
  public
    property Modelprodutos: TModelprodutos read FModelprodutos write FModelprodutos;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;

    function buscarId: Integer;

    constructor Create;
    destructor destroy; override;
  end;

implementation

{ TControllerprodutos }

constructor TControllerprodutos.Create;
begin
  FModelprodutos := TModelprodutos.Create;
  inherited Create;
end;

destructor TControllerprodutos.destroy;
begin
  FreeAndNil(FModelprodutos);
  inherited;
end;

function TControllerprodutos.persistir: Boolean;
begin
  result := FModelprodutos.persistir;
end;

function TControllerprodutos.selecionar: TFDQuery;
begin
  result := FModelprodutos.selecionar;
end;

function TControllerprodutos.validar: Boolean;
begin
  result := FModelprodutos.validar;
end;

function TControllerprodutos.buscarId: Integer;
begin
  result := FModelprodutos.buscarId;
end;

end.
