unit UDM;

interface
uses
  SysUtils, Classes, IniFiles, Data.DB, Data.SqlExpr, Forms, Data.DBXInterBase,
  Data.DBXPool, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, IBX.IBDatabase, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TDM = class(TDataModule)
    conexao: TFDConnection;
    driver: TFDPhysFBDriverLink;
    cursor: TFDGUIxWaitCursor;
    script: TFDScript;


    procedure CarregaBase;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation
uses UBD;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
    CarregaBase;
end;

procedure TDM.CarregaBase;
begin

    try
        conexao.Close;
        conexao.Connected := False;

        conexao.Open;
        conexao.Connected := True;
    except
      on e :Exception do
      begin
          //Application.Free;
      end;
    end;
end;

end.
