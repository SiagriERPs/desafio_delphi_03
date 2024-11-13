unit uFrmLimiteCredito;

interface

uses
  uFrmBasico,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFrmLimiteCredito = class(TFrmBasico)
    pnlMain: TPanel;
    lblTitulo: TLabel;
    spbPesquisa: TSpeedButton;
    lblName: TLabel;
    lblPrecoVenda: TLabel;
    spbCancelar: TSpeedButton;
    spbGravar: TSpeedButton;
    edtDistribuidor: TEdit;
    edtLimiteCredito: TEdit;
    procedure spbCancelarClick(Sender: TObject);
    procedure spbGravarClick(Sender: TObject);
    procedure spbPesquisaClick(Sender: TObject);
    procedure edtLimiteCreditoKeyPress(Sender: TObject; var Key: Char);
  private
    FLimiteCredito  : Currency;
    FDistribuidorId : Integer;
    FDistribuidor   : string;

    procedure Gravar;
    procedure Pesquisar;
  public
    property LimiteCredito  : Currency read FLimiteCredito  write FLimiteCredito;
    property DistribuidorId : Integer  read FDistribuidorId write FDistribuidorId;
    property Distribuidor   : string   read FDistribuidor   write FDistribuidor;
  end;

var
  FrmLimiteCredito: TFrmLimiteCredito;

implementation

{$R *.dfm}

uses
  uFrmPesquisaDistribuidor;

procedure TFrmLimiteCredito.edtLimiteCreditoKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, ',']) then
    Key := #0;
end;

procedure TFrmLimiteCredito.Gravar;
begin
  try
    FLimiteCredito := StrToCurr(edtLimiteCredito.Text);
    FDistribuidor  := edtDistribuidor.Text;

    ModalResult    := mrOk;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao gravar limite de crédito: ' + E.Message);
      ModalResult := mrNone;
    end;
  end;
end;

procedure TFrmLimiteCredito.Pesquisar;
begin
  Application.CreateForm(TfrmPesquisaDistribuidor, FrmPesquisaDistribuidor);
  try
    FrmPesquisaDistribuidor.ShowModal;

    if FrmPesquisaDistribuidor.ModalResult = mrCancel then
    begin
      edtDistribuidor.Clear;
      Exit;
    end
    else if FrmPesquisaDistribuidor.ModalResult = mrOk then
    begin
      FDistribuidorId      := FrmPesquisaDistribuidor.qryPesquisaDistribuidorDISTRIBUIDOR_ID.AsInteger;
      FDistribuidor        := FrmPesquisaDistribuidor.qryPesquisaDistribuidorNOME.AsString;
      edtDistribuidor.Text := FDistribuidor;
    end;

  finally
    FreeAndNil(FrmPesquisaDistribuidor);
  end;
end;

procedure TFrmLimiteCredito.spbCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLimiteCredito.spbGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFrmLimiteCredito.spbPesquisaClick(Sender: TObject);
begin
  Pesquisar;
end;

end.
