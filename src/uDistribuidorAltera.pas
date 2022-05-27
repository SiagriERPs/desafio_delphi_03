unit uDistribuidorAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmDistribuidorAltera = class(TForm)
    grdDistribuidor: TDBGrid;
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
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
begin
  DataModule1.qryDistribuidor.Edit;

  frmDistribuidorCadastro.edtNome.Text := DataModule1.qryDistribuidor.FieldByName('nome').AsString;
  frmDistribuidorCadastro.edtCPFCNPJ.Text := DataModule1.qryDistribuidor.FieldByName('cpfcnpj').AsString;

  frmDistribuidorCadastro.ShowModal;
end;

procedure TfrmDistribuidorAltera.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDistribuidorAltera.FormShow(Sender: TObject);
begin
  if DataModule1.qryDistribuidor.Active = False then
    DataModule1.qryDistribuidor.Open;
end;

end.
