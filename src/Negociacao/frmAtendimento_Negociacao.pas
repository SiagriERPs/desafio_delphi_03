unit frmAtendimento_Negociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Fmbasico3C, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TfmAtendimento_Negociacao = class(TFrmbasico3C)
    Panel1: TPanel;
    edNegociacao_ID: TEdit;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    rgTipoNegociacao: TRadioGroup;
    SpeedButton2: TSpeedButton;
    dbgAtendimentoNegociacao: TDBGrid;
    PopupMenu: TPopupMenu;
    Aprovar1: TMenuItem;
    Aprovar2: TMenuItem;
    Cancelar1: TMenuItem;
    dsPesquisa: TDataSource;
    Label3: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Aprovar1Click(Sender: TObject);
    procedure Aprovar2Click(Sender: TObject);
    procedure Cancelar1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAtendimento_Negociacao: TfmAtendimento_Negociacao;

implementation

uses UdmConexao, UdmFuncoes, UdmNegociacao;

{$R *.dfm}

procedure TfmAtendimento_Negociacao.Aprovar1Click(Sender: TObject);
begin
  inherited;
  if dbgAtendimentoNegociacao.datasource.DataSet.FieldByName('N_STATUS')
    .AsInteger = 2 then
  begin
    dmNegociacao.AtualizaStatusNegociacao
      (dbgAtendimentoNegociacao.datasource.DataSet.FieldByName('Negociacao_ID')
      .AsInteger, 3, 2);
    dmNegociacao.AtualizaValor(dbgAtendimentoNegociacao.datasource.DataSet.
      FieldByName('Negociacao_ID').AsInteger,
      dbgAtendimentoNegociacao.datasource.DataSet.FieldByName
      ('N_VALORTOTAL').AsFloat);
    dbgAtendimentoNegociacao.datasource.DataSet.Refresh;
  end
  else
  begin
    Beep;
    ShowMessage('Atenção! Negociação não está no status PENDENTE');
    Exit;
  end;

end;

procedure TfmAtendimento_Negociacao.Aprovar2Click(Sender: TObject);
begin
  inherited;
  if dbgAtendimentoNegociacao.datasource.DataSet.FieldByName('N_STATUS')
    .AsInteger = 3 then
  begin
    dmNegociacao.AtualizaStatusNegociacao
      (dbgAtendimentoNegociacao.datasource.DataSet.FieldByName('Negociacao_ID')
      .AsInteger, 4, 3);
    dbgAtendimentoNegociacao.datasource.DataSet.Refresh;
  end

  else
  begin
    Beep;
    ShowMessage('Atenção! Negociação não está no status APROVADA');
    Exit;
  end;
end;

procedure TfmAtendimento_Negociacao.Cancelar1Click(Sender: TObject);
begin
  inherited;
  if (dbgAtendimentoNegociacao.datasource.DataSet.FieldByName('N_STATUS')
    .AsInteger = 2) or (dbgAtendimentoNegociacao.datasource.DataSet.FieldByName
    ('N_STATUS').AsInteger = 3) then
  begin
    dmNegociacao.AtualizaStatusNegociacao
      (dbgAtendimentoNegociacao.datasource.DataSet.FieldByName('Negociacao_ID')
      .AsInteger, 5, dbgAtendimentoNegociacao.datasource.DataSet.FieldByName
      ('N_STATUS').AsInteger);
    dbgAtendimentoNegociacao.datasource.DataSet.Refresh;
  end

  else
  begin
    Beep;
    ShowMessage('Atenção! Negociação não está no status PENDENTE/APROVADA');
    Exit;
  end;
end;

procedure TfmAtendimento_Negociacao.SpeedButton1Click(Sender: TObject);
const
  isql = ' SELECT ' + '     (CASE WHEN n.N_STATUS = 2 THEN ''PENDENTE'' ' +
    '           WHEN n.N_STATUS = 3 THEN ''APROVADA''  ' +
    '           WHEN n.N_STATUS = 4 THEN ''CONCLUÍDA'' ' +
    '           WHEN n.N_STATUS = 5 THEN ''CANCELADA'' ' +
    '      END) AS Status, ' + '     n.NEGOCIACAO_ID, ' +
    '     n.PRODUTOR_ID,   ' + '     p.P_NOME,    ' + '     n.DISTRIBUIDOR_ID, '
    + '     d.D_NOME, ' + '     n.N_VALORTOTAL, ' + '     n.N_STATUS  ' +
    ' FROM NEGOCIACAO n INNER JOIN PRODUTOR p ON (p.PRODUTOR_ID = n.PRODUTOR_ID) '
    + '                   INNER JOIN DISTRIBUIDOR d ON (d.DISTRIBUIDOR_ID = n.DISTRIBUIDOR_ID) '
    + ' WHERE n.NEGOCIACAO_ID = ';
var
  sql: String;
begin
  inherited;

  sql := isql;
  with dmNegociacao do
    try
      if (edNegociacao_ID.Text <> '') and (StrtoInt(edNegociacao_ID.Text) > 0)
      then
      begin
        sql := isql + edNegociacao_ID.Text;
        dmFuncoes.fdqyPesquisa.sql.Add(sql);
        dmFuncoes.fdqyPesquisa.Open;
      end
      else
        Exit;
    except

    end;
end;

procedure TfmAtendimento_Negociacao.SpeedButton2Click(Sender: TObject);
const
  isql = ' SELECT ' + '     (CASE WHEN n.N_STATUS = 2 THEN ''PENDENTE'' ' +
    '           WHEN n.N_STATUS = 3 THEN ''APROVADA''  ' +
    '           WHEN n.N_STATUS = 4 THEN ''CONCLUÍDA'' ' +
    '           WHEN n.N_STATUS = 5 THEN ''CANCELADA'' ' +
    '      END) AS Status, ' + '     n.NEGOCIACAO_ID, ' +
    '     n.PRODUTOR_ID,   ' + '     p.P_NOME,    ' + '     n.DISTRIBUIDOR_ID, '
    + '     d.D_NOME, ' + '     n.N_VALORTOTAL, ' + '     n.N_STATUS  ' +
    ' FROM NEGOCIACAO n INNER JOIN PRODUTOR p ON (p.PRODUTOR_ID = n.PRODUTOR_ID) '
    + '                   INNER JOIN DISTRIBUIDOR d ON (d.DISTRIBUIDOR_ID = n.DISTRIBUIDOR_ID) '
    + ' WHERE n.N_STATUS = ';
var
  situacao: integer;
  sql: string;
begin
  inherited;
  sql := isql;
  case rgTipoNegociacao.ItemIndex of
    0:
      situacao := 2;
    1:
      situacao := 3;
    2:
      situacao := 4;
    3:
      situacao := 5;
  end;

  with dmNegociacao do
    try
      sql := isql + InttoStr(situacao);
      dmFuncoes.fdqyPesquisa.sql.Add(sql);
      dmFuncoes.fdqyPesquisa.Open;
      if dmFuncoes.fdqyPesquisa.IsEmpty then
        ShowMessage('Nenhum registro foi encontrado');

    except

    end;
end;

end.
