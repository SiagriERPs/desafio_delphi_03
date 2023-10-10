unit UDAOConexao;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, SysUtils, vcl.forms;

type
  TDAOConexao = class
  private
    FConexao: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;

  public
    function getConexao: TFDConnection;
    function criarQuery: TFDQuery;

    constructor Create;
    destructor Destroy;
  end;

implementation

{ TDAOConexao }

constructor TDAOConexao.Create;
begin
  inherited Create;

  FConexao := TFDConnection.Create(nil);
  FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(nil);

  FConexao.Params.DriverID := 'FB';
  FConexao.Params.Database := Copy(ExtractFileDir(Application.ExeName), 1, LastDelimiter('\', ExtractFileDir(Application.ExeName))) + '\data\database.fdb';
  FConexao.Params.UserName := 'SYSDBA';
  FConexao.Params.Password := 'masterkey';
  FConexao.LoginPrompt := false;

end;

function TDAOConexao.criarQuery: TFDQuery;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConexao;

  Result := Query;

end;

destructor TDAOConexao.Destroy;
begin
  inherited;
  FreeAndNil(FConexao);
  FreeAndNil(FDPhysFBDriverLink);
end;

function TDAOConexao.getConexao: TFDConnection;
begin
  Result := FConexao;
end;

end.
