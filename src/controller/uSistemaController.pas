unit uSistemaController;

interface

uses
  uConexao,
  System.SysUtils;

type
  TSistemaControl = class
  private
    class var FInstance: TSistemaControl;
    FConexao: TConexao;
    constructor Create;
  public
    class function GetInstance: TSistemaControl;
    function GetConexao: TConexao;
    destructor Destroy; override;
  end;

implementation

{ TSistemaControl }

constructor TSistemaControl.Create;
begin
  inherited Create;
  FConexao := TConexao.Create;
end;

destructor TSistemaControl.Destroy;
begin
  FConexao.Free;
  inherited;
end;

class function TSistemaControl.GetInstance: TSistemaControl;
begin
  if FInstance = nil then
    FInstance := TSistemaControl.Create;
  Result := FInstance;
end;

function TSistemaControl.GetConexao: TConexao;
begin
  Result := FConexao;
end;

initialization

finalization
  FreeAndNil(TSistemaControl.FInstance);

end.

