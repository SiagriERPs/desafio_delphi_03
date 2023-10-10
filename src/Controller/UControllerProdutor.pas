unit UControllerProdutor;

interface

uses UModelProdutor, FireDAC.Comp.Client, SysUtils;

type
  TControllerProdutor = class
  private
    FModelProdutor: TModelProdutor;
  public
    property ModelProdutor: TModelProdutor read FModelProdutor write FModelProdutor;

    function persistir: Boolean;
    function selecionar: TFDQuery;
    function validar: Boolean;

    function buscarId: Integer;

    constructor Create;
    destructor destroy; override;
  end;

implementation

{ TControllerProdutor }

constructor TControllerProdutor.Create;
begin
  FModelProdutor := TModelProdutor.Create;
  inherited Create;
end;

destructor TControllerProdutor.destroy;
begin
  FreeAndNil(FModelProdutor);
  inherited;
end;

function TControllerProdutor.persistir: Boolean;
begin
  result := FModelProdutor.persistir;
end;

function TControllerProdutor.selecionar: TFDQuery;
begin
  result := FModelProdutor.selecionar;
end;

function TControllerProdutor.validar: Boolean;
begin
  result := FModelProdutor.validar;
end;

function TControllerProdutor.buscarId: Integer;
begin
  result := FModelProdutor.buscarId;
end;

end.
