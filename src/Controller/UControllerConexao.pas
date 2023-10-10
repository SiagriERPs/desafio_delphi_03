unit UControllerConexao;

interface

uses UDaoConexao, SysUtils;

type

  TControllerConexao = class

  private
    FConexao: TDAOConexao;
    constructor Create;
    destructor Destroy; Override;
  public
    property daoConexao: TDAOConexao read FConexao write FConexao;

    class function getInstance: TControllerConexao;

  end;

implementation

var
  instanciaDb: TControllerConexao;

  { TControllerConexao }

constructor TControllerConexao.Create;
begin
  inherited Create;
  FConexao := TDAOConexao.Create;
end;

destructor TControllerConexao.Destroy;
begin
  inherited;
  FreeAndNil(FConexao);
end;

class function TControllerConexao.getInstance: TControllerConexao;
begin
  if instanciaDb = nil then
    instanciaDb := TControllerConexao.Create;

  result := instanciaDb;
end;

initialization

instanciaDb := nil;

finalization

if instanciaDb <> nil then
  instanciaDb.Free;

end.
