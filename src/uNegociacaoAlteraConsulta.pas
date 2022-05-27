unit uNegociacaoAlteraConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmNegociacaoAlteraConsulta = class(TForm)
    grdDistribuidor: TDBGrid;
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
    RadioGroup1: TRadioGroup;
    edtConsulta: TEdit;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroup1Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNegociacaoAlteraConsulta: TfrmNegociacaoAlteraConsulta;

implementation

{$R *.dfm}

uses uDM, uNegociacaoCadatro;

procedure TfrmNegociacaoAlteraConsulta.btnAlterarClick(Sender: TObject);
begin
  if DataModule1.qryNegociacao.Active = False then
     DataModule1.qryNegociacao.Open;

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

  DataModule1.qryNegociacao.Edit;

  frmNegociacaoCadastro.cboDistribuidor.KeyValue := DataModule1.qryConsultaNegociacao.FieldByName('distribuidor').AsInteger;
  frmNegociacaoCadastro.cboDistribuidor.Enabled := False;
  frmNegociacaoCadastro.cboProdutor.KeyValue := DataModule1.qryConsultaNegociacao.FieldByName('produtor').AsInteger;
  frmNegociacaoCadastro.cboProdutor.Enabled := False;
  frmNegociacaoCadastro.edtData.Text := DataModule1.qryConsultaNegociacao.FieldByName('data').AsString;
  frmNegociacaoCadastro.edtData.Enabled := False;
  frmNegociacaoCadastro.cboStatus.ItemIndex := DataModule1.qryConsultaNegociacao.FieldByName('status').AsInteger;
  frmNegociacaoCadastro.cboStatus.Enabled := True;
  frmNegociacaoCadastro.edtTotal.Text := DataModule1.qryConsultaNegociacao.FieldByName('valor').AsString;

  frmNegociacaoCadastro.spdAdicionarUmProduto.Enabled := False;
  frmNegociacaoCadastro.spdAdicionarTodosProdutos.Enabled := False;
  frmNegociacaoCadastro.spdRemoveUmProduto.Enabled := False;
  frmNegociacaoCadastro.spdRemoveTodosProdutos.Enabled := False;
  frmNegociacaoCadastro.grdProdutosDisponiveis.Enabled := False;
  frmNegociacaoCadastro.grdProdutosNegociados.Enabled := False;

  frmNegociacaoCadastro.ShowModal;
end;

procedure TfrmNegociacaoAlteraConsulta.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNegociacaoAlteraConsulta.edtConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if RadioGroup1.ItemIndex = 0 then
    DataModule1.qryConsultaNegociacao.IndexName := 'IDXPRODUTOR'
  else
    DataModule1.qryConsultaNegociacao.IndexName := 'IDXDISTRIBUIDOR';

  DataModule1.qryConsultaNegociacao.FindNearest([edtConsulta.Text]);
end;

procedure TfrmNegociacaoAlteraConsulta.FormShow(Sender: TObject);
begin
  if DataModule1.qryConsultaNegociacao.Active = False then
    DataModule1.qryConsultaNegociacao.Open;
end;

procedure TfrmNegociacaoAlteraConsulta.RadioGroup1Click(Sender: TObject);
begin
  edtConsulta.Clear;
end;

end.
