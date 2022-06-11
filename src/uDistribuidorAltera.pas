unit uDistribuidorAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmDistribuidorAltera = class(TForm)
    grdDistribuidor: TDBGrid;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDistribuidorAltera: TfrmDistribuidorAltera;

implementation

{$R *.dfm}

uses uDM, uDistribuidorCadastro;

procedure TfrmDistribuidorAltera.btnAlterarClick(Sender: TObject);
var
  lfrmDistribuidorCadastro: TfrmDistribuidorCadastro;
begin
  lfrmDistribuidorCadastro := TfrmDistribuidorCadastro.Create(Application);

  try
    lfrmDistribuidorCadastro.Codigo := DM.qryDistribuidor.FieldByName('Codigo').AsInteger;
    lfrmDistribuidorCadastro.Nome := DM.qryDistribuidor.FieldByName('nome').AsString;
    lfrmDistribuidorCadastro.CPFCNPJ := DM.qryDistribuidor.FieldByName('cpfcnpj').AsString;
    lfrmDistribuidorCadastro.ShowModal;
    DM.qryDistribuidor.DisableControls;
  finally
    FreeAndNil(lfrmDistribuidorCadastro);
    DM.qryDistribuidor.Close;
    DM.qryDistribuidor.Open;
    DM.qryDistribuidor.EnableControls;
  end;
end;

procedure TfrmDistribuidorAltera.btnFecharClick(Sender: TObject);
begin
  DM.qryDistribuidor.Close;
  Close;
end;

procedure TfrmDistribuidorAltera.FormShow(Sender: TObject);
begin
  DM.qryDistribuidor.Open;
end;

end.
