unit uGestorNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, dxGDIPlusClasses,
  Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DateUtils,
  Classe.Mensagem,
  Classe.Negociacoes.Interfaces,
  Classe.Negociacoes.Negociacao, Vcl.WinXPickers, Vcl.ComCtrls, frxExportPDF,
  frxExportXLSX, frxClass, frxExportBaseDialog, frxExportDOCX, frxDBSet;

type
  TfrmGestorNegociacoes = class(TfrmBase)
    pnlComandos: TPanel;
    btnAprovar: TButton;
    btnConcluir: TButton;
    btnCancelar: TButton;
    DBGrid1: TDBGrid;
    pnlFiltros: TPanel;
    cbbStatus: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCodProdutor: TEdit;
    edtNomeProdutor: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtCodDistribuidor: TEdit;
    edtNomeDistribuidor: TEdit;
    btnImprimir: TButton;
    btnFiltrar: TButton;
    Label5: TLabel;
    dsrNegociacoes: TDataSource;
    FDQNegociacoes: TFDQuery;
    FDQNegociacoesID: TIntegerField;
    FDQNegociacoesSTATUS: TStringField;
    FDQNegociacoesDESCRICAO: TStringField;
    FDQNegociacoesID_PRODUTOR: TIntegerField;
    FDQNegociacoesID_DISTRIBUIDOR: TIntegerField;
    FDQNegociacoesVALOR: TFMTBCDField;
    FDQNegociacoesCL_PRODUTOR: TStringField;
    FDQNegociacoesCL_DISTRIBUIDOR: TStringField;
    Label6: TLabel;
    dtCadastroIni: TDateTimePicker;
    dtCadastroFim: TDateTimePicker;
    Label7: TLabel;
    frx: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxDOCXExport1: TfrxDOCXExport;
    frxXLSXExport1: TfrxXLSXExport;
    frxPDFExport1: TfrxPDFExport;
    FDQNegociacoesDATA_CADASTRO: TDateField;
    FDQNegociacoesDATA_APROVACAO: TDateField;
    FDQNegociacoesDATA_CONCLUSAO: TDateField;
    FDQNegociacoesDATA_CANCELAMENTO: TDateField;
    procedure btnAprovarClick(Sender: TObject);
    procedure edtCodProdutorEnter(Sender: TObject);
    procedure edtCodProdutorExit(Sender: TObject);
    procedure edtCodDistribuidorExit(Sender: TObject);
    procedure edtCodDistribuidorEnter(Sender: TObject);
    procedure FDQNegociacoesSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnConcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbStatusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FDQNegociacoesCalcFields(DataSet: TDataSet);
    procedure dsrNegociacoesDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnImprimirClick(Sender: TObject);
  private
  var
    _SQLPADRAO: String;
    procedure ExecutaAcaoStatus(const pStatus: TStatus);
    function Filtros: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGestorNegociacoes: TfrmGestorNegociacoes;

implementation

{$R *.dfm}


uses ConexaoDB, GETFuncoes;

procedure TfrmGestorNegociacoes.btnAprovarClick(Sender: TObject);
begin
  inherited;
  ExecutaAcaoStatus(TStatus.stAprovada);
end;

procedure TfrmGestorNegociacoes.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ExecutaAcaoStatus(TStatus.stCancelada);
end;

procedure TfrmGestorNegociacoes.btnConcluirClick(Sender: TObject);
begin
  inherited;
  ExecutaAcaoStatus(TStatus.stConcluida);
end;

procedure TfrmGestorNegociacoes.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  var
  sWhere := TStringBuilder.Create;
  try
    FDQNegociacoes.Close;
    FDQNegociacoes.SQL.Text := _SQLPADRAO;
    case cbbStatus.ItemIndex of
      1:
        sWhere.Append(' and STATUS = ' + QuotedStr(TStatus.stPendente.AsValue));
      2:
        sWhere.Append(' and STATUS = ' + QuotedStr(TStatus.stAprovada.AsValue));
      3:
        sWhere.Append(' and STATUS = ' + QuotedStr(TStatus.stConcluida.AsValue));
      4:
        sWhere.Append(' and STATUS = ' + QuotedStr(TStatus.stCancelada.AsValue));
    end;

    if not Trim(edtCodProdutor.Text).IsEmpty then
      sWhere.Append('  and ID_PRODUTOR = ' + Trim(edtCodProdutor.Text));

    if not Trim(edtCodDistribuidor.Text).IsEmpty then
      sWhere.Append('  and ID_DISTRIBUIDOR = ' + Trim(edtCodDistribuidor.Text));

    FDQNegociacoes.SQL.Add(sWhere.ToString + ' order by ID');
    FDQNegociacoes.ParamByName('DATAINI').AsDate := dtCadastroIni.Date;
    FDQNegociacoes.ParamByName('DATAFIM').AsDate := dtCadastroFim.Date;
    FDQNegociacoes.Open;
  finally
    FreeAndNil(sWhere);
  end;
end;

procedure TfrmGestorNegociacoes.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if FDQNegociacoes.IsEmpty then
  begin
    TMensagem.New(Self.Caption, 'Dados em branco, não é possível impressão!').Execute;
    exit;
  end;

  frx.Variables['Filtros'] := QuotedStr(Filtros);
  frx.Report.PrintOptions.PrintOnSheet := 9;
  frx.ShowReport;
end;

procedure TfrmGestorNegociacoes.cbbStatusClick(Sender: TObject);
begin
  inherited;
  btnFiltrarClick(nil);
end;

procedure TfrmGestorNegociacoes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // inherited;
  if FDQNegociacoes.IsEmpty then
    exit;

  if TStatus.parse_value(FDQNegociacoesSTATUS.AsString) = TStatus.stCancelada then
    DBGrid1.Canvas.Font.Color := clRed
  else if TStatus.parse_value(FDQNegociacoesSTATUS.AsString) = TStatus.stAprovada then
    DBGrid1.Canvas.Font.Color := clBlue
  else if TStatus.parse_value(FDQNegociacoesSTATUS.AsString) = TStatus.stConcluida then
    DBGrid1.Canvas.Font.Color := clGreen
  else
    DBGrid1.Canvas.Font.Color := clBlack;

  DBGrid1.Canvas.FillRect(Rect);
  DBGrid1.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmGestorNegociacoes.dsrNegociacoesDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if FDQNegociacoes.IsEmpty then
    exit;

  var
  FStatus := TStatus.parse_value(FDQNegociacoesSTATUS.AsString);

  btnAprovar.Enabled := FStatus = TStatus.stPendente;
  btnConcluir.Enabled := FStatus = TStatus.stAprovada;
  btnCancelar.Enabled := FStatus in [TStatus.stPendente, TStatus.stAprovada];
end;

procedure TfrmGestorNegociacoes.edtCodDistribuidorEnter(Sender: TObject);
begin
  inherited;
  pnlFiltros.Caption := 'Código do Distribuidor / Ajuda em F12';
end;

procedure TfrmGestorNegociacoes.edtCodDistribuidorExit(Sender: TObject);
begin
  inherited;
  pnlFiltros.Caption := string.Empty;
  edtNomeDistribuidor.Clear;
  if not Trim(edtCodDistribuidor.Text).IsEmpty then
    edtNomeDistribuidor.Text := BuscaAux('DISTRIBUIDORES', 'NOME', 'ID', Trim(edtCodDistribuidor.Text), dm.con);
end;

procedure TfrmGestorNegociacoes.edtCodProdutorEnter(Sender: TObject);
begin
  inherited;
  pnlFiltros.Caption := 'Código do Produtor / Ajuda em F12';
end;

procedure TfrmGestorNegociacoes.edtCodProdutorExit(Sender: TObject);
begin
  inherited;
  pnlFiltros.Caption := string.Empty;
  edtNomeProdutor.Clear;
  if not Trim(edtCodProdutor.Text).IsEmpty then
    edtNomeProdutor.Text := BuscaAux('PRODUTORES', 'NOME', 'ID', Trim(edtCodProdutor.Text), dm.con);
end;

procedure TfrmGestorNegociacoes.ExecutaAcaoStatus(const pStatus: TStatus);
begin
  if FDQNegociacoes.IsEmpty then
    exit;

  if not TMensagem.New(Self.Caption, Format('Confirma %s da negociação nº %d ?',
    [pStatus.Descritiva.ToLower, FDQNegociacoesID.AsInteger]), True).Execute then
    exit;

  try
    TNegociacao.New(FDQNegociacoesID.AsInteger, pStatus, dm.con).Execute;
    TMensagem.New(Self.Caption, Format('Negociação %s com sucesso!', [pStatus.Descricao.ToLower])).Execute;
    FDQNegociacoes.Refresh;
  except
    on e: Exception do
    begin
      TMensagem.New(Self.Caption, e.Message).Execute;
    end;
  end;
end;

procedure TfrmGestorNegociacoes.FDQNegociacoesCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FDQNegociacoesID_PRODUTOR.AsInteger > 0 then
    FDQNegociacoesCL_PRODUTOR.AsString := BuscaAux('PRODUTORES', 'NOME', 'ID', FDQNegociacoesID_PRODUTOR.AsString, dm.con)
  else
    FDQNegociacoesCL_PRODUTOR.Clear;

  if FDQNegociacoesID_DISTRIBUIDOR.AsInteger > 0 then
    FDQNegociacoesCL_DISTRIBUIDOR.AsString := BuscaAux('DISTRIBUIDORES', 'NOME', 'ID', FDQNegociacoesID_DISTRIBUIDOR.AsString, dm.con)
  else
    FDQNegociacoesCL_DISTRIBUIDOR.Clear;
end;

procedure TfrmGestorNegociacoes.FDQNegociacoesSTATUSGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if not Sender.AsString.IsEmpty then
    Text := TStatus.parse_value(Sender.AsString).Descricao;
end;

procedure TfrmGestorNegociacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmGestorNegociacoes := Nil;
end;

procedure TfrmGestorNegociacoes.FormCreate(Sender: TObject);
begin
  inherited;
  _SQLPADRAO := FDQNegociacoes.SQL.Text;
end;

procedure TfrmGestorNegociacoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
  else
    inherited;
end;

procedure TfrmGestorNegociacoes.FormShow(Sender: TObject);
begin
  inherited;
  dtCadastroIni.Date := IncDay(Date, -30);
  dtCadastroFim.MaxDate := Date;
  dtCadastroFim.Date := Date;

  btnFiltrarClick(nil);
end;

function TfrmGestorNegociacoes.Filtros: String;
begin
  var
  LFiltros := TStringBuilder.Create;
  try
    LFiltros.Append('Status: ' + cbbStatus.Text);
    LFiltros.Append('; Cadastro entre: ' + DateToStr(dtCadastroIni.Date) + ' até ' + DateToStr(dtCadastroFim.Date));

    if not Trim(edtCodProdutor.Text).IsEmpty then
      LFiltros.Append(Format('; Produtor: %s-%s', [Trim(edtCodProdutor.Text), Trim(edtNomeProdutor.Text)]));

    if not Trim(edtCodDistribuidor.Text).IsEmpty then
      LFiltros.Append(Format('; Distribuidor: %s-%s', [Trim(edtCodDistribuidor.Text), Trim(edtNomeDistribuidor.Text)]));

    Result := LFiltros.ToString;
  finally
    if Assigned(LFiltros) then
      FreeAndNil(LFiltros);
  end;
end;

end.
