unit uFrmPesquisaProdutoNegociacao;

interface

uses
  uFrmBasico,
  uFrmPesquisaBasico,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uDataModule,
  uSistemaController,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFrmPesquisaProdutoNegociacao = class(TFrmBasico)
    pnlMain: TPanel;
    lblTitulo: TLabel;
    spbPesquisa: TSpeedButton;
    lblName: TLabel;
    spbCancelar: TSpeedButton;
    spbGravar: TSpeedButton;
    edtNome: TEdit;
    gbDadosProduto: TGroupBox;
    edtQuantidade: TEdit;
    lblQtd: TLabel;
    edtPreco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtTotal: TEdit;
    Label4: TLabel;
    procedure spbPesquisaClick(Sender: TObject);
    procedure spbCancelarClick(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure spbGravarClick(Sender: TObject);
  private
    FProdutoId  : Integer;
    FProduto    : string;
    FQuantidade : Integer;
    FPreco      : Currency;
    FVlrTotal   : Currency;

    procedure Gravar;
    procedure Pesquisa;
    procedure ProcessaQtdItem;
  public
    property ProdutoId  : Integer  read FProdutoId  write FProdutoId;
    property Produto    : string   read FProduto    write FProduto;
    property Quantidade : Integer  read FQuantidade write FQuantidade;
    property Preco      : Currency read FPreco      write FPreco;
    property VlrTotal   : Currency read FVlrTotal   write FVlrTotal;

  end;

var
  FrmPesquisaProdutoNegociacao: TFrmPesquisaProdutoNegociacao;

implementation

{$R *.dfm}

uses
  uFrmPesquisaProduto;

procedure TFrmPesquisaProdutoNegociacao.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    ProcessaQtdItem;
end;

procedure TFrmPesquisaProdutoNegociacao.Gravar;
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisaProdutoNegociacao.Pesquisa;
begin
  Application.CreateForm(TfrmPesquisaProduto, FrmPesquisaProduto);
  try
    FrmPesquisaProduto.ShowModal;

    if FrmPesquisaProduto.ModalResult = mrCancel then
    begin
      edtNome.Clear;
      Exit;
    end
    else if FrmPesquisaProduto.ModalResult = mrOk then
    begin
      FPreco        := FrmPesquisaProduto.qryPesquisaProdutoPRECO_VENDA.AsCurrency;

      if FPreco = 0 then
      begin
        ShowMessage('Para continuar, Informe o preço de venda do produto!');
        Exit;
      end;

      FProdutoId    := FrmPesquisaProduto.qryPesquisaProdutoPRODUTO_ID.AsInteger;
      FProduto      := FrmPesquisaProduto.qryPesquisaProdutoNOME.AsString;
      edtNome.Text  := IntToStr(ProdutoId) + ' - ' + Produto;
      edtPreco.Text := FormatCurr('#,##0.00', FPreco);
      edtTotal.Clear;

      edtQuantidade.SetFocus;
    end;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmPesquisaProdutoNegociacao.ProcessaQtdItem;
begin
  if Length(edtQuantidade.Text) > 0 then
  begin
    FQuantidade := StrToInt(edtQuantidade.Text);
    FVlrTotal   := FQuantidade * FPreco;

    edtTotal.Text := FormatCurr('#,##0.00', FVlrTotal);
  end;
end;

procedure TFrmPesquisaProdutoNegociacao.spbCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPesquisaProdutoNegociacao.spbGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFrmPesquisaProdutoNegociacao.spbPesquisaClick(Sender: TObject);
begin
  Pesquisa;
end;

end.
