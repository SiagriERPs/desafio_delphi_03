unit uDistribuidorCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmDistribuidorCadastro = class(TForm)
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    edtCPFCNPJ: TEdit;
    edtNome: TEdit;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDistribuidorCadastro: TfrmDistribuidorCadastro;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmDistribuidorCadastro.btnCancelarClick(Sender: TObject);
begin
  DataModule1.qryDistribuidor.Cancel;
  Close;
end;

procedure TfrmDistribuidorCadastro.btnOkClick(Sender: TObject);
begin
  if edtNome.Text = '' then
  begin
    MessageDlg('O campo nome não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
    edtNome.SetFocus;
    Abort;
  end;

  if DataModule1.qryDistribuidor.Active = False then
     DataModule1.qryDistribuidor.Open;

  DataModule1.qryDistribuidor.FieldByName('nome').AsString := edtNome.Text;
  DataModule1.qryDistribuidor.FieldByName('cpfcnpj').AsString := edtCPFCNPJ.Text;
  DataModule1.qryDistribuidor.Post;

  Close;
end;

end.
