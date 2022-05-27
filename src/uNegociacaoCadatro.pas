unit uNegociacaoCadatro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Datasnap.DBClient, Vcl.Mask;

type
  TfrmNegociacaoCadastro = class(TForm)
    Label1: TLabel;
    cboProdutor: TDBLookupComboBox;
    cboDistribuidor: TDBLookupComboBox;
    Label2: TLabel;
    Label3: TLabel;
    grdProdutosDisponiveis: TDBGrid;
    grdProdutosNegociados: TDBGrid;
    spdAdicionarUmProduto: TSpeedButton;
    spdAdicionarTodosProdutos: TSpeedButton;
    spdRemoveUmProduto: TSpeedButton;
    spdRemoveTodosProdutos: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    edtTotal: TEdit;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    Label6: TLabel;
    cboStatus: TComboBox;
    Label7: TLabel;
    cdsProdutosNegociados: TClientDataSet;
    dtsProdutosNegociados: TDataSource;
    cdsProdutosNegociadosNome: TStringField;
    cdsProdutosNegociadosNegociacao: TIntegerField;
    cdsProdutosNegociadosProduto: TIntegerField;
    edtData: TMaskEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdRemoveTodosProdutosClick(Sender: TObject);
    procedure spdAdicionarUmProdutoClick(Sender: TObject);
    procedure spdAdicionarTodosProdutosClick(Sender: TObject);
    procedure spdRemoveUmProdutoClick(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarTotalNegociado();
  public
    { Public declarations }
  end;

var
  frmNegociacaoCadastro: TfrmNegociacaoCadastro;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmNegociacaoCadastro.btnCancelarClick(Sender: TObject);
begin
  DataModule1.qryNegociacao.Cancel;
  Close;
end;

procedure TfrmNegociacaoCadastro.btnOkClick(Sender: TObject);
begin
  if not cboStatus.Enabled then
    begin
      ValidarTotalNegociado();

      try
        StrToDate(edtData.Text);
      except
        MessageDlg('A data da negociação não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
        edtData.SetFocus;
        Abort;
      end;

      DataModule1.qryNegociacao.FieldByName('produtor').AsInteger := cboProdutor.KeyValue;
      DataModule1.qryNegociacao.FieldByName('distribuidor').AsInteger := cboDistribuidor.KeyValue;
      DataModule1.qryNegociacao.FieldByName('valor').AsString := edtTotal.Text;
      DataModule1.qryNegociacao.FieldByName('data').AsString := edtData.Text;
      DataModule1.qryNegociacao.FieldByName('status').AsInteger := cboStatus.ItemIndex;
      DataModule1.qryNegociacao.Post;

      cdsProdutosNegociados.DisableControls;

      cdsProdutosNegociados.First;

      while not cdsProdutosNegociados.Eof do
      begin
        DataModule1.qryNegociacaoDetalhe.Append;
        DataModule1.qryNegociacaoDetalhe.FieldByName('produto').AsString := cdsProdutosNegociados.FieldByName('produto').AsString;
        DataModule1.qryNegociacaoDetalhe.FieldByName('negociacao').AsString := DataModule1.qryNegociacao.FieldByName('codigo').AsString;
        DataModule1.qryNegociacaoDetalhe.Post;

        cdsProdutosNegociados.Next;
      end;

      cdsProdutosNegociados.EnableControls;
    end
  else
    begin
      DataModule1.qryNegociacao.FieldByName('status').AsInteger := cboStatus.ItemIndex;
      DataModule1.qryNegociacao.Post;
    end;

  Close;
end;

procedure TfrmNegociacaoCadastro.FormShow(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  DataModule1.qryNegociacaoDetalhe.Close;
  DataModule1.qryNegociacaoDetalhe.ParamByName('pNegociacao').AsInteger := DataModule1.qryConsultaNegociacao.FieldByName('codigo').AsInteger;
  DataModule1.qryNegociacaoDetalhe.Open;
  lProduto := '';
  lTotal := 0;

  while not DataModule1.qryNegociacaoDetalhe.Eof do
  begin
    DataModule1.qryProduto.Locate('produto', DataModule1.qryNegociacaoDetalhe.FieldByName('produto').AsString, []);

    if lProduto = '' then
      lProduto := DataModule1.qryNegociacaoDetalhe.FieldByName('produto').AsString
    else
      lProduto := lProduto + ',' + DataModule1.qryNegociacaoDetalhe.FieldByName('produto').AsString;

    lTotal := lTotal + DataModule1.qryProduto.FieldByName('valor').AsFloat;

    cdsProdutosNegociados.AppendRecord([DataModule1.qryNegociacaoDetalhe.FieldByName('produto').AsString,
                                        DataModule1.qryProduto.FieldByName('nome').AsString]);

    DataModule1.qryNegociacaoDetalhe.Next;

    if cboStatus.CanFocus then
      cboStatus.SetFocus
    else
      cboProdutor.SetFocus;
  end;

 if lProduto = '' then
   begin
     DataModule1.qryConsultaProduto.Close;
     DataModule1.qryConsultaProduto.Open;
   end
 else
   begin
     DataModule1.qryConsultaProduto.Close;
     DataModule1.qryConsultaProduto.SQL.Clear;
     DataModule1.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
     DataModule1.qryConsultaProduto.SQL.Add('WHERE CODIGO NOT IN(' + lProduto + ')');
     DataModule1.qryConsultaProduto.Open;
   end;

  edtTotal.Text := FormatFloat('0.00', lTotal);
end;

procedure TfrmNegociacaoCadastro.spdAdicionarUmProdutoClick(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  cdsProdutosNegociados.DisableControls;
  cdsProdutosNegociados.AppendRecord([DataModule1.qryConsultaProduto.FieldByName('codigo').AsString,
                                      DataModule1.qryConsultaProduto.FieldByName('nome').AsString]);

  cdsProdutosNegociados.First;
  lTotal := 0;

  while not cdsProdutosNegociados.Eof do
  begin
    DataModule1.qryProduto.Locate('codigo', cdsProdutosNegociados.FieldByName('produto').AsString, []);

    if lProduto = '' then
      lProduto := cdsProdutosNegociados.FieldByName('produto').AsString
    else
      lProduto := lProduto + ',' + cdsProdutosNegociados.FieldByName('produto').AsString;

    lTotal := lTotal + DataModule1.qryProduto.FieldByName('valor').AsFloat;

    cdsProdutosNegociados.Next;
  end;

  cdsProdutosNegociados.EnableControls;

  edtTotal.Text := FormatFloat('0,00', lTotal);

  DataModule1.qryConsultaProduto.Close;
  DataModule1.qryConsultaProduto.SQL.Clear;
  DataModule1.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
  DataModule1.qryConsultaProduto.SQL.Add('WHERE CODIGO NOT IN(' + lProduto + ')');
  DataModule1.qryConsultaProduto.Open;
end;

procedure TfrmNegociacaoCadastro.spdRemoveTodosProdutosClick(Sender: TObject);
begin
  cdsProdutosNegociados.EmptyDataSet;

  DataModule1.qryConsultaProduto.Close;
  DataModule1.qryConsultaProduto.SQL.Clear;
  DataModule1.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
  DataModule1.qryConsultaProduto.Open;
end;

procedure TfrmNegociacaoCadastro.spdRemoveUmProdutoClick(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  cdsProdutosNegociados.DisableControls;
  cdsProdutosNegociados.Delete;
  cdsProdutosNegociados.First;
  lTotal := 0;

  while not cdsProdutosNegociados.Eof do
  begin
    DataModule1.qryProduto.Locate('codigo', cdsProdutosNegociados.FieldByName('produto').AsString, []);

    if lProduto = '' then
      lProduto := cdsProdutosNegociados.FieldByName('produto').AsString
    else
      lProduto := lProduto + ',' + cdsProdutosNegociados.FieldByName('produto').AsString;

    lTotal := lTotal + DataModule1.qryProduto.FieldByName('valor').AsFloat;

    cdsProdutosNegociados.Next;
  end;

  cdsProdutosNegociados.EnableControls;

  edtTotal.Text := FormatFloat('0.00', lTotal);

  DataModule1.qryConsultaProduto.Close;
  DataModule1.qryConsultaProduto.SQL.Clear;
  DataModule1.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');

  if lProduto <> '' then
    DataModule1.qryConsultaProduto.SQL.Add('WHERE CODIGO NOT IN(' + lProduto + ')');

  DataModule1.qryConsultaProduto.Open;
end;

procedure TfrmNegociacaoCadastro.ValidarTotalNegociado();
var
  lLimiteCreditoTotal,
  lLimiteCreditoUsado : Double;
begin
  DataModule1.qryConsultaCredito.Close;
  DataModule1.qryConsultaCredito.ParamByName('produtor').AsInteger := cboProdutor.KeyValue;
  DataModule1.qryConsultaCredito.ParamByName('distribuidor').AsInteger := cboDistribuidor.KeyValue;
  DataModule1.qryConsultaCredito.Open;

  lLimiteCreditoTotal := DataModule1.qryConsultaCredito.FieldByName('valor').AsFloat;

  DataModule1.qryConsultaCreditoUsado.Close;
  DataModule1.qryConsultaCreditoUsado.ParamByName('produtor').AsInteger := cboProdutor.KeyValue;
  DataModule1.qryConsultaCreditoUsado.ParamByName('distribuidor').AsInteger := cboDistribuidor.KeyValue;
  DataModule1.qryConsultaCreditoUsado.Open;

  lLimiteCreditoUsado := DataModule1.qryConsultaCreditoUsado.FieldByName('valor').AsFloat + StrToFloat(edtTotal.Text);

  if lLimiteCreditoUsado > lLimiteCreditoTotal then
  begin
    MessageDlg('O limite de crédito é insuficiente.', mtInformation, [mbOk], 0);
    Abort;
  end;

end;

procedure TfrmNegociacaoCadastro.spdAdicionarTodosProdutosClick(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  DataModule1.qryConsultaProduto.DisableControls;
  cdsProdutosNegociados.DisableControls;
  DataModule1.qryConsultaProduto.First;
  lTotal := 0;

  while not DataModule1.qryConsultaProduto.Eof do
  begin
    DataModule1.qryProduto.Locate('codigo', DataModule1.qryConsultaProduto.FieldByName('codigo').AsString, []);

    if lProduto = '' then
      lProduto := DataModule1.qryConsultaProduto.FieldByName('codigo').AsString
    else
      lProduto := lProduto + ',' + DataModule1.qryConsultaProduto.FieldByName('codigo').AsString;

    lTotal := lTotal + DataModule1.qryProduto.FieldByName('valor').AsFloat;

    cdsProdutosNegociados.AppendRecord([DataModule1.qryConsultaProduto.FieldByName('codigo').AsString,
                                        DataModule1.qryConsultaProduto.FieldByName('nome').AsString,
                                        DataModule1.qryNegociacao.FieldByName('codigo').AsString]);

    DataModule1.qryConsultaProduto.Next;
  end;

  cdsProdutosNegociados.First;

  DataModule1.qryConsultaProduto.EnableControls;
  cdsProdutosNegociados.EnableControls;

  edtTotal.Text := FormatFloat('0.00', lTotal);

  DataModule1.qryConsultaProduto.Close;
end;

end.
