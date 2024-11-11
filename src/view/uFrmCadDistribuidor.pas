unit uFrmCadDistribuidor;

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
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Mask,
  System.UITypes,
  uEnumerado,
  uDistribuidorController;

type
  TFrmCadDistribuidor = class(TFrmCadBasico)
    lblId: TLabel;
    edtId: TEdit;
    lblName: TLabel;
    edtNome: TEdit;
    lblPrice: TLabel;
    edtCNPJ: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDistribuidorController: TDistribuidorController;
    ModeAction: TAction;

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
  FrmCadDistribuidor: TFrmCadDistribuidor;

implementation

{$R *.dfm}

uses
  uBiblioteca,
  uFrmPesquisaDistribuidor;

procedure TFrmCadDistribuidor.Alterar;
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

procedure TFrmCadDistribuidor.Cancelar;
begin
  Modo(statusInitial);
  LimparCampos;
end;

procedure TFrmCadDistribuidor.Excluir;
begin
  if Trim(edtId.Text) = '' then
  begin
    ShowMessage('Nenhum distribuidor selecionado para exclusão!');
    Exit;
  end;

  if MessageDlg('Tem certeza que deseja excluir este distribuidor?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ModeAction := tacDelete;
    FDistribuidorController.DistribuidorModel.Action := tacDelete;

    FDistribuidorController.DistribuidorModel.Id := StrToInt(edtId.Text);

    if FDistribuidorController.Salvar then
    begin
      ShowMessage('Distribuidor excluído com sucesso!');
      LimparCampos;
      Modo(statusInitial);
    end
    else
    begin
      ShowMessage('Erro ao excluir o distribuidor!');
    end;
  end;
end;

procedure TFrmCadDistribuidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Close;
end;

procedure TFrmCadDistribuidor.FormCreate(Sender: TObject);
begin
  FDistribuidorController := TDistribuidorController.Create;
  Modo(statusInitial);
end;

procedure TFrmCadDistribuidor.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(FDistribuidorController) then
      FreeAndNil(FDistribuidorController);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFrmCadDistribuidor.Gravar;
begin
  if not ValidarCampos then
    Exit;

  if ModeAction = tacInclude then
    FDistribuidorController.DistribuidorModel.Action := uEnumerado.tacInclude
  else if ModeAction = tacChange then
    FDistribuidorController.DistribuidorModel.Action := uEnumerado.tacChange
  else if ModeAction = tacDelete then
    FDistribuidorController.DistribuidorModel.Action := uEnumerado.tacDelete;

  FDistribuidorController.DistribuidorModel.Nome        := edtNome.Text;
  FDistribuidorController.DistribuidorModel.CpfCnpj     := edtCNPJ.Text;
  FDistribuidorController.DistribuidorModel.Id          := StrToInt(edtId.Text);

  if FDistribuidorController.Salvar() then
  begin
    LimparCampos;
    Modo(statusInitial);
    ShowMessage('Registro salvo com sucesso!');
  end;
end;

procedure TFrmCadDistribuidor.Inserir;
begin
  try
    FDistribuidorController.DistribuidorModel.Id := FDistribuidorController.DistribuidorModel.GetId(1);
    edtId.Text                                   := FDistribuidorController.DistribuidorModel.Id.ToString();

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

procedure TFrmCadDistribuidor.LimparCampos;
begin
  edtId.Clear;
  edtNome.Clear;
  edtCNPJ.Clear;
end;

procedure TFrmCadDistribuidor.Modo(pModo: TControlButtons);
begin
  inherited;

end;

procedure TFrmCadDistribuidor.Pesquisar;
begin
  Application.CreateForm(TfrmPesquisaDistribuidor, FrmPesquisaDistribuidor);
  Modo(statusSearch);
  try
    FrmPesquisaDistribuidor.ShowModal;

    if FrmPesquisaDistribuidor.ModalResult = mrCancel then
    begin
      Modo(statusInitial);
      LimparCampos;
      Exit;
    end
    else if FrmPesquisaDistribuidor.ModalResult = mrOk then
    begin
      edtId.Text         := IntToStr(FrmPesquisaDistribuidor.qryPesquisaDistribuidorDISTRIBUIDOR_ID.AsInteger);
      edtNome.Text       := FrmPesquisaDistribuidor.qryPesquisaDistribuidorNOME.AsString;
      edtCNPJ.Text       := FrmPesquisaDistribuidor.qryPesquisaDistribuidorCNPJ.AsString;

      ModeAction := tacChange;
    end;

  finally
    FreeAndNil(FrmPesquisaDistribuidor);
  end;
end;

function TFrmCadDistribuidor.ValidarCampos: Boolean;
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

  if Trim(edtCNPJ.Text) = '' then
  begin
    ShowMessage('O campo "CNPJ" é obrigatório.');
    edtCNPJ.SetFocus;
    Exit;
  end;

  if not uBiblioteca.ValidaCNPJ(Trim(edtCNPJ.Text)) then
  begin
    ShowMessage('O campo "CNPJ" é Inválido.');
    edtCNPJ.SetFocus;
    Exit;
  end;

  // Verificar se o CNPJ consta cadastrado! - Não permitir CNPJ repetido!
  // Falta Desenvolver!

  Result := True;
end;

end.
