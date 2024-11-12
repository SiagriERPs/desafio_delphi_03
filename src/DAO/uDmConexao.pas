unit uDMConexao;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Phys.FB,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait;

type
  TDMConexao = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    FConn: TFDConnection;
    FDQuery1: TFDQuery;
    class var FInstance: TDMConexao;
    constructor Create(AOwner: TComponent); override;
  public
    class function GetInstance: TDMConexao;
    function GetConnection: TFDConnection;
    function DataSet: TDataSet;
    procedure SQL(Value: string);
    procedure Open;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TDMConexao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConn := TFDConnection.Create(nil);
  FConn.DriverName := 'FB';
  FConn.Params.Database := 'C:\Fontes\desafio_delphi_03\data\CONTROLE_DE_NEGOCIACOES.FDB';
  FConn.Params.UserName := 'SYSDBA';
  FConn.Params.Password := 'masterkey';
  FConn.Params.Add('CharacterSet=utf8');
  FConn.LoginPrompt := False;
  FConn.Connected := True;

end;

class function TDMConexao.GetInstance: TDMConexao;
begin
  if not Assigned(FInstance) then
    FInstance := TDMConexao.Create(nil);
  Result := FInstance;
end;

function TDMConexao.DataSet: TDataSet;
begin
  Result := FDQuery1;
end;

procedure TDMConexao.Open;
begin
  FDQuery1.Open;
end;

procedure TDMConexao.SQL(Value: string);
begin
  FDQuery1.SQL.Text := Value;
end;

function TDMConexao.GetConnection: TFDConnection;
begin
  Result := FConn;
end;

initialization
  TDMConexao.FInstance := nil;

finalization
  if Assigned(TDMConexao.FInstance) then
    TDMConexao.FInstance.Free;

end.

