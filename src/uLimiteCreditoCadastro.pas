unit uLimiteCreditoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Mask;

type
  TfrmLimiteCreditoCadastro = class(TForm)
    Label5: TLabel;
    cboDistribuidor: TDBLookupComboBox;
    Label2: TLabel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    edtValor: TMaskEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLimiteCreditoCadastro: TfrmLimiteCreditoCadastro;

implementation

{$R *.dfm}

uses uProdutorCadastro;

procedure TfrmLimiteCreditoCadastro.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLimiteCreditoCadastro.btnOkClick(Sender: TObject);
begin
  if not frmProdutorCadastro.cdsLimiteCredito.Locate('distribuidor', cboDistribuidor.KeyValue, []) then
    frmProdutorCadastro.cdsLimiteCredito.AppendRecord([cboDistribuidor.KeyValue,
                                                       cboDistribuidor.Text,
                                                       edtValor.Text])
  else
    begin
      MessageDlg('Esse distibuidor já foi adicionado. Verifique', mtInformation, [mbOk], 0);
      Abort;
    end;

  Close;
end;

end.
