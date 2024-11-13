unit uFrmManutencaoNegociacao;

interface

uses
  uFrmBasico,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  uEnumerado,
  uStatusController,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uSistemaController;

type
  TFrmManutencaoNegociacao = class(TFrmBasico)
    pnPrincipal: TPanel;
    lblId: TLabel;
    lblTitulo: TLabel;
    spbPesquisar: TSpeedButton;
    edtNegociacaoId: TEdit;
    Panel2: TPanel;
    spbConcluir: TSpeedButton;
    spbAprovar: TSpeedButton;
    spbCancelar: TSpeedButton;
    spbSair: TSpeedButton;
    dbgNegociacao: TDBGrid;
    qryPesquisaNegociacao: TFDQuery;
    dsPesquisaNegociacao: TDataSource;
    qryPesquisaNegociacaoNEGOCIACAO_ID: TIntegerField;
    qryPesquisaNegociacaoPRODUTOR_ID: TIntegerField;
    qryPesquisaNegociacaoDISTRIBUIDOR_ID: TIntegerField;
    qryPesquisaNegociacaoDATA_CADASTRO: TSQLTimeStampField;
    qryPesquisaNegociacaoSTATUS: TStringField;
    qryPesquisaNegociacaoVALOR_TOTAL: TBCDField;
    qryPesquisaNegociacaoDATA_APROVACAO: TSQLTimeStampField;
    qryPesquisaNegociacaoDATA_CONCLUSAO: TSQLTimeStampField;
    qryPesquisaNegociacaoDATA_CANCELAMENTO: TSQLTimeStampField;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spbAprovarClick(Sender: TObject);
    procedure spbCancelarClick(Sender: TObject);
    procedure spbConcluirClick(Sender: TObject);
    procedure spbPesquisarClick(Sender: TObject);
    procedure spbSairClick(Sender: TObject);
  private
    FStatusController : TStatusController;
    FNegociacaoId     : Integer;

    procedure AtualizaStatusNegociacao(pStatus: TStatus);
    procedure Pesquisar;

    function ValidarCampos: Boolean;
  end;

var
  FrmManutencaoNegociacao: TFrmManutencaoNegociacao;

implementation

{$R *.dfm}

procedure TFrmManutencaoNegociacao.AtualizaStatusNegociacao(pStatus: TStatus);
begin
  if not ValidarCampos then
    Exit;

  FNegociacaoId := StrToInt(edtNegociacaoId.Text);

  if pStatus = Aprovada then
  begin
    if FStatusController.AprovarNegociacao(FNegociacaoId) then
    begin
      ShowMessage('Negociação aprovada com sucesso.');
      qryPesquisaNegociacao.Close;
      edtNegociacaoId.SetFocus;
    end;
  end
  else if pStatus = Concluida then
  begin
    if FStatusController.ConcluirNegociacao(FNegociacaoId) then
    begin
      ShowMessage('Negociação concluída com sucesso.');
      qryPesquisaNegociacao.Close;
      edtNegociacaoId.SetFocus;
    end;
  end
  else if pStatus = Cancelada then
  begin
    if FStatusController.CancelarNegociacao(FNegociacaoID) then
    begin
      ShowMessage('Negociação cancelada com sucesso.');
      qryPesquisaNegociacao.Close;
      edtNegociacaoId.SetFocus;
    end;
  end;
end;

procedure TFrmManutencaoNegociacao.FormDestroy(Sender: TObject);
begin
  FStatusController.Free;
  qryPesquisaNegociacao.Close;
end;

procedure TFrmManutencaoNegociacao.FormShow(Sender: TObject);
begin
  FStatusController := TStatusController.Create;
  qryPesquisaNegociacao.Close;
  qryPesquisaNegociacao.Connection := TSistemaControl.GetInstance.GetConexao.GetConn;
end;

procedure TFrmManutencaoNegociacao.Pesquisar;
begin
  if not ValidarCampos then
    Exit;

  qryPesquisaNegociacao.Close;
  qryPesquisaNegociacao.SQL.Clear;
  qryPesquisaNegociacao.SQL.Text :=
    'SELECT tn.negociacao_id ' +
    '     , tn.produtor_id ' +
    '     , tn.distribuidor_id ' +
    '     , tn.data_cadastro ' +
    '     , tn.status ' +
    '     , tn.valor_total ' +
    '     , tn.data_aprovacao ' +
    '     , tn.data_conclusao ' +
    '     , tn.data_cancelamento ' +
    '  FROM tab_negociacao tn' +

    ' WHERE tn.status        = ''Pendente''' +
    '   AND tn.negociacao_id = :negociacao_id';

   if Length(edtNegociacaoId.Text) > 0 then
     qryPesquisaNegociacao.ParamByName('negociacao_id').AsInteger := StrToInt(edtNegociacaoId.Text)
   else
     qryPesquisaNegociacao.ParamByName('negociacao_id').Clear;

   qryPesquisaNegociacao.Open();

   if qryPesquisaNegociacao.RecordCount = 0 then
   begin
     ShowMessage('Negociação não encontrada!');
     edtNegociacaoId.SetFocus;
   end;
end;

procedure TFrmManutencaoNegociacao.spbAprovarClick(Sender: TObject);
begin
  AtualizaStatusNegociacao(Aprovada);
end;

procedure TFrmManutencaoNegociacao.spbCancelarClick(Sender: TObject);
begin
  AtualizaStatusNegociacao(Cancelada);
end;

procedure TFrmManutencaoNegociacao.spbConcluirClick(Sender: TObject);
begin
  AtualizaStatusNegociacao(Concluida);
end;

procedure TFrmManutencaoNegociacao.spbPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TFrmManutencaoNegociacao.spbSairClick(Sender: TObject);
begin
  Close;
end;

function TFrmManutencaoNegociacao.ValidarCampos: Boolean;
begin
  Result := False;

  if Length(edtNegociacaoId.Text) = 0 then
  begin
    ShowMessage('Informe o código da negociação para continuar!');
    Exit;
  end;

  Result := True;
end;

end.
