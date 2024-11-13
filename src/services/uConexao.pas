unit uConexao;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.SysUtils,
  Data.DB,
  Vcl.Dialogs,
  System.Classes,
  System.IniFiles,
  uDataModule;

type
  TConexao = Class(TObject)
  private
    FConn: TFDConnection;
    procedure ConfigureConection;

  public
    constructor Create;
    destructor Destroy; override;

    function GetConn: TFDConnection;
    function CreateQuery: TFDQuery;

    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
  end;

implementation

{ TConexao }

procedure TConexao.CommitTransaction;
begin
  if FConn.InTransaction then
    FConn.Commit;
end;

procedure TConexao.ConfigureConection;
var
  vConnectionParams: TStringList;
  vIniFile: TIniFile;
  vIniFileName: string;
begin
  vConnectionParams := TStringList.Create;
  try
    vIniFileName := 'D:\Portifolio\Delphi\desafio_delphi_03\docs\config\config.ini';

    if not FileExists(vIniFileName) then
    begin
      ShowMessage('Arquivo de configuração INI não encontrado: ' + vIniFileName);
      Exit;
    end;

    vIniFile := TIniFile.Create(vIniFileName);
    try
      vConnectionParams.Add('User_Name=' + vIniFile.ReadString('Database', 'User_Name', ''));
      vConnectionParams.Add('Password='  + vIniFile.ReadString('Database', 'Password', ''));
      vConnectionParams.Add('Database='  + vIniFile.ReadString('Database', 'Database', ''));
      vConnectionParams.Add('DriverId=FB');

      FConn.Params.Clear;
      FConn.Params.AddStrings(vConnectionParams);
      FConn.LoginPrompt := False;

      try
        FConn.Open;
      except
        on E: Exception do
          ShowMessage('Erro ao conectar: ' + E.Message);
      end;

    finally
      vIniFile.Free;
    end;

  finally
    vConnectionParams.Free;
  end;
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);

  Self.ConfigureConection();
end;

function TConexao.CreateQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
  VQuery := TFDQuery.Create(nil);
  VQuery.Connection := FConn;

  Result := VQuery;
end;

destructor TConexao.Destroy;
begin
  FConn.Free;

  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;

procedure TConexao.RollbackTransaction;
begin
  if FConn.InTransaction then
    FConn.Rollback;
end;

procedure TConexao.StartTransaction;
begin
  if not FConn.InTransaction then
    FConn.StartTransaction;
end;

end.
