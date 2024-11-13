unit uFrmCadProdutor;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Mask,
  System.UITypes,
  uBiblioteca,
  uEnumerado,
  uProdutorController,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Datasnap.DBClient,
  uLimiteCreditoController,
  uLimiteCreditoModel,
  System.Generics.Collections,
  System.Classes, uFrmCadBasico;


type
  TFrmCadProdutor = class(TFrmCadBasico)
    lblId: TLabel;
    edtId: TEdit;
    lblName: TLabel;
    edtNome: TEdit;
    rdgInformeCpfCnpj: TRadioGroup;
    edtCPFCNPJ: TMaskEdit;
    pgcBottom: TPageControl;
    tbBottom: TTabSheet;
    dbgLimiteCredito: TDBGrid;
    Panel2: TPanel;
    spbInserirLimiteCredito: TSpeedButton;
    spbRemoverLimiteCredito: TSpeedButton;
    Panel1: TPanel;
    lblTotalLimite: TLabel;
    edtTotalLimiteCredito: TEdit;
    cdsLimiteCredito: TClientDataSet;
    cdsLimiteCreditoLIMITE_CREDITO_ID: TIntegerField;
    cdsLimiteCreditoPRODUTOR_ID: TIntegerField;
    cdsLimiteCreditoDISTRIBUIDOR_ID: TIntegerField;
    cdsLimiteCreditoLIMITE_CREDITO: TCurrencyField;
    cdsLimiteCreditoPRODUTOR: TStringField;
    cdsLimiteCreditoDISTRIBUIDOR: TStringField;
    dsLimiteCredito: TDataSource;
    procedure spbInserirLimiteCreditoClick(Sender: TObject);
    procedure spbRemoverLimiteCreditoClick(Sender: TObject);
    procedure rdgInformeCpfCnpjClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FProdutorController : TProdutorController;
    FLimiteCredito      : Currency;
    ModeAction: TAction;

    procedure InserirLimiteCredito;
    procedure ExcluirLimiteCredito;
    procedure SomaLimiteCredito;
    procedure CarregarLimiteCredito;
    procedure GravarLimitesCredito;
    procedure LimparCampos;

    function ValidarCampos: Boolean;
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
  FrmCadProdutor: TFrmCadProdutor;

implementation

{$R *.dfm}

uses
  uFrmPesquisaProdutor,
  uFrmLimiteCredito;

procedure TFrmCadProdutor.Alterar;
begin
  if Trim(edtId.Text) = '' then
  begin
    ShowMessage('Nenhum produto selecionado para alteração!');
    Exit;
  end;

  ModeAction := tacChange;
  Modo(statusInclude);
  edtNome.SetFocus;
end;

procedure TFrmCadProdutor.Cancelar;
begin
  Modo(statusInitial);
  LimparCampos;
end;

procedure TFrmCadProdutor.CarregarLimiteCredito;
var
  vLimitesCredito          : TList<TLimiteCreditoModel>;
  vLimiteCredito           : TLimiteCreditoModel;
  vLimiteCreditoController : TLimiteCreditoController;
begin
  cdsLimiteCredito.EmptyDataSet;

  vLimiteCreditoController := TLimiteCreditoController.Create;
  try
    vLimitesCredito := vLimiteCreditoController.ObterLimitesCredito(StrToInt(edtId.Text));
    try
      for vLimiteCredito in vLimitesCredito do
      begin
        cdsLimiteCredito.Insert;
        cdsLimiteCredito.FieldByName('LIMITE_CREDITO_ID').AsInteger := vLimiteCredito.LimiteCreditoId;
        cdsLimiteCredito.FieldByName('PRODUTOR_ID').AsInteger       := vLimiteCredito.ProdutorId;
        cdsLimiteCredito.FieldByName('DISTRIBUIDOR_ID').AsInteger   := vLimiteCredito.DistribuidorId;
        cdsLimiteCredito.FieldByName('DISTRIBUIDOR').AsString       := vLimiteCredito.Distribuidor;
        cdsLimiteCredito.FieldByName('LIMITE_CREDITO').AsCurrency   := vLimiteCredito.LimiteCredito;
        cdsLimiteCredito.Post;
      end;
      SomaLimiteCredito;
    finally
      vLimitesCredito.Free;
    end;
  finally
    vLimiteCreditoController.Free;
  end;
end;

procedure TFrmCadProdutor.Excluir;
begin
  if Trim(edtId.Text) = '' then
  begin
    ShowMessage('Nenhum produtor selecionado para exclusão!');
    Exit;
  end;

  // Validar se existe negociações com os dados do produtor e distribuidor!
  // Falta Desenvolver!

  if MessageDlg('Tem certeza que deseja excluir este produtor?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ModeAction := tacDelete;

    // Excluir os itens
    GravarLimitesCredito;

    FProdutorController.ProdutorModel.Action := tacDelete;
    FProdutorController.ProdutorModel.Id     := StrToInt(edtId.Text);

    if FProdutorController.Salvar then
    begin
      ShowMessage('Produtor excluído com sucesso!');
      LimparCampos;
      Modo(statusInitial);
    end
    else
    begin
      ShowMessage('Erro ao excluir o produtor!');
    end;
  end;
end;

procedure TFrmCadProdutor.ExcluirLimiteCredito;
begin
  if cdsLimiteCredito.IsEmpty then
  begin
    ShowMessage('Nenhum limite de crédito selecionado para exclusão!');
    Exit;
  end;

  if MessageDlg('Tem certeza que deseja excluir o limite de crédito selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    cdsLimiteCredito.Delete;
    SomaLimiteCredito;
    ShowMessage('Limite de crédito excluído com sucesso!');
  end;
end;

procedure TFrmCadProdutor.FormCreate(Sender: TObject);
begin
  FProdutorController := TProdutorController.Create;
  Modo(statusInitial);
end;

procedure TFrmCadProdutor.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(FProdutorController) then
      FreeAndNil(FProdutorController);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFrmCadProdutor.Gravar;
begin
  if not ValidarCampos then
    Exit;

  try
    if ModeAction = tacInclude then
      FProdutorController.ProdutorModel.Action := uEnumerado.tacInclude
    else if ModeAction = tacChange then
      FProdutorController.ProdutorModel.Action := uEnumerado.tacChange
    else if ModeAction = tacDelete then
      FProdutorController.ProdutorModel.Action := uEnumerado.tacDelete;

    FProdutorController.ProdutorModel.Nome          := edtNome.Text;
    FProdutorController.ProdutorModel.CpfCnpj       := Trim(edtCPFCNPJ.Text);
    FProdutorController.ProdutorModel.Id            := StrToInt(edtId.Text);

    if FLimiteCredito > 0 then
      FProdutorController.ProdutorModel.LimiteCredito := FLimiteCredito;

    if not FProdutorController.Salvar() then
    begin
      ShowMessage('Erro ao salvar o produtor!');
      Exit;
    end;

    GravarLimitesCredito;

    ShowMessage('Registro salvo com sucesso!');
    LimparCampos;
    Modo(statusInitial);
  except
    on E: Exception do
    begin
      ShowMessage('Erro: ' + E.Message);
    end;
  end;
end;

procedure TFrmCadProdutor.GravarLimitesCredito;
var
  vLimiteCreditoController : TLimiteCreditoController;
  vNovoLimite              : TLimiteCreditoModel;
begin
  vLimiteCreditoController := TLimiteCreditoController.Create;
  cdsLimiteCredito.DisableControls;
  try
    cdsLimiteCredito.First;
    while not cdsLimiteCredito.Eof do
    begin
      vNovoLimite := TLimiteCreditoModel.Create;
      try
        if ModeAction = tacInclude then
          vNovoLimite.Action := uEnumerado.tacInclude
        else if ModeAction = tacChange then
          vNovoLimite.Action := uEnumerado.tacChange
        else if ModeAction = tacDelete then
          vNovoLimite.Action := uEnumerado.tacDelete;

        if cdsLimiteCredito.FieldByName('limite_credito_id').AsInteger > 0 then
          vNovoLimite.LimiteCreditoId := cdsLimiteCredito.FieldByName('limite_credito_id').AsInteger
        else
          vNovoLimite.LimiteCreditoId := vLimiteCreditoController.LimiteCreditoModel.GetId(1);

        vNovoLimite.ProdutorId     := cdsLimiteCredito.FieldByName('produtor_id').AsInteger;
        vNovoLimite.DistribuidorId := cdsLimiteCredito.FieldByName('distribuidor_id').AsInteger;
        vNovoLimite.LimiteCredito  := cdsLimiteCredito.FieldByName('limite_credito').AsCurrency;

        vLimiteCreditoController.LimiteCreditoModel := vNovoLimite;

        if not vLimiteCreditoController.Salvar then
          raise Exception.CreateFmt('Erro ao salvar limite de crédito do distribuidor ID %d', [vNovoLimite.DistribuidorId]);
      finally
        vLimiteCreditoController.LimiteCreditoModel := nil;
        FreeAndNil(vNovoLimite);
      end;

      cdsLimiteCredito.Next;
    end;
  finally
    if Assigned(vLimiteCreditoController) then
      vLimiteCreditoController.Free;

    cdsLimiteCredito.EnableControls;
  end;
end;

procedure TFrmCadProdutor.Inserir;
begin
  try
    FProdutorController.ProdutorModel.Id := FProdutorController.ProdutorModel.GetId(1);
    edtId.Text                           := FProdutorController.ProdutorModel.Id.ToString();

    ModeAction := tacInclude;
    Modo(statusInclude);
    edtNome.SetFocus;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFrmCadProdutor.InserirLimiteCredito;
begin
  Application.CreateForm(TFrmLimiteCredito, frmLimiteCredito);
  try
    frmLimiteCredito.ShowModal;

    if frmLimiteCredito.ModalResult = mrOk then
    begin
      if cdsLimiteCredito.Locate('DISTRIBUIDOR_ID', frmLimiteCredito.DistribuidorId, []) then
        raise Exception.Create('Distribuidor já possui limite de crédito associado.');

      cdsLimiteCredito.Append;
      cdsLimiteCredito.FieldByName('PRODUTOR_ID').AsInteger       := StrToInt(edtId.Text);
      cdsLimiteCredito.FieldByName('DISTRIBUIDOR_ID').AsInteger   := frmLimiteCredito.DistribuidorId;
      cdsLimiteCredito.FieldByName('DISTRIBUIDOR').AsString       := frmLimiteCredito.Distribuidor;
      cdsLimiteCredito.FieldByName('LIMITE_CREDITO').AsCurrency   := frmLimiteCredito.LimiteCredito;
      cdsLimiteCredito.Post;

      SomaLimiteCredito;
    end;
  finally
    frmLimiteCredito.Free;
  end;
end;

procedure TFrmCadProdutor.LimparCampos;
begin
  edtId.Clear;
  edtNome.Clear;
  rdgInformeCpfCnpj.ItemIndex := 0;
  edtCPFCNPJ.Clear;
  edtTotalLimiteCredito.Clear;
  cdsLimiteCredito.EmptyDataSet;
end;

procedure TFrmCadProdutor.Modo(pModo: TControlButtons);
begin
  inherited;
  if pModo = uEnumerado.statusInitial then
  begin
    cdsLimiteCredito.EmptyDataSet;
    spbRemoverLimiteCredito.Enabled := not cdsLimiteCredito.IsEmpty;
  end
  else
  if pModo = uEnumerado.statusInclude then
  begin
    spbRemoverLimiteCredito.Enabled := not cdsLimiteCredito.IsEmpty;
  end
  else
  if pModo = uEnumerado.statusSearch then
  begin
    spbRemoverLimiteCredito.Enabled := not cdsLimiteCredito.IsEmpty;
  end;
end;

procedure TFrmCadProdutor.Pesquisar;
begin
  Application.CreateForm(TfrmPesquisaProdutor, FrmPesquisaProdutor);
  Modo(statusSearch);
  try
    FrmPesquisaProdutor.ShowModal;

    if FrmPesquisaProdutor.ModalResult = mrCancel then
    begin
      Modo(statusInitial);
      LimparCampos;
      Exit;
    end
    else if FrmPesquisaProdutor.ModalResult = mrOk then
    begin
      edtId.Text               := IntToStr(FrmPesquisaProdutor.qryPesquisaProdutorPRODUTOR_ID.AsInteger);
      edtNome.Text             := FrmPesquisaProdutor.qryPesquisaProdutorNOME.AsString;

      edtCPFCNPJ.Text          := FrmPesquisaProdutor.qryPesquisaProdutorCPF_CNPJ.AsString;
      rdgInformeCpfCnpj.ItemIndex := 0;
      if Length(Trim(FrmPesquisaProdutor.qryPesquisaProdutorCPF_CNPJ.AsString)) > 11 then
        rdgInformeCpfCnpj.ItemIndex := 1;

      CarregarLimiteCredito;

      ModeAction := tacChange;
    end;

  finally
    FreeAndNil(FrmPesquisaProdutor);
  end;
end;

procedure TFrmCadProdutor.rdgInformeCpfCnpjClick(Sender: TObject);
begin
  edtCPFCNPJ.EditMask := uBiblioteca.SetEditMask(rdgInformeCpfCnpj.ItemIndex);
end;

procedure TFrmCadProdutor.SomaLimiteCredito;
begin
  FLimiteCredito := 0;

  if cdsLimiteCredito.Active then
  begin
    cdsLimiteCredito.DisableControls;
    try

      cdsLimiteCredito.First;
      while not cdsLimiteCredito.Eof do
      begin
        FLimiteCredito := FLimiteCredito + cdsLimiteCredito.FieldByName('LIMITE_CREDITO').AsCurrency;
        cdsLimiteCredito.Next;
      end;
    finally
      cdsLimiteCredito.EnableControls;
    end;
  end;

  edtTotalLimiteCredito.Text := FormatCurr('R$ #,##0.00', FLimiteCredito);
end;

procedure TFrmCadProdutor.spbInserirLimiteCreditoClick(Sender: TObject);
begin
  InserirLimiteCredito;
end;

procedure TFrmCadProdutor.spbRemoverLimiteCreditoClick(Sender: TObject);
begin
  ExcluirLimiteCredito;
end;

function TFrmCadProdutor.ValidarCampos: Boolean;
var
  vCPFCNPJ : string;
begin
  Result := False;

  if Length(edtId.Text) = 0 then
  begin
    ShowMessage('Não existe registro para ser salvo!');
    Exit;
  end;

  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('O campo "Nome" é obrigatório.');
    edtNome.SetFocus;
    Exit;
  end;

  vCPFCNPJ := Trim(edtCPFCNPJ.Text);

  if vCPFCNPJ = '' then
  begin
    ShowMessage('O campo "CPF/CNPJ" é obrigatório.');
    edtCPFCNPJ.SetFocus;
    Exit;
  end;

  case rdgInformeCpfCnpj.ItemIndex of
    0:
      begin
        if not uBiblioteca.ValidaCPF(vCPFCNPJ) then
        begin
          ShowMessage('O campo "CPF" é Inválido.');
          edtCPFCNPJ.SetFocus;
          Exit;
        end;
      end;
    1:
      begin
        if not uBiblioteca.ValidaCNPJ(vCPFCNPJ) then
        begin
          ShowMessage('O campo "CNPJ" é Inválido.');
          edtCPFCNPJ.SetFocus;
          Exit;
        end;
      end;
  end;

  // Verificar se o CPF ou CNPJ consta cadastrado! - Não permitir CPF ou CNPJ repetido!
  // Falta Desenvolver!


  Result := True;
end;

end.
