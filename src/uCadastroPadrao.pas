unit uCadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxButtons, System.Actions, Vcl.ActnList,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Classe.Mensagem, ConexaoDB, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, System.ImageList, Vcl.ImgList, dxGDIPlusClasses;

type
  TfrmCadPadrao = class(TfrmBase)
    actlst: TActionList;
    actNovo: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actGravar: TAction;
    actCancelar: TAction;
    pnlComandos: TPanel;
    btnNovo: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnVoltar: TButton;
    dsrCadastro: TDataSource;
    pgGeral: TPageControl;
    tbShtGrid: TTabSheet;
    tbshtCadastro: TTabSheet;
    Grid1: TDBGrid;
    procedure dsrCadastroDataChange(Sender: TObject; Field: TField);
    procedure actNovoExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbshtCadastroHide(Sender: TObject);
    procedure tbshtCadastroShow(Sender: TObject);
    procedure tbShtGridShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Grid1DblClick(Sender: TObject);
    procedure Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Grid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure AbreDataset;
    procedure SelecionaRegistro;
  public
    { Public declarations }
  var
    vls_SQL: String;
  end;

var
  frmCadPadrao: TfrmCadPadrao;

implementation

{$R *.dfm}


uses GETFuncoes;

procedure TfrmCadPadrao.AbreDataset;
begin
  dsrCadastro.DataSet.close;
  TFDQuery(dsrCadastro.DataSet).SQL.Clear;
  TFDQuery(dsrCadastro.DataSet).SQL.Text := vgs_SQLPADRAO;
  dsrCadastro.DataSet.Open;
end;

procedure TfrmCadPadrao.actAlterarExecute(Sender: TObject);
begin
  inherited;
  if dsrCadastro.DataSet.IsEmpty then
    Exit;
  dsrCadastro.DataSet.Edit;

  pgGeral.ActivePageIndex := 1;
end;

procedure TfrmCadPadrao.actCancelarExecute(Sender: TObject);
begin
  inherited;
  if not(dsrCadastro.DataSet.State in dsEditModes) then
    Exit;

  dsrCadastro.DataSet.Cancel;
  pgGeral.ActivePageIndex := 0;
end;

procedure TfrmCadPadrao.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if dsrCadastro.DataSet.IsEmpty then
    Exit;

  if TMensagem.New(TForm(Self).Caption, 'Confirma exclusão do registro?', True).Execute then
    dsrCadastro.DataSet.Delete;
end;

procedure TfrmCadPadrao.actGravarExecute(Sender: TObject);
begin
  inherited;
  if dsrCadastro.DataSet.IsEmpty then
    Exit;

  FocusControl(nil);

  if not ChecaCampos(dsrCadastro.DataSet) then
    Exit;

  try
    dsrCadastro.DataSet.Post;
  except
    on E: Exception do
    begin
      dsrCadastro.DataSet.Cancel;
      TMensagem.New(TForm(Self).Caption, 'Erro ao efetuar cadastro!' + sLineBreak + 'Motivo: ' + E.Message).Execute
    end;
  end;
end;

procedure TfrmCadPadrao.actNovoExecute(Sender: TObject);
begin
  inherited;
  dsrCadastro.DataSet.close;
  TFDQuery(dsrCadastro.DataSet).SQL.Clear;
  TFDQuery(dsrCadastro.DataSet).SQL.Text := vgs_SQLPADRAO;
  TFDQuery(dsrCadastro.DataSet).SQL.Add('where id = 0');
  dsrCadastro.DataSet.Open;
  dsrCadastro.DataSet.Append;
  dsrCadastro.DataSet.FieldByName('id').Clear;
  pgGeral.ActivePageIndex := 1;
end;

procedure TfrmCadPadrao.btnVoltarClick(Sender: TObject);
begin
  inherited;
  if dsrCadastro.State in dsEditModes then
    actCancelar.Execute
  else
    pgGeral.ActivePageIndex := 0;
end;

procedure TfrmCadPadrao.dsrCadastroDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  actNovo.Enabled := not(dsrCadastro.State in dsEditModes);
  actAlterar.Enabled := (not dsrCadastro.DataSet.IsEmpty) and (actNovo.Enabled);
  actExcluir.Enabled := (not dsrCadastro.DataSet.IsEmpty) and (not(dsrCadastro.State in dsEditModes));
  actGravar.Enabled := dsrCadastro.State in dsEditModes;
  actCancelar.Enabled := actGravar.Enabled;
end;

procedure TfrmCadPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  vgs_TELA := TTipoTela.tpCadastro;
end;

procedure TfrmCadPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  for var I := 0 to Pred(pgGeral.PageCount) do
    pgGeral.Pages[I].TabVisible := False;

  vgs_SQLPADRAO := TFDQuery(dsrCadastro.DataSet).SQL.Text;
end;

procedure TfrmCadPadrao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
  begin
    if (dsrCadastro.DataSet <> Nil) and (dsrCadastro.DataSet.State in [dsInsert, dsEdit]) then
    begin
      var
      _mensagem := 'Sistema detectou que a tela ' + TForm(Self).Caption +
        ' esta em modo de inclusão ou alteração de dados.' + sLineBreak + sLineBreak +
        'Deseja realmente abortar ?';

      if not TMensagem.New(TForm(Self).Caption, _mensagem, True).Execute then
        Abort
      else
        actCancelar.Execute;
    end
    else if btnVoltar.Visible then
      btnVoltarClick(nil)
    else
      close;
  end;
end;

procedure TfrmCadPadrao.FormShow(Sender: TObject);
begin
  inherited;
  pgGeral.ActivePageIndex := 0;
  Grid1.SetFocus;
end;

procedure TfrmCadPadrao.Grid1DblClick(Sender: TObject);
begin
  inherited;
  SelecionaRegistro;
end;

procedure TfrmCadPadrao.Grid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if not(gdSelected in State) then
  begin
    if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
      (Sender as TDBGrid).Canvas.Brush.Color := clWhite
    else
      (Sender as TDBGrid).Canvas.Brush.Color := $00F1F2F3; // leve cinza

    // Aplicando prto para a cor da fonte
    (Sender as TDBGrid).Canvas.Font.Color := clBlack;

    (Sender as TDBGrid).Canvas.FillRect(Rect);
    (Sender as TDBGrid).Canvas.TextOut(Rect.Left + 2, Rect.Top, Column.Field.DisplayText);
  end;
end;

procedure TfrmCadPadrao.Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    SelecionaRegistro;
end;

procedure TfrmCadPadrao.SelecionaRegistro;
begin
  if dsrCadastro.DataSet.IsEmpty then
    Exit;

  case vgs_TELA of
    tpConsulta:
      begin
        vgs_CAMPO_CHAVE := dsrCadastro.DataSet.FieldByName('ID').AsString;
        close;
      end;
    tpCadastro:
      begin
        actAlterar.Execute;
      end;
  end;
end;

procedure TfrmCadPadrao.tbshtCadastroHide(Sender: TObject);
begin
  inherited;
  btnVoltar.Visible := False;
end;

procedure TfrmCadPadrao.tbshtCadastroShow(Sender: TObject);
begin
  inherited;
  btnVoltar.Visible := True;
end;

procedure TfrmCadPadrao.tbShtGridShow(Sender: TObject);
begin
  inherited;
  AbreDataset;
end;

end.
