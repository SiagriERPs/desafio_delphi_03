unit ConexaoDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, Vcl.Dialogs, System.IniFiles, Winapi.Windows, Vcl.Forms,
  System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TTipoTela = (tpUnknow, tpCadastro, tpConsulta);

  TDM = class(TDataModule)
    Link: TFDPhysFBDriverLink;
    con: TFDConnection;
    ImageList1: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

  vgs_BANCO_CAMINHO, vgs_BANCO_IP, vgs_BANCO_PORTA, vgs_CAMPO_CHAVE, vgs_SQLPADRAO: String;
  vgs_TELA: TTipoTela;
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDM.DataModuleCreate(Sender: TObject);
var
  _ArqINI: TIniFile;
begin
  con.Connected := False;
  try
    if not FileExists(ExtractFilePath(Application.ExeName) + 'Config.ini') then
    begin
      _ArqINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
      _ArqINI.WriteString('SERVIDOR_BANCO_DADOS', 'CAMINHO', 'C:\Aliare\data\Dados.FDB');
      _ArqINI.WriteString('SERVIDOR_IP', 'IP', '127.0.0.1');
      _ArqINI.WriteString('SERVIDOR_IP', 'PORTA', '3050');
      FreeAndNil(_ArqINI);
    end;

    _ArqINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
    vgs_BANCO_IP := _ArqINI.ReadString('SERVIDOR_IP', 'IP', '127.0.0.1');
    vgs_BANCO_CAMINHO := _ArqINI.ReadString('SERVIDOR_BANCO_DADOS', 'CAMINHO', 'C:\SysVenda\Dados\Dados.FDB');
    vgs_BANCO_PORTA := _ArqINI.ReadString('SERVIDOR_IP', 'PORTA', '3050');
  finally
    FreeAndNil(_ArqINI);
  end;

  if vgs_BANCO_IP.Trim.Contains('/') then
    vgs_BANCO_IP := vgs_BANCO_IP.Trim.split(['/'])[0];

  try
    con.Params.Clear;
    con.Params.Values['Database'] := vgs_BANCO_CAMINHO.Trim;
    con.Params.Values['User_Name'] := 'SYSDBA';
    con.Params.Values['Password'] := 'masterkey';
    con.Params.Values['Protocol'] := 'TCPIP';
    con.Params.Values['RoleName'] := 'RDB$ADMIN';
    con.Params.Values['Server'] := vgs_BANCO_IP.Trim;
    con.Params.Values['PageSize'] := '4096';
    con.Params.Values['DriverID'] := 'FB';
    con.Params.Values['CharacterSet'] := 'ISO8859_2';
    con.Params.Values['Port'] := vgs_BANCO_PORTA.Trim;
    Link.VendorLib := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
    con.Connected := True;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('Erro ao efetuar conexão com banco de dados:' + sLineBreak +
        sLineBreak + 'Servidor: ' + vgs_BANCO_IP +
        sLineBreak + 'Base de dados: ' + vgs_BANCO_CAMINHO + sLineBreak +
        E.Message + 'Verifique as configurações de acesso ou entre em contato com suporte técnico.'), 'Atenção', 16);
      ExitProcess(0);
      raise;
    end;
  end;
end;

end.
