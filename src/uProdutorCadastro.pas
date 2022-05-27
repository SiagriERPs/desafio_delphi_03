unit uProdutorCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

type
  TfrmProdutorCadastro = class(TForm)
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    edtCPFCNPJ: TEdit;
    edtNome: TEdit;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    btnAdiciona: TBitBtn;
    btnRetira: TBitBtn;
    cdsLimiteCredito: TClientDataSet;
    dtsLimiteCredito: TDataSource;
    cdsLimiteCreditoditribuidor: TIntegerField;
    cdsLimiteCreditonomedistribuidor: TStringField;
    cdsLimiteCreditovalor: TFloatField;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAdicionaClick(Sender: TObject);
    procedure btnRetiraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutorCadastro: TfrmProdutorCadastro;

implementation

{$R *.dfm}

uses uDM, uLimiteCreditoCadastro;

procedure TfrmProdutorCadastro.btnAdicionaClick(Sender: TObject);
begin
  if DataModule1.qryDistribuidor.Active = False then
     DataModule1.qryDistribuidor.Open;

  frmLimiteCreditoCadastro.ShowModal;
end;

procedure TfrmProdutorCadastro.btnCancelarClick(Sender: TObject);
begin
  DataModule1.qryProdutor.Cancel;
  Close;
end;

procedure TfrmProdutorCadastro.btnOkClick(Sender: TObject);
begin
  if edtNome.Text = '' then
  begin
    MessageDlg('O campo nome não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
    edtNome.SetFocus;
    Abort;
  end;

  if DataModule1.qryProdutor.Active = False then
     DataModule1.qryProdutor.Open;

  DataModule1.qryProdutor.FieldByName('nome').AsString := edtNome.Text;
  DataModule1.qryProdutor.FieldByName('cpfcnpj').AsString := edtCPFCNPJ.Text;
  DataModule1.qryProdutor.Post;

  cdsLimiteCredito.DisableControls;
  cdsLimiteCredito.First;

  while not cdsLimiteCredito.Eof do
  begin
    DataModule1.qryCredito.Append;
    DataModule1.qryCredito.FieldByName('produtor').AsString := DataModule1.qryProdutor.FieldByName('codigo').AsString;
    DataModule1.qryCredito.FieldByName('distribuidor').AsString := cdsLimiteCredito.FieldByName('distribuidor').AsString;
    DataModule1.qryCredito.FieldByName('nomedistribuidor').AsString := cdsLimiteCredito.FieldByName('nomedistribuidor').AsString;
    DataModule1.qryCredito.FieldByName('valor').AsString := cdsLimiteCredito.FieldByName('valor').AsString;
    DataModule1.qryCredito.Post;

    cdsLimiteCredito.Next;
  end;

  cdsLimiteCredito.EnableControls;

  Close;
end;

procedure TfrmProdutorCadastro.btnRetiraClick(Sender: TObject);
begin
  if not cdsLimiteCredito.IsEmpty then
    cdsLimiteCredito.Delete;
end;

end.
