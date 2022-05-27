unit uProdutoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmProdutoCadastro = class(TForm)
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    edtPreco: TEdit;
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
  frmProdutoCadastro: TfrmProdutoCadastro;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmProdutoCadastro.btnCancelarClick(Sender: TObject);
begin
  DataModule1.qryProduto.Cancel;
  Close;
end;

procedure TfrmProdutoCadastro.btnOkClick(Sender: TObject);
begin
  if edtNome.Text = '' then
  begin
    MessageDlg('O campo nome não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
    edtNome.SetFocus;
    Abort;
  end;

  if DataModule1.qryProduto.Active = False then
     DataModule1.qryProduto.Open;

  DataModule1.qryProduto.FieldByName('nome').AsString := edtNome.Text;
  DataModule1.qryProduto.FieldByName('valor').AsString := edtPreco.Text;
  DataModule1.qryProduto.Post;

  Close;
end;

end.
