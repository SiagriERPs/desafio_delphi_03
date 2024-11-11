unit uFrmCadProduto;

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
  System.UITypes,
  uEnumerado,
  uProdutoController;


type
  TFrmCadProduto = class(TFrmCadBasico)
    edtPrecoVenda: TEdit;
    lblPrecoVenda: TLabel;
    edtNome: TEdit;
    lblName: TLabel;
    edtId: TEdit;
    lblId: TLabel;
    procedure edtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FProdutoController: TProdutoController;
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
  end;

var
  FrmCadProduto: TFrmCadProduto;

implementation

{$R *.dfm}

uses
  uFrmPesquisaProduto;

procedure TFrmCadProduto.Alterar;
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

procedure TFrmCadProduto.Cancelar;
begin
  Modo(statusInitial);
  LimparCampos;
end;

procedure TFrmCadProduto.edtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, ',']) then
    Key := #0;
end;

procedure TFrmCadProduto.Excluir;
begin
  if Trim(edtId.Text) = '' then
  begin
    ShowMessage('Nenhum produto selecionado para exclusão!');
    Exit;
  end;

  if MessageDlg('Tem certeza que deseja excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ModeAction := tacDelete;
    FProdutoController.ProdutoModel.Action := tacDelete;

    FProdutoController.ProdutoModel.Id := StrToInt(edtId.Text);

    if FProdutoController.Salvar then
    begin
      ShowMessage('Produto excluído com sucesso!');
      LimparCampos;
      Modo(statusInitial);
    end
    else
    begin
      ShowMessage('Erro ao excluir o produto!');
    end;
  end;
end;

procedure TFrmCadProduto.FormCreate(Sender: TObject);
begin
  FProdutoController := TProdutoController.Create;
  Modo(statusInitial);
end;

procedure TFrmCadProduto.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(FProdutoController) then
      FreeAndNil(FProdutoController);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFrmCadProduto.Gravar;
begin
  if not ValidarCampos then
    Exit;

  if ModeAction = tacInclude then
    FProdutoController.ProdutoModel.Action := uEnumerado.tacInclude
  else if ModeAction = tacChange then
    FProdutoController.ProdutoModel.Action := uEnumerado.tacChange
  else if ModeAction = tacDelete then
    FProdutoController.ProdutoModel.Action := uEnumerado.tacDelete;

  FProdutoController.ProdutoModel.Nome        := edtNome.Text;
  FProdutoController.ProdutoModel.PrecoVenda  := StrToCurr(edtPrecoVenda.Text);
  FProdutoController.ProdutoModel.Id          := StrToInt(edtId.Text);

  if FProdutoController.Salvar() then
  begin
    LimparCampos;
    Modo(statusInitial);
    ShowMessage('Registro salvo com sucesso!');
  end;
end;

procedure TFrmCadProduto.Inserir;
begin
  try
    FProdutoController.ProdutoModel.Id := FProdutoController.ProdutoModel.GetId(1);
    edtId.Text                         := FProdutoController.ProdutoModel.Id.ToString();

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

procedure TFrmCadProduto.LimparCampos;
begin
  edtId.Clear;
  edtNome.Clear;
  edtPrecoVenda.Clear;
end;

procedure TFrmCadProduto.Pesquisar;
begin
  Application.CreateForm(TfrmPesquisaProduto, FrmPesquisaProduto);
  Modo(statusSearch);
  try
    FrmPesquisaProduto.ShowModal;

    if FrmPesquisaProduto.ModalResult = mrCancel then
    begin
      Modo(statusInitial);
      LimparCampos;
      Exit;
    end
    else if FrmPesquisaProduto.ModalResult = mrOk then
    begin
      edtId.Text               := IntToStr(FrmPesquisaProduto.qryPesquisaProdutoPRODUTO_ID.AsInteger);
      edtNome.Text             := FrmPesquisaProduto.qryPesquisaProdutoNOME.AsString;
      edtPrecoVenda.Text       := CurrToStr(FrmPesquisaProduto.qryPesquisaProdutoPRECO_VENDA.AsCurrency);

      ModeAction := tacChange;
    end;

  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

function TFrmCadProduto.ValidarCampos: Boolean;
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

  if Trim(edtPrecoVenda.Text) = '' then
  begin
    ShowMessage('O campo "Preço" é obrigatório.');
    edtPrecoVenda.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
