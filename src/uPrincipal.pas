unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Produtor1: TMenuItem;
    Cadastro1: TMenuItem;
    Alterao1: TMenuItem;
    Distribuidor1: TMenuItem;
    Cadastro2: TMenuItem;
    Alterao2: TMenuItem;
    Produto1: TMenuItem;
    Produto2: TMenuItem;
    Alterao3: TMenuItem;
    Negociao1: TMenuItem;
    Negociao2: TMenuItem;
    Alterao5: TMenuItem;
    Image1: TImage;
    procedure Cadastro1Click(Sender: TObject);
    procedure Alterao1Click(Sender: TObject);
    procedure Cadastro2Click(Sender: TObject);
    procedure Alterao2Click(Sender: TObject);
    procedure Produto2Click(Sender: TObject);
    procedure Alterao3Click(Sender: TObject);
    procedure Negociao2Click(Sender: TObject);
    procedure Alterao5Click(Sender: TObject);
    procedure Consulta1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uProdutorCadastro, uProdutorAltera, uNegociacaoAlteraConsulta,
  uDistribuidorCadastro, uDistribuidorAltera, uNegociacaoCadatro,
  uProdutoCadastro, uProdutoAltera, uDM;

procedure TfrmPrincipal.Alterao1Click(Sender: TObject);
begin
  frmProdutorAltera.ShowModal;
end;

procedure TfrmPrincipal.Alterao2Click(Sender: TObject);
begin
  frmDistribuidorAltera.ShowModal;
end;

procedure TfrmPrincipal.Alterao3Click(Sender: TObject);
begin
  frmProdutoAltera.ShowModal;
end;

procedure TfrmPrincipal.Alterao5Click(Sender: TObject);
begin
  frmNegociacaoAlteraConsulta.ShowModal;
end;

procedure TfrmPrincipal.Cadastro1Click(Sender: TObject);
begin
  if DataModule1.qryProdutor.Active = False then
    DataModule1.qryProdutor.Open;

  frmProdutorCadastro.edtNome.Text := '';
  frmProdutorCadastro.edtCPFCNPJ.Text := '';

  if frmProdutorCadastro.cdsLimiteCredito.Active = False then
    frmProdutorCadastro.cdsLimiteCredito.CreateDataset
  else
    frmProdutorCadastro.cdsLimiteCredito.EmptyDataSet;

  DataModule1.qryProdutor.Append;
  frmProdutorCadastro.ShowModal;

end;

procedure TfrmPrincipal.Cadastro2Click(Sender: TObject);
begin
  if DataModule1.qryDistribuidor.Active = False then
     DataModule1.qryDistribuidor.Open;

  frmDistribuidorCadastro.edtNome.Text := '';
  frmDistribuidorCadastro.edtCPFCNPJ.Text := '';
  DataModule1.qryDistribuidor.Append;
  frmDistribuidorCadastro.ShowModal;
end;

procedure TfrmPrincipal.Consulta1Click(Sender: TObject);
begin
  frmNegociacaoAlteraConsulta.ShowModal;
end;

procedure TfrmPrincipal.Negociao2Click(Sender: TObject);
begin
  if DataModule1.qryNegociacao.Active = False then
    DataModule1.qryNegociacao.Open;

  if DataModule1.qryNegociacaoDetalhe.Active = False then
    DataModule1.qryNegociacaoDetalhe.Open;

  if DataModule1.qryProduto.Active = False then
    DataModule1.qryProduto.Open;

  if DataModule1.qryProdutor.Active = False then
     DataModule1.qryProdutor.Open;

  if DataModule1.qryDistribuidor.Active = False then
     DataModule1.qryDistribuidor.Open;

  if not frmNegociacaoCadastro.cdsProdutosNegociados.Active then
    frmNegociacaoCadastro.cdsProdutosNegociados.CreateDataSet
  else
    frmNegociacaoCadastro.cdsProdutosNegociados.EmptyDataSet;

  frmNegociacaoCadastro.edtTotal.Text := '';
  frmNegociacaoCadastro.edtData.Text := DateToStr(now);
  frmNegociacaoCadastro.cboStatus.ItemIndex := 0;
  frmNegociacaoCadastro.cboStatus.Enabled := False;

  frmNegociacaoCadastro.cboDistribuidor.Enabled := True;
  frmNegociacaoCadastro.cboProdutor.Enabled := True;
  frmNegociacaoCadastro.edtData.Enabled := True;
  //frmNegociacaoCadastro.edtTotal.Enabled := True;
  frmNegociacaoCadastro.spdAdicionarUmProduto.Enabled := True;
  frmNegociacaoCadastro.spdAdicionarTodosProdutos.Enabled := True;
  frmNegociacaoCadastro.spdRemoveUmProduto.Enabled := True;
  frmNegociacaoCadastro.spdRemoveTodosProdutos.Enabled := True;

  frmNegociacaoCadastro.grdProdutosDisponiveis.Enabled := True;
  frmNegociacaoCadastro.grdProdutosNegociados.Enabled := True;

  DataModule1.qryNegociacao.Append;
  frmNegociacaoCadastro.ShowModal;
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  if DataModule1.qryProduto.Active = False then
     DataModule1.qryProduto.Open;

  frmProdutoCadastro.edtNome.Text := '';
  frmProdutoCadastro.edtPreco.Text := '';
  DataModule1.qryProduto.Append;
  frmProdutoCadastro.ShowModal;
end;

end.
