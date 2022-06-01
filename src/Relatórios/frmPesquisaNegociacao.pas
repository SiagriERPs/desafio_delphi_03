unit frmPesquisaNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPesquisa, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Mask;

type
  TfmPesquisaNegociacao = class(TfmPesquisa)
    mskDataInicial: TMaskEdit;
    mskDataFinal: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    rgTipoNegociacao: TRadioGroup;
    Label4: TLabel;
    dlcProdutor: TDBLookupComboBox;
    Label5: TLabel;
    dlcDistribuidor: TDBLookupComboBox;
    dsListaProdutor: TDataSource;
    dsListaDistribuidor: TDataSource;
    procedure dlcProdutorCloseUp(Sender: TObject);
    procedure dlcProdutorKeyPress(Sender: TObject; var Key: Char);
    procedure dlcDistribuidorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure bbPesquisarClick(Sender: TObject);
    procedure bbVisualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPesquisaNegociacao: TfmPesquisaNegociacao;

implementation

uses UdmConexao, UdmFuncoes, UdmNegociacao;

{$R *.dfm}

procedure TfmPesquisaNegociacao.bbPesquisarClick(Sender: TObject);
const
  sql = '  SELECT  '+
        '     (CASE WHEN ng.N_STATUS = 2 THEN ''PENDENTE''  '+
        '           WHEN ng.N_STATUS = 3 THEN ''APROVADA''  '+
        '           WHEN ng.N_STATUS = 4 THEN ''CONCLUÍDA'' '+
        '           WHEN ng.N_STATUS = 5 THEN ''CANCELADA''  '+
        '     END) AS SITUACAO,' +
        '     ng.NEGOCIACAO_ID,'  +
        '     ng.PRODUTOR_ID,'    +
        '     p.P_NOME,'         +
        '     ng.DISTRIBUIDOR_ID,' +
        '     d.D_NOME,'         +
        '     ng.N_VALORTOTAL,'    +
        '     ng.N_DATA_APROVACAO,' +
        '     ng.N_DATA_CONCLUSAO,' +
        '     ng.N_DATA_CANCELAMENTO,' +
        '     ng.DATACAD ' +

        ' FROM NEGOCIACAO ng INNER JOIN PRODUTOR p ON (p.PRODUTOR_ID = ng.PRODUTOR_ID)' +
        '                   INNER JOIN DISTRIBUIDOR d ON (d.DISTRIBUIDOR_ID = ng.DISTRIBUIDOR_ID)';
var
   isql : String;
begin
  //inherited;
  isql := sql;

  if (mskDataInicial.Text = '  /  /    ') or (mskDataFinal.Text = '  /  /    ') then begin
    Beep;
    ShowMessage('Atenção, campo Data é obrigatório');
    mskDataInicial.SetFocus;
    Exit;
  end;

  isql := isql + ' WHERE ng.DATACAD BETWEEN '+ QuotedStr(mskDataInicial.Text) + ' AND '  +  QuotedStr(mskDataFinal.Text);
  //

  if dlcProdutor.Text <> ''
    then isql := isql + ' AND ng.PRODUTOR_ID = '+ InttoStr(dlcProdutor.KeyValue);

  if dlcDistribuidor.Text <> ''
    then isql := isql + ' AND ng.DISTRIBUIDOR_ID = '+InttoStr(dlcDistribuidor.KeyValue);

  case rgTipoNegociacao.ItemIndex of
    0: isql := isql + ' AND  ng.N_STATUS = 2 ';
    1: isql := isql + ' AND  ng.N_STATUS = 3 ';
    2: isql := isql + ' AND  ng.N_STATUS = 4 ';
    3: isql := isql + ' AND  ng.N_STATUS = 5 ';
  end;

  with dmNegociacao do try
    fdqyRelatorio.SQL.Clear;
    fdqyRelatorio.sql.Add(isql);
    fdqyRelatorio.Open;
    if fdqyRelatorio.IsEmpty
      then ShowMessage('Nenhum registro encontrado');

  except

  end;


end;

procedure TfmPesquisaNegociacao.dlcProdutorCloseUp(Sender: TObject);
begin
  inherited;
  if dlcProdutor.Text <> '' then begin
      dmNegociacao.fdqyListaDistribuidor.Close;
      dmNegociacao.fdqyListaDistribuidor.Params.ParamByName('PRODUTOR_ID').AsInteger := dlcProdutor.KeyValue;
      dmNegociacao.fdqyListaDistribuidor.Open;
  end;

end;

procedure TfmPesquisaNegociacao.dlcProdutorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then dlcProdutor.KeyValue := 0;

end;

procedure TfmPesquisaNegociacao.bbVisualizarClick(Sender: TObject);
begin
  inherited;
  if not(dmNegociacao.fdqyRelatorio.IsEmpty) then
      dmNegociacao.ppReport.Print
      else ShowMessage('Nenhum registro encontrado');
end;

procedure TfmPesquisaNegociacao.dlcDistribuidorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then dlcDistribuidor.KeyValue := 0;
end;

procedure TfmPesquisaNegociacao.FormActivate(Sender: TObject);
begin
  inherited;
  dmNegociacao.fdqyListaProdutor.Close;
  dmNegociacao.fdqyListaProdutor.Open;
  mskDataInicial.SetFocus;

end;

end.
