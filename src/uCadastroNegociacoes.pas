unit uCadastroNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.StdCtrls, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadNegociacoes = class(TfrmCadPadrao)
    FDQCadastro: TFDQuery;
    FDQCadastroID: TIntegerField;
    FDQCadastroSTATUS: TStringField;
    FDQCadastroDESCRICAO: TStringField;
    FDQCadastroID_PRODUTOR: TIntegerField;
    FDQCadastroID_DISTRIBUIDOR: TIntegerField;
    FDQCadastroVALOR: TFMTBCDField;
    FDQCadastroCL_PRODUTOR: TStringField;
    FDQCadastroCL_DISTRIBUIDOR: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbedtID: TDBEdit;
    dbedtDESCRICAO: TDBEdit;
    dbedtID_PRODUTOR: TDBEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    btnIncluirProdutos: TButton;
    edtCodProduto: TEdit;
    edtNomeProduto: TEdit;
    DBGridProdutos: TDBGrid;
    dbedtCL_PRODUTOR: TDBEdit;
    Label7: TLabel;
    dbedtID_DISTRIBUIDOR: TDBEdit;
    dbedtCL_DISTRIBUIDOR: TDBEdit;
    FDQProdutos: TFDQuery;
    dsrProdutos: TDataSource;
    FDQProdutosID: TIntegerField;
    FDQProdutosID_NEGOCIACAO: TIntegerField;
    FDQProdutosID_PRODUTO: TIntegerField;
    FDQProdutosVALOR: TFMTBCDField;
    FDQProdutosCL_PRODUTO: TStringField;
    pnlInfoDelete: TPanel;
    dbedtVALOR: TDBEdit;
    Label6: TLabel;
    FDQCadastroDATA_CADASTRO: TDateField;
    procedure dbedtID_PRODUTOREnter(Sender: TObject);
    procedure dbedtID_DISTRIBUIDOREnter(Sender: TObject);
    procedure edtCodProdutoEnter(Sender: TObject);
    procedure dbedtID_PRODUTORExit(Sender: TObject);
    procedure dbedtID_DISTRIBUIDORExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure FDQCadastroNewRecord(DataSet: TDataSet);
    procedure FDQCadastroCalcFields(DataSet: TDataSet);
    procedure dbedtID_DISTRIBUIDORKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbedtID_PRODUTORKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure dbedtID_DISTRIBUIDORKeyPress(Sender: TObject; var Key: Char);
    procedure dbedtID_PRODUTORKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirProdutosClick(Sender: TObject);
    procedure DBGridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actExcluirExecute(Sender: TObject);
    procedure tbshtCadastroShow(Sender: TObject);
    procedure FDQCadastroAfterOpen(DataSet: TDataSet);
    procedure FDQProdutosCalcFields(DataSet: TDataSet);
    procedure tbShtGridShow(Sender: TObject);
    procedure FDQCadastroSTATUSGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Grid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure IncluirProdutos;
    procedure LimparDadosProdutos;
    procedure TotalizaNegociacao;
    procedure BloqueiaNaoPendente;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadNegociacoes: TfrmCadNegociacoes;

const
  CAPTION_BOTTON = 'Aliare® copyright 2022';

implementation

{$R *.dfm}


uses ConexaoDB, GETFuncoes, Classe.Negociacoes.Interfaces,
  uCadastroDistribuidores, uCadastroProdutores, uCadastroProdutos,
  Classe.Mensagem;

procedure TfrmCadNegociacoes.edtCodProdutoEnter(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := 'Código do Produto / Ajuda em F12';
end;

procedure TfrmCadNegociacoes.edtCodProdutoExit(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := CAPTION_BOTTON;

  edtNomeProduto.Clear;
  if Trim(edtCodProduto.Text).IsEmpty then
    exit;
  edtNomeProduto.Text := BuscaAux('PRODUTOS', 'DESCRICAO', 'ID', Trim(edtCodProduto.Text), DM.con);
end;

procedure TfrmCadNegociacoes.edtCodProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key <> VK_F12 then
    exit;
  vls_SQL := vgs_SQLPADRAO;
  AbreForm(TfrmCadProdutos, True, True, frmCadProdutos);
  vgs_SQLPADRAO := vls_SQL;
  if vgs_CAMPO_CHAVE.Trim.IsEmpty then
    exit;
  edtCodProduto.Text := vgs_CAMPO_CHAVE;
  edtCodProdutoExit(nil);
  vgs_CAMPO_CHAVE := string.Empty;
end;

procedure TfrmCadNegociacoes.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) then
    Key := #0;
end;

procedure TfrmCadNegociacoes.FDQCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FDQProdutos.Close;
  FDQProdutos.Open;
end;

procedure TfrmCadNegociacoes.FDQCadastroCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FDQCadastroID_PRODUTOR.AsInteger > 0 then
    FDQCadastroCL_PRODUTOR.AsString := BuscaAux('PRODUTORES', 'NOME', 'ID', FDQCadastroID_PRODUTOR.AsString, DM.con)
  else
    FDQCadastroCL_PRODUTOR.Clear;

  if FDQCadastroID_DISTRIBUIDOR.AsInteger > 0 then
    FDQCadastroCL_DISTRIBUIDOR.AsString := BuscaAux('DISTRIBUIDORES', 'NOME', 'ID', FDQCadastroID_DISTRIBUIDOR.AsString, DM.con)
  else
    FDQCadastroCL_DISTRIBUIDOR.Clear;
end;

procedure TfrmCadNegociacoes.FDQCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDQCadastroSTATUS.AsString := TStatus.stPendente.AsValue;
  FDQCadastroDATA_CADASTRO.AsDateTime := Date;
end;

procedure TfrmCadNegociacoes.FDQCadastroSTATUSGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if not Sender.AsString.IsEmpty then
    Text := TStatus.parse_value(Sender.AsString).Descricao;
end;

procedure TfrmCadNegociacoes.FDQProdutosCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FDQProdutosID_PRODUTO.AsInteger > 0 then
    FDQProdutosCL_PRODUTO.AsString := BuscaAux('PRODUTOS', 'DESCRICAO', 'ID', FDQProdutosID_PRODUTO.AsString, DM.con)
  else
    FDQProdutosCL_PRODUTO.Clear;
end;

procedure TfrmCadNegociacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadNegociacoes := nil;
end;

procedure TfrmCadNegociacoes.Grid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // inherited;

  if FDQCadastro.IsEmpty then
    exit;

  if TStatus.parse_value(FDQCadastroSTATUS.AsString) = TStatus.stCancelada then
    Grid1.Canvas.Font.Color := clRed
  else if TStatus.parse_value(FDQCadastroSTATUS.AsString) = TStatus.stAprovada then
    Grid1.Canvas.Font.Color := clBlue
  else if TStatus.parse_value(FDQCadastroSTATUS.AsString) = TStatus.stConcluida then
    Grid1.Canvas.Font.Color := clGreen
  else
    Grid1.Canvas.Font.Color := clBlack;

  Grid1.Canvas.FillRect(Rect);
  Grid1.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmCadNegociacoes.actExcluirExecute(Sender: TObject);
begin
  BloqueiaNaoPendente;
  inherited;
end;

procedure TfrmCadNegociacoes.btnIncluirProdutosClick(Sender: TObject);
begin
  inherited;
  if FDQCadastro.State in dsEditModes then
    actGravarExecute(nil);
  IncluirProdutos;
end;

procedure TfrmCadNegociacoes.dbedtID_DISTRIBUIDOREnter(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := 'Código do Distribuidor / Ajuda em F12';
end;

procedure TfrmCadNegociacoes.dbedtID_DISTRIBUIDORExit(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := CAPTION_BOTTON;
end;

procedure TfrmCadNegociacoes.dbedtID_DISTRIBUIDORKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key <> VK_F12 then
    exit;
  vls_SQL := vgs_SQLPADRAO;
  AbreForm(TfrmCadDistribuidores, True, True, frmCadDistribuidores);
  vgs_SQLPADRAO := vls_SQL;
  if vgs_CAMPO_CHAVE.Trim.IsEmpty then
    exit;
  dbedtID_DISTRIBUIDOR.Text := vgs_CAMPO_CHAVE;
  vgs_CAMPO_CHAVE := string.Empty;
end;

procedure TfrmCadNegociacoes.dbedtID_DISTRIBUIDORKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) then
    Key := #0;
end;

procedure TfrmCadNegociacoes.dbedtID_PRODUTOREnter(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := 'Código do Produtor / Ajuda em F12';
end;

procedure TfrmCadNegociacoes.dbedtID_PRODUTORExit(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := CAPTION_BOTTON;
end;

procedure TfrmCadNegociacoes.dbedtID_PRODUTORKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key <> VK_F12 then
    exit;
  vls_SQL := vgs_SQLPADRAO;
  AbreForm(TfrmCadProdutores, True, True, frmCadProdutores);
  vgs_SQLPADRAO := vls_SQL;
  if vgs_CAMPO_CHAVE.Trim.IsEmpty then
    exit;
  dbedtID_PRODUTOR.Text := vgs_CAMPO_CHAVE;
  vgs_CAMPO_CHAVE := string.Empty;
end;

procedure TfrmCadNegociacoes.dbedtID_PRODUTORKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) then
    Key := #0;
end;

procedure TfrmCadNegociacoes.DBGridProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if not(gdSelected in State) then
  begin
    if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
      (Sender as TDBGrid).Canvas.Brush.Color := clWhite
    else
      (Sender as TDBGrid).Canvas.Brush.Color := $00F1F2F3; // leve cinza

    (Sender as TDBGrid).Canvas.Font.Color := clBlack;

    (Sender as TDBGrid).Canvas.FillRect(Rect);
    (Sender as TDBGrid).Canvas.TextOut(Rect.Left + 2, Rect.Top,
      Column.Field.DisplayText);
  end;
end;

procedure TfrmCadNegociacoes.DBGridProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key <> VK_DELETE then
    exit;

  if FDQProdutos.IsEmpty then
    exit;

  BloqueiaNaoPendente;

  if not TMensagem.New(Self.Caption, 'Excluir produto selecionado?', True).Execute then
    exit;

  FDQProdutos.Delete;
  TotalizaNegociacao;
end;

procedure TfrmCadNegociacoes.LimparDadosProdutos;
begin
  edtCodProduto.Clear;
  edtNomeProduto.Clear;
end;

procedure TfrmCadNegociacoes.tbshtCadastroShow(Sender: TObject);
begin
  inherited;
  if dbedtDESCRICAO.CanFocus then
    dbedtDESCRICAO.SetFocus;
  Width := 880;
  CentralizarFormulario(Self);
end;

procedure TfrmCadNegociacoes.tbShtGridShow(Sender: TObject);
begin
  inherited;
  Width := 1400;
  CentralizarFormulario(Self);
end;

procedure TfrmCadNegociacoes.IncluirProdutos;
  procedure ValidaCamposObrigatorios;
  begin
    if Trim(edtCodProduto.Text).IsEmpty then
    begin
      TMensagem.New(Self.Caption, 'Favor preencher código do produto!').Execute;
      if edtCodProduto.CanFocus then
        edtCodProduto.SetFocus;
      abort;
    end;
  end;
  procedure ValidaProdutoRepetido;
  begin
    var
    QryConsulta := TFDQuery.Create(nil);
    try
      QryConsulta.Connection := DM.con;
      QryConsulta.SQL.Add('SELECT');
      QryConsulta.SQL.Add(' id');
      QryConsulta.SQL.Add('from NEGOCIACOES_ITENS');
      QryConsulta.SQL.Add('where ID_NEGOCIACAO = :ID_NEGOCIACAO');
      QryConsulta.SQL.Add('  AND ID_PRODUTO = :ID_PRODUTO');
      QryConsulta.ParamByName('ID_NEGOCIACAO').AsInteger := FDQCadastroID.AsInteger;
      QryConsulta.ParamByName('ID_PRODUTO').AsString := Trim(edtCodProduto.Text);
      QryConsulta.Open();
      if not QryConsulta.IsEmpty then
      begin
        TMensagem.New(Self.Caption, Format('Produto %s - %s já presente nessa negociação!',
          [Trim(edtCodProduto.Text), Trim(edtNomeProduto.Text)])).Execute;
        if edtCodProduto.CanFocus then
          edtCodProduto.SetFocus;
        abort;
      end;
    finally
      QryConsulta.Close;
      FreeAndNil(QryConsulta);
    end;
  end;
  function getValorProduto: String;
  begin
    var
    nValor := DM.con.ExecSQLScalar('select PRECO_VENDA from PRODUTOS where ID = ' + Trim(edtCodProduto.Text));

    Result := FloatToStr(nValor).Replace('.', '').Replace(',', '.');
  end;

begin
  if FDQCadastro.IsEmpty then
    exit;

  ValidaCamposObrigatorios;
  BloqueiaNaoPendente;
  ValidaProdutoRepetido;

  var
  sInsert := Format('insert into NEGOCIACOES_ITENS (ID_NEGOCIACAO, ID_PRODUTO, VALOR) values (%d, %s, %s)',
    [FDQCadastroID.AsInteger, Trim(edtCodProduto.Text), getValorProduto]);

  try
    DM.con.ExecSQL(sInsert);
    FDQProdutos.Refresh;
    LimparDadosProdutos;
    TotalizaNegociacao;
    if edtCodProduto.CanFocus then
      edtCodProduto.SetFocus;
  except
    on e: exception do
    begin
      TMensagem.New(Self.Caption, 'Erro ao incluir produtos na negociação!' + sLineBreak + 'Motivo: ' + e.Message).Execute;
    end;
  end;
end;

procedure TfrmCadNegociacoes.TotalizaNegociacao;
begin
  var
  nValorTotal := DM.con.ExecSQLScalar('select sum(VALOR) from NEGOCIACOES_ITENS where ID_NEGOCIACAO = ' + FDQCadastroID.AsString);

  if FDQCadastro.State <> dsEdit then
    FDQCadastro.Edit;
  FDQCadastroVALOR.AsCurrency := nValorTotal;
  FDQCadastro.Post;
end;

procedure TfrmCadNegociacoes.BloqueiaNaoPendente;
begin
  var
  FStatus := TStatus.parse_value(FDQCadastroSTATUS.AsString);

  if FStatus <> TStatus.stPendente then
  begin
    TMensagem.New(Self.Caption, Format('Ação só é permitida em negociações abertas, atual: %s', [FStatus.Descricao.ToUpper])).Execute;
    abort;
  end;
end;

end.
