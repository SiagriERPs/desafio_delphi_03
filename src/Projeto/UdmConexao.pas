unit UdmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client, IniFiles, Winapi.Windows, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs;

type
  TdmConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDTransaction: TFDTransaction;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.DataModuleCreate(Sender: TObject);
var
  ArquivoINI : TIniFile;
begin
  try
       FDConnection.Connected := False;

       if not FileExists(ExtractFilePath(Application.ExeName)+ 'Configuracao_BD.ini') then begin

           ShowMessage('Arquivo : [Configuracao_BD.ini] não foi encontrado!');
           Application.Terminate;
           Exit;
       end
       else
            ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'Configuracao_BD.ini');

       FDConnection.Params.Database := ArquivoINI.ReadString('FIREBIRD', 'Database', '');
       FDConnection.Params.UserName := ArquivoINI.ReadString('FIREBIRD', 'User', ''    );
       FDConnection.Params.Password := ArquivoINI.ReadString('FIREBIRD', 'Password', '');

       FDConnection.Connected := True;

  except
    on E:Exception do
       raise Exception.CreateFmt('Erro ao tentar conectar ao banco de dados  = %s', [E.Message]);
  end;
end;

end.
