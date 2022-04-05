unit uCadastroProdutores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, System.ImageList,
  Vcl.ImgList, dxGDIPlusClasses;

type
  TfrmCadProdutores = class(TfrmCadPadrao)
    FDQCadastro: TFDQuery;
    FDQCadastroID: TIntegerField;
    FDQCadastroNOME: TStringField;
    FDQCadastroCPF_CNPJ: TStringField;
    dbedtID: TDBEdit;
    dbedtNOME: TDBEdit;
    dbedtCPF_CNPJ: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    btnIncluirLimite: TButton;
    edtCodDistribuidor: TEdit;
    edtNomeDistribuidor: TEdit;
    edtValorLimite: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    FDQLimite: TFDQuery;
    FDQLimiteID: TIntegerField;
    FDQLimiteID_PRODUTOR: TIntegerField;
    FDQLimiteID_DISTRIBUIDOR: TIntegerField;
    FDQLimiteLIMITE_CREDITO: TFMTBCDField;
    dsrLimites: TDataSource;
    FDQLimiteCL_DISTRIBUIDOR: TStringField;
    Panel1: TPanel;
    procedure FDQCadastroCPF_CNPJGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbedtCPF_CNPJKeyPress(Sender: TObject; var Key: Char);
    procedure FDQCadastroAfterOpen(DataSet: TDataSet);
    procedure edtCodDistribuidorEnter(Sender: TObject);
    procedure edtCodDistribuidorExit(Sender: TObject);
    procedure edtCodDistribuidorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirLimiteClick(Sender: TObject);
    procedure edtValorLimiteKeyPress(Sender: TObject; var Key: Char);
    procedure FDQLimiteCalcFields(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodDistribuidorKeyPress(Sender: TObject; var Key: Char);
  private
    procedure LimparDadosDistribuidor;
    procedure IncluirDistribuidor;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProdutores: TfrmCadProdutores;

implementation

{$R *.dfm}


uses ConexaoDB, GETFuncoes, uCadastroDistribuidores, Classe.Mensagem;

procedure TfrmCadProdutores.btnIncluirLimiteClick(Sender: TObject);
begin
  inherited;
  if FDQCadastro.State in dsEditModes then
    actGravarExecute(nil);
  IncluirDistribuidor;
end;

procedure TfrmCadProdutores.dbedtCPF_CNPJKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) then
    Key := #0;
end;

procedure TfrmCadProdutores.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TfrmCadProdutores.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key <> VK_DELETE then
    exit;

  if FDQLimite.IsEmpty then
    exit;

  if TMensagem.New(Self.Caption, 'Excluir limite selecionado?', True).Execute then
    FDQLimite.Delete;
end;

procedure TfrmCadProdutores.edtCodDistribuidorEnter(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := 'Código do Distribuidor / Ajuda em F12';
end;

procedure TfrmCadProdutores.edtCodDistribuidorExit(Sender: TObject);
begin
  inherited;
  pnlBotton.Caption := 'Aliare® copyright 2022';

  edtNomeDistribuidor.Clear;
  if Trim(edtCodDistribuidor.Text).IsEmpty then
    exit;
  edtNomeDistribuidor.Text := BuscaAux('DISTRIBUIDORES', 'NOME', 'ID', Trim(edtCodDistribuidor.Text), DM.con);
end;

procedure TfrmCadProdutores.edtCodDistribuidorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key <> VK_F12 then
    exit;
  vls_SQL := vgs_SQLPADRAO;
  AbreForm(TfrmCadDistribuidores, True, True, frmCadDistribuidores);
  vgs_SQLPADRAO := vls_SQL;
  if vgs_CAMPO_CHAVE.Trim.IsEmpty then
    exit;
  edtCodDistribuidor.Text := vgs_CAMPO_CHAVE;
  edtCodDistribuidorExit(nil);
  vgs_CAMPO_CHAVE := string.Empty;
end;

procedure TfrmCadProdutores.edtCodDistribuidorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) then
    Key := #0;
end;

procedure TfrmCadProdutores.edtValorLimiteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) and (Key <> FormatSettings.DecimalSeparator) then
    Key := #0;
end;

procedure TfrmCadProdutores.FDQCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FDQLimite.Close;
  FDQLimite.Open;
end;

procedure TfrmCadProdutores.FDQCadastroCPF_CNPJGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := FormataCPF_CNPJ(Sender.AsString);
end;

procedure TfrmCadProdutores.FDQLimiteCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FDQLimiteID_DISTRIBUIDOR.AsInteger > 0 then
    FDQLimiteCL_DISTRIBUIDOR.AsString := BuscaAux('DISTRIBUIDORES', 'NOME', 'ID', FDQLimiteID_DISTRIBUIDOR.AsString, DM.con)
  else
    FDQLimiteCL_DISTRIBUIDOR.Clear;
end;

procedure TfrmCadProdutores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProdutores := nil;
end;

procedure TfrmCadProdutores.LimparDadosDistribuidor;
begin
  edtCodDistribuidor.Clear;
  edtNomeDistribuidor.Clear;
  edtValorLimite.Clear;
end;

procedure TfrmCadProdutores.IncluirDistribuidor;
  procedure ValidaCamposObrigatorios;
  begin
    if Trim(edtCodDistribuidor.Text).IsEmpty then
    begin
      TMensagem.New(Self.Caption, 'Favor preencher código do distribuidor!').Execute;
      if edtCodDistribuidor.CanFocus then
        edtCodDistribuidor.SetFocus;
      abort;
    end;

    if StrToCurrDef(Trim(edtValorLimite.Text), 0) <= 0 then
    begin
      TMensagem.New(Self.Caption, 'Valor do limite inválido!').Execute;
      if edtValorLimite.CanFocus then
        edtValorLimite.SetFocus;
      abort;
    end;
  end;

  procedure ValidaDistribuidorRepetido;
  begin
    var
    QryConsulta := TFDQuery.Create(nil);
    try
      QryConsulta.Connection := DM.con;
      QryConsulta.SQL.Add('SELECT');
      QryConsulta.SQL.Add(' id');
      QryConsulta.SQL.Add('from PRODUTORES_LIMITES');
      QryConsulta.SQL.Add('where ID_PRODUTOR = :ID_PRODUTOR');
      QryConsulta.SQL.Add('  AND ID_DISTRIBUIDOR = :ID_DISTRIBUIDOR');
      QryConsulta.ParamByName('ID_PRODUTOR').AsInteger := FDQCadastroID.AsInteger;
      QryConsulta.ParamByName('ID_DISTRIBUIDOR').AsString := Trim(edtCodDistribuidor.Text);
      QryConsulta.Open();
      if not QryConsulta.IsEmpty then
      begin
        TMensagem.New(Self.Caption, 'Já existe limite de crédito cadastrado para esse distribuidor.').Execute;
        if edtCodDistribuidor.CanFocus then
          edtCodDistribuidor.SetFocus;
        abort;
      end;
    finally
      QryConsulta.Close;
      FreeAndNil(QryConsulta);
    end;
  end;

begin
  ValidaCamposObrigatorios;
  ValidaDistribuidorRepetido;

  var
  sInsert := Format('insert into PRODUTORES_LIMITES (ID_PRODUTOR, ID_DISTRIBUIDOR, LIMITE_CREDITO) values (%d, %s, %s)',
    [FDQCadastroID.AsInteger, Trim(edtCodDistribuidor.Text), Trim(edtValorLimite.Text).Replace('.', '').Replace(',', '.')]);

  try
    DM.con.ExecSQL(sInsert);
    FDQLimite.Refresh;
    LimparDadosDistribuidor;
    if edtCodDistribuidor.CanFocus then
      edtCodDistribuidor.SetFocus;
  except
    on e: exception do
    begin
      TMensagem.New(Self.Caption, 'Erro ao incluir limite de crédito distribuidor!' + sLineBreak + 'Motivo: ' + e.Message).Execute;
    end;
  end;
end;

end.
