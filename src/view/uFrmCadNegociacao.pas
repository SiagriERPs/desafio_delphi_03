unit uFrmCadNegociacao;

interface

uses
  uFrmCadBasico,
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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  uEnumerado,
  uNegociacaoController,
  uNegociacaoItemController,
  uNegociacaoItemModel,
  System.UITypes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Datasnap.DBClient,
  System.Generics.Collections,
  uStatusController;

type
  TProduto = record
    Id: Integer;
    Nome: string;
  end;

  TProdutor = record
    Id: Integer;
    Nome: string;
    LimiteCredito: Currency;
  end;

  TDistribuidor = record
    Id: Integer;
    Nome: string;
  end;

  TFrmCadNegociacao = class(TFrmCadBasico)
    spbManutencao: TSpeedButton;
    lblId: TLabel;
    edtId: TEdit;
    Label3: TLabel;
    lblProdutor: TLabel;
    edtProdutor: TEdit;
    lblDistribuidor: TLabel;
    edtDistribuidor: TEdit;
    spbPesquisaDistribuidor: TSpeedButton;
    spbPesquisaProdutor: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    lblTotalNegociacao: TLabel;
    edtTotalNegociacao: TEdit;
    Panel2: TPanel;
    spbInserirItem: TSpeedButton;
    spbExcluirItem: TSpeedButton;
    spbAlterarItem: TSpeedButton;
    lblTitulo: TLabel;
    dsItensNegociacao: TDataSource;
    cdsItensNegociacao: TClientDataSet;
    cdsItensNegociacaoITEM_NEGOCIACAO_ID: TIntegerField;
    cdsItensNegociacaoNEGOCIACAO_ID: TIntegerField;
    cdsItensNegociacaoPRODUTO_ID: TIntegerField;
    cdsItensNegociacaoPRODUTO: TStringField;
    cdsItensNegociacaoQUANTIDADE: TIntegerField;
    cdsItensNegociacaoPRECO: TCurrencyField;
    cdsItensNegociacaoVLR_TOTAL: TCurrencyField;
    edtStatus: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spbPesquisaProdutorClick(Sender: TObject);
    procedure spbPesquisaDistribuidorClick(Sender: TObject);
    procedure spbInserirItemClick(Sender: TObject);
    procedure spbAlterarItemClick(Sender: TObject);
    procedure spbExcluirItemClick(Sender: TObject);
    procedure spbManutencaoClick(Sender: TObject);
  private
    FNegociacaoController     : TNegociacaoController;
    FNegociacaoItemController : TNegociacaoItemController;
    FProdutor                 : TProdutor;
    FDistribuidor             : TDistribuidor;
    FVlrTotalNegociacao       : Currency;
    ModeAction: TAction;

    procedure LimparCampos;
    procedure InserirItens;
    procedure AlterarItens;
    procedure ExcluirItens;
    procedure PesquisarProdutor;
    procedure PesquisarDistribuidor;
    procedure SomaTotalNegociacao;
    procedure CarregarItensNegociacao;
    procedure GravarItensNegociacao;
    procedure ManutencaoNegociacao;
    procedure CarregarStatusNegociacao(pNegociacaoId: Integer);

    function ValidarCampos: Boolean;
    function ExisteCreditoDisponivel: Boolean;
  public
  protected
    procedure Inserir; override;
    procedure Alterar; override;
    procedure Excluir; override;
    procedure Cancelar; override;
    procedure Pesquisar; override;
    procedure Gravar; override;
    procedure Modo(pModo: TControlButtons); override;
  end;

var
  FrmCadNegociacao: TFrmCadNegociacao;

implementation

{$R *.dfm}

uses
  uFrmPesquisaNegociacao,
  uFrmPesquisaDistribuidor,
  uFrmPesquisaProdutor,
  uFrmPesquisaProdutoNegociacao,
  uFrmManutencaoNegociacao;

const
  cPendente = 'Pendente';

procedure TFrmCadNegociacao.Alterar;
begin
  if Trim(edtId.Text) = '' then
  begin
    ShowMessage('Nenhuma negociação selecionada para alteração!');
    Exit;
  end;

  ModeAction := tacChange;
  Modo(statusInclude);
  edtProdutor.SetFocus;
end;

procedure TFrmCadNegociacao.AlterarItens;
begin
  // Falta Desenvolver!
end;

procedure TFrmCadNegociacao.Cancelar;
begin
  Modo(statusInitial);
  LimparCampos;
end;

procedure TFrmCadNegociacao.CarregarItensNegociacao;
var
  vNegociacaoItens         : TList<TNegociacaoItemModel>;
  vNegociacaoItem          : TNegociacaoItemModel;
  vNegocicaoItemController : TNegociacaoItemController;
begin
  cdsItensNegociacao.EmptyDataSet;

  vNegocicaoItemController := TNegociacaoItemController.Create;
  try
    vNegociacaoItens := vNegocicaoItemController.ObterItensNegociacao(StrToInt(edtId.Text));
    try
      for vNegociacaoItem in vNegociacaoItens do
      begin
        cdsItensNegociacao.Insert;
        cdsItensNegociacao.FieldByName('ITEM_NEGOCIACAO_ID').AsInteger := vNegociacaoItem.Id;
        cdsItensNegociacao.FieldByName('NEGOCIACAO_ID').AsInteger      := vNegociacaoItem.NegociacaoId;
        cdsItensNegociacao.FieldByName('PRODUTO_ID').AsInteger         := vNegociacaoItem.ProdutoId;
        cdsItensNegociacao.FieldByName('PRODUTO').AsString             := vNegociacaoItem.Produto;
        cdsItensNegociacao.FieldByName('QUANTIDADE').AsInteger         := vNegociacaoItem.Quantidade;
        cdsItensNegociacao.FieldByName('PRECO').AsCurrency             := vNegociacaoItem.Preco;

        cdsItensNegociacao.Post;
      end;
      SomaTotalNegociacao;
    finally
      vNegociacaoItens.Free;
    end;
  finally
    vNegocicaoItemController.Free;
  end;
end;

procedure TFrmCadNegociacao.CarregarStatusNegociacao(pNegociacaoId: Integer);
var
  vStatusController : TStatusController;
begin
  vStatusController := TStatusController.Create;
  try
    edtStatus.Text := vStatusController.ObterStatusNegociacao(pNegociacaoId);
  finally
    FreeAndNil(vStatusController);
  end;
end;

procedure TFrmCadNegociacao.Excluir;
begin
  if Trim(edtId.Text) = '' then
  begin
    ShowMessage('Nenhuma negociação selecionada para exclusão!');
    Exit;
  end;

  // Permitir Excluir apenas se o status for pendente!
  // Falta Desenvolver!

  if MessageDlg('Tem certeza que deseja excluir esta negociação?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ModeAction := tacDelete;

    // Excluir os itens
    GravarItensNegociacao;

    FNegociacaoController.NegociacaoModel.Action := tacDelete;
    FNegociacaoController.NegociacaoModel.Id     := StrToInt(edtId.Text);

    if FNegociacaoController.Salvar then
    begin
      ShowMessage('negociação excluída com sucesso!');
      LimparCampos;
      Modo(statusInitial);
    end
    else
    begin
      ShowMessage('Erro ao excluir a negociação!');
    end;
  end;
end;

procedure TFrmCadNegociacao.ExcluirItens;
begin
  if cdsItensNegociacao.IsEmpty then
  begin
    ShowMessage('Nenhum item de negociação selecionado para exclusão!');
    Exit;
  end;

  if MessageDlg('Tem certeza que deseja excluir o item da negociação selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    cdsItensNegociacao.Delete;
    SomaTotalNegociacao;
    ShowMessage('item da negociação excluído com sucesso!');
  end;
end;

function TFrmCadNegociacao.ExisteCreditoDisponivel: Boolean;
begin
  Result := True;
  // Validar Crédito disponivel do produtor para o distribuidor selecionado.
  // Falta Desenvolver!
end;

procedure TFrmCadNegociacao.FormCreate(Sender: TObject);
begin
  FNegociacaoController     := TNegociacaoController.Create;
  FNegociacaoItemController := TNegociacaoItemController.Create;
  Modo(statusInitial);
end;

procedure TFrmCadNegociacao.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(FNegociacaoController) then
      FreeAndNil(FNegociacaoController);

    if Assigned(FNegociacaoItemController) then
      FreeAndNil(FNegociacaoItemController);

    cdsItensNegociacao.Close;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFrmCadNegociacao.Gravar;
begin
  if not ValidarCampos then
    Exit;

  if ModeAction = tacInclude then
    FNegociacaoController.NegociacaoModel.Action := uEnumerado.tacInclude
  else if ModeAction = tacChange then
    FNegociacaoController.NegociacaoModel.Action := uEnumerado.tacChange
  else if ModeAction = tacDelete then
    FNegociacaoController.NegociacaoModel.Action := uEnumerado.tacDelete;

  if ModeAction = tacInclude then
    FNegociacaoController.NegociacaoModel.Status        := cPendente
  else
    FNegociacaoController.NegociacaoModel.Status        := edtStatus.Text;

  FNegociacaoController.NegociacaoModel.Id              := StrToInt(edtId.Text);
  FNegociacaoController.NegociacaoModel.ProdutorId      := FProdutor.Id;
  FNegociacaoController.NegociacaoModel.DistribuidorId  := FDistribuidor.Id;
  FNegociacaoController.NegociacaoModel.DataCadastro    := Date;

  if FVlrTotalNegociacao > 0 then
    FNegociacaoController.NegociacaoModel.ValorTotal    := FVlrTotalNegociacao
  else
    FNegociacaoController.NegociacaoModel.ValorTotal    := 0;

  if FNegociacaoController.Salvar() then
  begin
    GravarItensNegociacao;
    LimparCampos;
    Modo(statusInitial);
    ShowMessage('Registro salvo com sucesso!');
  end;
end;

procedure TFrmCadNegociacao.GravarItensNegociacao;
var
  vNegociacaoItemController : TNegociacaoItemController;
  vNovoItem                 : TNegociacaoItemModel;
begin
  vNegociacaoItemController := TNegociacaoItemController.Create;
  try
    cdsItensNegociacao.First;
    while not cdsItensNegociacao.Eof do
    begin
      vNovoItem := TNegociacaoItemModel.Create;
      try
        if ModeAction = tacInclude then
          vNovoItem.Action := uEnumerado.tacInclude
        else if ModeAction = tacChange then
          vNovoItem.Action := uEnumerado.tacChange
        else if ModeAction = tacDelete then
          vNovoItem.Action := uEnumerado.tacDelete;

        if cdsItensNegociacao.FieldByName('item_negociacao_id').AsInteger > 0 then
          vNovoItem.Id := cdsItensNegociacao.FieldByName('item_negociacao_id').AsInteger
        else
          vNovoItem.Id := vNegociacaoItemController.NegociacaoItemModel.GetId(1);

        if cdsItensNegociacao.FieldByName('negociacao_id').AsInteger > 0 then
          vNovoItem.NegociacaoId := cdsItensNegociacao.FieldByName('negociacao_id').AsInteger
        else
          vNovoItem.NegociacaoId := StrToInt(edtId.Text);

        vNovoItem.ProdutoId    := cdsItensNegociacao.FieldByName('produto_id').AsInteger;
        vNovoItem.Produto      := cdsItensNegociacao.FieldByName('produto').AsString;
        vNovoItem.Quantidade   := cdsItensNegociacao.FieldByName('quantidade').AsInteger;
        vNovoItem.Preco        := cdsItensNegociacao.FieldByName('preco').AsCurrency;

        vNegociacaoItemController.NegociacaoItemModel := vNovoItem;

        if not vNegociacaoItemController.Salvar then
          raise Exception.CreateFmt('Erro ao salvar item da negociação do código do contrato: %d', [vNovoItem.NegociacaoId]);
      finally
        vNovoItem.Free;
      end;
      cdsItensNegociacao.Next;
    end;
  finally
    vNegociacaoItemController.Free;
  end;
end;

procedure TFrmCadNegociacao.Inserir;
begin
  try
    FNegociacaoController.NegociacaoModel.Id := FNegociacaoController.NegociacaoModel.GetId(1);
    edtId.Text := FNegociacaoController.NegociacaoModel.Id.ToString();
    edtStatus.Text := cPendente;

    ModeAction := tacInclude;
    Modo(statusInclude);
    edtProdutor.SetFocus;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFrmCadNegociacao.InserirItens;
begin
  Application.CreateForm(TFrmPesquisaProdutoNegociacao, frmPesquisaProdutoNegociacao);
  try
    frmPesquisaProdutoNegociacao.ShowModal;

    if frmPesquisaProdutoNegociacao.ModalResult = mrOk then
    begin
      if cdsItensNegociacao.Locate('PRODUTO_ID', frmPesquisaProdutoNegociacao.ProdutoId, []) then
        raise Exception.Create('Produto já está associado a negociação.');

      if ExisteCreditoDisponivel then
      begin
        cdsItensNegociacao.Append;
        cdsItensNegociacao.FieldByName('PRODUTO_ID').AsInteger   := frmPesquisaProdutoNegociacao.ProdutoId;
        cdsItensNegociacao.FieldByName('PRODUTO').AsString       := frmPesquisaProdutoNegociacao.Produto;
        cdsItensNegociacao.FieldByName('QUANTIDADE').AsInteger   := frmPesquisaProdutoNegociacao.Quantidade;
        cdsItensNegociacao.FieldByName('PRECO').AsCurrency       := frmPesquisaProdutoNegociacao.Preco;
        cdsItensNegociacao.FieldByName('VLR_TOTAL').AsCurrency   := frmPesquisaProdutoNegociacao.VlrTotal;
        cdsItensNegociacao.Post;

        SomaTotalNegociacao;
      end
      else
      begin
        ShowMessage('Não existe limite de crédito disponivel!');
        Exit;
      end;
    end;
  finally
    frmPesquisaProdutoNegociacao.Free;
  end;
end;

procedure TFrmCadNegociacao.LimparCampos;
begin
  edtId.Clear;
  edtProdutor.Clear;
  edtDistribuidor.Clear;
  edtTotalNegociacao.Clear;
  edtStatus.Clear;
  cdsItensNegociacao.EmptyDataSet;
end;

procedure TFrmCadNegociacao.ManutencaoNegociacao;
begin
  Application.CreateForm(TfrmManutencaoNegociacao, FrmManutencaoNegociacao);
  Modo(statusSearch);
  try
    FrmManutencaoNegociacao.ShowModal;

    Modo(statusInitial);
    LimparCampos;
    Exit;

  finally
    FreeAndNil(FrmManutencaoNegociacao);
  end;
end;

procedure TFrmCadNegociacao.Modo(pModo: TControlButtons);
begin
  inherited;
  if pModo = uEnumerado.statusInitial then
  begin
    cdsItensNegociacao.EmptyDataSet;
    spbManutencao.Enabled := True;
  end
  else
  if pModo = uEnumerado.statusInclude then
  begin
    spbManutencao.Enabled := False;
  end
  else
  if pModo = uEnumerado.statusSearch then
  begin
    spbManutencao.Enabled := False;
  end;

end;

procedure TFrmCadNegociacao.Pesquisar;
begin
  Application.CreateForm(TfrmPesquisaNegociacao, FrmPesquisaNegociacao);
  Modo(statusSearch);
  try
    FrmPesquisaNegociacao.ShowModal;

    if FrmPesquisaNegociacao.ModalResult = mrCancel then
    begin
      Modo(statusInitial);
      LimparCampos;
      Exit;
    end
    else if FrmPesquisaNegociacao.ModalResult = mrOk then
    begin
      edtId.Text           := IntToStr(FrmPesquisaNegociacao.qryPesquisaNegociacaoNEGOCIACAO_ID.AsInteger);
      edtProdutor.Text     := FrmPesquisaNegociacao.qryPesquisaNegociacaoPRODUTOR_ID.AsString + ' - ' +
                              FrmPesquisaNegociacao.qryPesquisaNegociacaoPRODUTOR.AsString;

      edtDistribuidor.Text := FrmPesquisaNegociacao.qryPesquisaNegociacaoDISTRIBUIDOR_ID.AsString + ' - ' +
                              FrmPesquisaNegociacao.qryPesquisaNegociacaoDISTRIBUIDOR.AsString;

      edtTotalNegociacao.Text := CurrToStr(FrmPesquisaNegociacao.qryPesquisaNegociacaoVALOR_TOTAL.AsCurrency);

      CarregarStatusNegociacao(FrmPesquisaNegociacao.qryPesquisaNegociacaoNEGOCIACAO_ID.AsInteger);
      CarregarItensNegociacao;

      ModeAction := tacChange;
    end;

  finally
    FreeAndNil(FrmPesquisaNegociacao);
  end;
end;

procedure TFrmCadNegociacao.PesquisarDistribuidor;
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
      FDistribuidor.Id      := FrmPesquisaDistribuidor.qryPesquisaDistribuidorDISTRIBUIDOR_ID.AsInteger;
      FDistribuidor.Nome    := FrmPesquisaDistribuidor.qryPesquisaDistribuidorNOME.AsString;
      edtDistribuidor.Text := IntToStr(FDistribuidor.Id) + ' - ' + FDistribuidor.Nome;
    end;
  finally
    FreeAndNil(FrmPesquisaDistribuidor);
  end;
end;

procedure TFrmCadNegociacao.PesquisarProdutor;
begin
  Application.CreateForm(TfrmPesquisaProdutor, FrmPesquisaProdutor);
  try
    FrmPesquisaProdutor.ShowModal;

    if FrmPesquisaProdutor.ModalResult = mrCancel then
    begin
      edtProdutor.Clear;
      Exit;
    end
    else if FrmPesquisaProdutor.ModalResult = mrOk then
    begin
      FProdutor.LimiteCredito := FrmPesquisaProdutor.qryPesquisaProdutorLIMITE_CREDITO.AsCurrency;

      if FProdutor.LimiteCredito = 0 then
      begin
        ShowMessage('Para continuar, Informe o limite de crédito!');
        Exit;
      end;

      FProdutor.Id     := FrmPesquisaProdutor.qryPesquisaProdutorPRODUTOR_ID.AsInteger;
      FProdutor.Nome   := FrmPesquisaProdutor.qryPesquisaProdutorNOME.AsString;
      edtProdutor.Text := IntToStr(FProdutor.Id) + ' - ' + FProdutor.Nome;
    end;
  finally
    FreeAndNil(FrmPesquisaProdutor);
  end;
end;

procedure TFrmCadNegociacao.SomaTotalNegociacao;
begin
  FVlrTotalNegociacao := 0;

  if cdsItensNegociacao.Active then
  begin
    cdsItensNegociacao.DisableControls;
    try
      cdsItensNegociacao.First;
      while not cdsItensNegociacao.Eof do
      begin
        FVlrTotalNegociacao := FVlrTotalNegociacao + cdsItensNegociacao.FieldByName('VLR_TOTAL').AsCurrency;
        cdsItensNegociacao.Next;
      end;
    finally
      cdsItensNegociacao.EnableControls;
    end;
  end;

  edtTotalNegociacao.Text := FormatCurr('R$ #,##0.00', FVlrTotalNegociacao);
end;

procedure TFrmCadNegociacao.spbAlterarItemClick(Sender: TObject);
begin
  AlterarItens;
end;

procedure TFrmCadNegociacao.spbExcluirItemClick(Sender: TObject);
begin
  ExcluirItens;
end;

procedure TFrmCadNegociacao.spbInserirItemClick(Sender: TObject);
begin
  InserirItens;
end;

procedure TFrmCadNegociacao.spbManutencaoClick(Sender: TObject);
begin
  ManutencaoNegociacao;
end;

procedure TFrmCadNegociacao.spbPesquisaDistribuidorClick(Sender: TObject);
begin
  PesquisarDistribuidor;
end;

procedure TFrmCadNegociacao.spbPesquisaProdutorClick(Sender: TObject);
begin
  PesquisarProdutor;
end;

function TFrmCadNegociacao.ValidarCampos: Boolean;
begin
  Result := False;

  if Length(edtId.Text) = 0 then
  begin
    ShowMessage('Não existe registro para ser salvo!');
    Exit;
  end;

  if Trim(edtProdutor.Text) = '' then
  begin
    ShowMessage('O campo "Produtor" é obrigatório.');
    edtProdutor.SetFocus;
    Exit;
  end;

  if Trim(edtDistribuidor.Text) = '' then
  begin
    ShowMessage('O campo "Distribuidor" é obrigatório.');
    edtDistribuidor.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
