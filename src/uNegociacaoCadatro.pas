unit uNegociacaoCadatro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Datasnap.DBClient, Vcl.Mask, FireDAC.Comp.Client;

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
    Label6: TLabel;
    cboStatus: TComboBox;
    Label7: TLabel;
    cdsProdutosNegociados: TClientDataSet;
    dtsProdutosNegociados: TDataSource;
    cdsProdutosNegociadosNome: TStringField;
    cdsProdutosNegociadosNegociacao: TIntegerField;
    cdsProdutosNegociadosProduto: TIntegerField;
    edtData: TMaskEdit;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdRemoveTodosProdutosClick(Sender: TObject);
    procedure spdAdicionarUmProdutoClick(Sender: TObject);
    procedure spdAdicionarTodosProdutosClick(Sender: TObject);
    procedure spdRemoveUmProdutoClick(Sender: TObject);
  private
    { Private declarations }
    FCodigoNegociacao,
    FCodigoProdutor,
    FCodigoDistribuidor: Integer;
    FNovaNegociacao: Boolean;
    FTotal,
    FDataNegociacao: String;
    FStatusNegociacao: Byte;

    function ValidarTotalNegociado(): Boolean;
    procedure CadastrarNegociacao(pCodigoNegociacao, pCodigoProdutor, pCodigoDistribuidor: Integer;
                                  pTotal, pData: String; pStatus: Byte);
    procedure CadastrarNegociacaoDetalhe(pCodigoNegociacao, pProduto: Integer);
    procedure AlterarNegociacao(pCodigoNegociacao: Integer; pStatus: Byte);
    function ObterValorDoProduto(pCodigoProduto: Integer): Double;
    function ValidarDados(): Boolean;
    procedure ObterProdutos(pCodigoNegociacao: Integer);
  public
    { Public declarations }
    property CodigoNegociacao: Integer read FCodigoNegociacao write FCodigoNegociacao;
    property CodigoProdutor: Integer read FCodigoProdutor write FCodigoProdutor;
    property CodigoDistribuidor: Integer read FCodigoDistribuidor write FCodigoDistribuidor;
    property Total: String write FTotal;
    property DataNegociacao: String write FDataNegociacao;
    property StatusNegociacao: Byte write FStatusNegociacao;
  end;

implementation

{$R *.dfm}

uses uDM, uPrincipal;

procedure TfrmNegociacaoCadastro.AlterarNegociacao(pCodigoNegociacao: Integer;
  pStatus: Byte);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('UPDATE negociacao');
    lQry.SQL.Add('SET  STATUS = :pStatus');
    lQry.SQL.Add('WHERE codigo = :pCodigo');

    lQry.ParamByName('pCodigo').AsInteger := pCodigoNegociacao;
    lQry.ParamByName('pStatus').AsInteger := pStatus;

    try
      lQry.ExecSQL;
      MessageDlg('Status alterado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao alterar o status da negociação.', mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmNegociacaoCadastro.btnCancelarClick(Sender: TObject);
begin
  DM.qryProdutor.Close;
  DM.qryDistribuidor.Close;
  DM.qryConsultaProduto.Close;
  cdsProdutosNegociados.EmptyDataSet;
  Close;
end;

procedure TfrmNegociacaoCadastro.btnOkClick(Sender: TObject);
begin
  if not cboStatus.Enabled then
    begin
      if not ValidarDados() then
        Abort;

      CadastrarNegociacao(FCodigoNegociacao, cboProdutor.KeyValue, cboDistribuidor.KeyValue,
                          edtTotal.Text, edtData.Text, cboStatus.ItemIndex);

      cdsProdutosNegociados.DisableControls;

      cdsProdutosNegociados.First;

      while not cdsProdutosNegociados.Eof do
      begin
        CadastrarNegociacaoDetalhe(FCodigoNegociacao, cdsProdutosNegociados.FieldByName('produto').AsInteger);

        cdsProdutosNegociados.Next;
      end;

      cdsProdutosNegociados.EnableControls;
    end
  else
    AlterarNegociacao(FCodigoNegociacao, cboStatus.ItemIndex);

  Close;
end;

procedure TfrmNegociacaoCadastro.CadastrarNegociacao(pCodigoNegociacao,
  pCodigoProdutor, pCodigoDistribuidor: Integer; pTotal, pData: String;
  pStatus: Byte);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('INSERT INTO negociacao (CODIGO, PRODUTOR, DISTRIBUIDOR, VALOR, DATA, STATUS)');
    lQry.SQL.Add('VALUES (:pCODIGO, :pPRODUTOR, :pDISTRIBUIDOR, :pVALOR, :pDATA, :pSTATUS)');

    lQry.ParamByName('pCODIGO').AsInteger := pCodigoNegociacao;
    lQry.ParamByName('pPRODUTOR').AsInteger := pCodigoProdutor;
    lQry.ParamByName('pDISTRIBUIDOR').AsInteger := pCodigoDistribuidor;
    lQry.ParamByName('pVALOR').AsFloat := StrToFloat(pTotal);
    lQry.ParamByName('pDATA').AsString := pData;
    lQry.ParamByName('pSTATUS').AsInteger := pStatus;

    try
      lQry.ExecSQL;

    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao inserir a negociação ', mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmNegociacaoCadastro.CadastrarNegociacaoDetalhe(
  pCodigoNegociacao, pProduto: Integer);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('INSERT INTO negociacao_detalhe (NEGOCIACAO, PRODUTO)');
    lQry.SQL.Add('VALUES (:pNEGOCIACAO, :pPRODUTO)');

    lQry.ParamByName('pNEGOCIACAO').AsInteger := pCodigoNegociacao;
    lQry.ParamByName('pPRODUTO').AsInteger := pProduto;

    try
      lQry.ExecSQL;
      MessageDlg('Negociação cadastrada com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao inserir a negociação ', mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmNegociacaoCadastro.FormShow(Sender: TObject);
begin
  cdsProdutosNegociados.CreateDataSet;

  if FCodigoNegociacao = 0 then
    begin
      DM.qryProdutor.Open;
      DM.qryDistribuidor.Open;
      DM.qryConsultaProduto.SQL.Clear;
      DM.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
      DM.qryConsultaProduto.Open;

      if cboProdutor.CanFocus then
        cboProdutor.SetFocus;

      FCodigoNegociacao := DM.ObterCodigoTabela('Codigo', 'Negociacao');
      FNovaNegociacao := True;
      DM.qryConsultaProduto.Open;
      edtData.Text := DateToStr(now);
      cboStatus.ItemIndex := 0;
      cboStatus.Enabled := False;
    end
  else
    begin
      DM.qryProdutor.Open;
      DM.qryDistribuidor.Open;

      DM.qryProdutor.Locate('codigo', FCodigoProdutor, []);
      cboProdutor.KeyValue := DM.qryProdutor.FieldByName('Codigo').AsString;

      DM.qryDistribuidor.Locate('codigo', FCodigoDistribuidor, []);
      cboDistribuidor.KeyValue := DM.qryDistribuidor.FieldByName('Codigo').AsString;

      ObterProdutos(FCodigoNegociacao);

      if cboStatus.CanFocus then
        cboStatus.SetFocus;

      FNovaNegociacao := False;
      edtTotal.Text := FTotal;
      edtData.Text := FDataNegociacao;
      cboStatus.ItemIndex := FStatusNegociacao;
      cboDistribuidor.Enabled := False;
      cboProdutor.Enabled := False;
      edtData.Enabled := False;
      spdAdicionarUmProduto.Enabled := False;
      spdAdicionarTodosProdutos.Enabled := False;
      spdRemoveUmProduto.Enabled := False;
      spdRemoveTodosProdutos.Enabled := False;
      grdProdutosDisponiveis.Enabled := False;
      grdProdutosNegociados.Enabled := False;
    end;
end;

procedure TfrmNegociacaoCadastro.ObterProdutos(pCodigoNegociacao: Integer);
var
  lProduto: String;
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('SELECT p.Codigo, p.Nome');
    lQry.SQL.Add('FROM PRODUTO p');
    lQry.SQL.Add('INNER JOIN NEGOCIACAO_DETALHE n on n.Produto = p.Codigo');
    lQry.SQL.Add('WHERE n.Negociacao = :pCodigoNegociacao');

    lQry.ParamByName('pCodigoNegociacao').AsInteger := pCodigoNegociacao;

    lQry.Open;

    while not lQry.Eof do
    begin
      if lProduto = '' then
        lProduto := lQry.FieldByName('Codigo').AsString
      else
        lProduto := lProduto + ',' + lQry.FieldByName('Codigo').AsString;

      cdsProdutosNegociados.DisableControls;
      cdsProdutosNegociados.AppendRecord([lQry.FieldByName('codigo').AsString,
                                          lQry.FieldByName('nome').AsString]);
      lQry.Next;
    end;

    cdsProdutosNegociados.EnableControls;

    DM.qryConsultaProduto.Close;
    DM.qryConsultaProduto.SQL.Clear;
    DM.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
    DM.qryConsultaProduto.SQL.Add('WHERE CODIGO NOT IN(' + lProduto + ')');
    DM.qryConsultaProduto.Open;
  finally
    lQry.Close;
    FreeAndNil(lQry);
  end;
end;

function TfrmNegociacaoCadastro.ObterValorDoProduto(
  pCodigoProduto: Integer): Double;
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('SELECT valor');
    lQry.SQL.Add('FROM PRODUTO');
    lQry.SQL.Add('WHERE CODIGO = :pPRODUTO');

    lQry.ParamByName('pPRODUTO').AsInteger := pCodigoProduto;

    try
      lQry.Open;
      Result := lQry.FieldByName('valor').AsFloat;
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao obter o valor do produto.', mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    lQry.Close;
    FreeAndNil(lQry);
  end;
end;

procedure TfrmNegociacaoCadastro.spdAdicionarUmProdutoClick(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  //Se não tem mais produto para selecionar não segue adiante
  if DM.qryConsultaProduto.IsEmpty then
    Abort;

  cdsProdutosNegociados.DisableControls;
  cdsProdutosNegociados.AppendRecord([DM.qryConsultaProduto.FieldByName('codigo').AsString,
                                      DM.qryConsultaProduto.FieldByName('nome').AsString]);

  cdsProdutosNegociados.First;
  lTotal := 0;

  while not cdsProdutosNegociados.Eof do
  begin
    if lProduto = '' then
      lProduto := cdsProdutosNegociados.FieldByName('produto').AsString
    else
      lProduto := lProduto + ',' + cdsProdutosNegociados.FieldByName('produto').AsString;

    lTotal := lTotal + ObterValorDoProduto(cdsProdutosNegociados.FieldByName('produto').AsInteger);

    cdsProdutosNegociados.Next;
  end;

  cdsProdutosNegociados.EnableControls;

  edtTotal.Text := FormatFloat('0.00', lTotal);

  DM.qryConsultaProduto.Close;
  DM.qryConsultaProduto.SQL.Clear;
  DM.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
  DM.qryConsultaProduto.SQL.Add('WHERE CODIGO NOT IN(' + lProduto + ')');
  DM.qryConsultaProduto.Open;
end;

procedure TfrmNegociacaoCadastro.spdRemoveTodosProdutosClick(Sender: TObject);
begin
  //Se não tem mais produto para selecionar não segue adiante
  if cdsProdutosNegociados.IsEmpty then
    Abort;

  cdsProdutosNegociados.EmptyDataSet;

  DM.qryConsultaProduto.Close;
  DM.qryConsultaProduto.SQL.Clear;
  DM.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');
  DM.qryConsultaProduto.Open;
end;

procedure TfrmNegociacaoCadastro.spdRemoveUmProdutoClick(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  //Se não tem mais produto para selecionar não segue adiante
  if cdsProdutosNegociados.IsEmpty then
    Abort;

  cdsProdutosNegociados.DisableControls;
  cdsProdutosNegociados.Delete;
  cdsProdutosNegociados.First;
  lTotal := 0;

  while not cdsProdutosNegociados.Eof do
  begin
    if lProduto = '' then
      lProduto := cdsProdutosNegociados.FieldByName('produto').AsString
    else
      lProduto := lProduto + ',' + cdsProdutosNegociados.FieldByName('produto').AsString;

    lTotal := lTotal + ObterValorDoProduto(cdsProdutosNegociados.FieldByName('produto').AsInteger);

    cdsProdutosNegociados.Next;
  end;

  cdsProdutosNegociados.EnableControls;

  edtTotal.Text := FormatFloat('0.00', lTotal);

  DM.qryConsultaProduto.Close;
  DM.qryConsultaProduto.SQL.Clear;
  DM.qryConsultaProduto.SQL.Add('SELECT * FROM PRODUTO');

  if lProduto <> '' then
    DM.qryConsultaProduto.SQL.Add('WHERE CODIGO NOT IN(' + lProduto + ')');

  DM.qryConsultaProduto.Open;
end;

function TfrmNegociacaoCadastro.ValidarDados: Boolean;
begin
  Result := False;

  if cboProdutor.Text = '' then
    begin
      MessageDlg('O campo Produtor não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
      cboProdutor.SetFocus;
    end
  else
    if cboDistribuidor.Text = '' then
      begin
        MessageDlg('O campo Distribuidor não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
        cboDistribuidor.SetFocus;
      end
    else
      if cdsProdutosNegociados.IsEmpty then
        MessageDlg('Não foi selecionado nenhum produto para essa negociação. Verifique.', mtInformation, [mbOk], 0)
      else
        if not ValidarTotalNegociado() then
          MessageDlg('O limite de crédito é insuficiente.', mtInformation, [mbOk], 0)
        else
          try
            StrToDate(edtData.Text);
            Result := True;
          except
            MessageDlg('A data da negociação não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
            edtData.SetFocus;
          end;
end;

function TfrmNegociacaoCadastro.ValidarTotalNegociado(): Boolean;
var
  lLimiteCreditoTotal,
  lLimiteCreditoUsado : Double;
begin
  DM.qryConsultaCredito.Close;
  DM.qryConsultaCredito.ParamByName('pProdutor').AsInteger := cboProdutor.KeyValue;
  DM.qryConsultaCredito.ParamByName('pDistribuidor').AsInteger := cboDistribuidor.KeyValue;
  DM.qryConsultaCredito.Open;

  lLimiteCreditoTotal := DM.qryConsultaCredito.FieldByName('valor').AsFloat;

  DM.qryConsultaCreditoUsado.Close;
  DM.qryConsultaCreditoUsado.ParamByName('pProdutor').AsInteger := cboProdutor.KeyValue;
  DM.qryConsultaCreditoUsado.ParamByName('pDistribuidor').AsInteger := cboDistribuidor.KeyValue;
  DM.qryConsultaCreditoUsado.Open;

  lLimiteCreditoUsado := DM.qryConsultaCreditoUsado.FieldByName('valor').AsFloat + StrToFloat(edtTotal.Text);

  if lLimiteCreditoUsado > lLimiteCreditoTotal then
    Result := False
  else
    Result := True;
end;

procedure TfrmNegociacaoCadastro.spdAdicionarTodosProdutosClick(Sender: TObject);
var
  lProduto: String;
  lTotal: Double;
begin
  //Se não tem mais produto para selecionar não segue adiante
  if DM.qryConsultaProduto.IsEmpty then
    Abort;

  DM.qryConsultaProduto.DisableControls;
  cdsProdutosNegociados.DisableControls;
  DM.qryConsultaProduto.First;
  lTotal := 0;

  while not DM.qryConsultaProduto.Eof do
  begin
    if lProduto = '' then
      lProduto := DM.qryConsultaProduto.FieldByName('codigo').AsString
    else
      lProduto := lProduto + ',' + DM.qryConsultaProduto.FieldByName('codigo').AsString;

    lTotal := lTotal + ObterValorDoProduto(DM.qryConsultaProduto.FieldByName('codigo').AsInteger);

    cdsProdutosNegociados.AppendRecord([DM.qryConsultaProduto.FieldByName('codigo').AsString,
                                        DM.qryConsultaProduto.FieldByName('nome').AsString,
                                        DM.qryNegociacao.FieldByName('codigo').AsString]);

    DM.qryConsultaProduto.Next;
  end;

  cdsProdutosNegociados.First;

  DM.qryConsultaProduto.EnableControls;
  cdsProdutosNegociados.EnableControls;

  edtTotal.Text := FormatFloat('0.00', lTotal);

  DM.qryConsultaProduto.Close;
end;

end.
