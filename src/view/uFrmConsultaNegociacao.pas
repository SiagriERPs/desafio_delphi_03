unit uFrmConsultaNegociacao;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  uSistemaController,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxSmartMemo, frxClass, frxDBSet, frCoreClasses;

type
  TProdutor = record
    Id: Integer;
    Nome: string;
  end;

  TDistribuidor = record
    Id: Integer;
    Nome: string;
  end;

  TFrmConsultaNegociacao = class(TFrmBasico)
    pnlFilter: TPanel;
    lblTitulo: TLabel;
    spbPesquisaProdutor: TSpeedButton;
    lblProdutor: TLabel;
    spbPesquisaDistribuidor: TSpeedButton;
    lblDistribuidor: TLabel;
    spbImprimir: TSpeedButton;
    spbPesquisar: TSpeedButton;
    spbLimparCampos: TSpeedButton;
    edtProdutor: TEdit;
    edtDistribuidor: TEdit;
    DBGrid1: TDBGrid;
    qryPesquisar: TFDQuery;
    dsPesquisar: TDataSource;
    qryPesquisarNEGOCIACAO_ID: TIntegerField;
    qryPesquisarDATA_CADASTRO: TSQLTimeStampField;
    qryPesquisarDATA_APROVACAO: TSQLTimeStampField;
    qryPesquisarDATA_CONCLUSAO: TSQLTimeStampField;
    qryPesquisarDATA_CANCELAMENTO: TSQLTimeStampField;
    qryPesquisarSTATUS: TStringField;
    qryPesquisarVALOR_TOTAL: TBCDField;
    qryPesquisarPRODUTOR: TStringField;
    qryPesquisarPRODUTOR_CPF_CNPJ: TStringField;
    qryPesquisarDISTRIBUIDOR: TStringField;
    qryPesquisarDISTRIBUIDOR_CNPJ: TStringField;
    frxReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    procedure FormShow(Sender: TObject);
    procedure spbLimparCamposClick(Sender: TObject);
    procedure spbPesquisaDistribuidorClick(Sender: TObject);
    procedure spbPesquisaProdutorClick(Sender: TObject);
    procedure spbImprimirClick(Sender: TObject);
    procedure spbPesquisarClick(Sender: TObject);
  private
    Produtor     : TProdutor;
    Distribuidor : TDistribuidor;

    procedure LimparCampos;
    procedure Pesquisar;
    procedure PesquisarProdutor;
    procedure PesquisarDistribuidor;

    function ValidarCampos: Boolean;
  public

  end;

var
  FrmConsultaNegociacao: TFrmConsultaNegociacao;

implementation

{$R *.dfm}

uses
  uFrmPesquisaDistribuidor,
  uFrmPesquisaProdutor,
  uFrmRelatorioNegociacao;

procedure TFrmConsultaNegociacao.FormShow(Sender: TObject);
begin
  qryPesquisar.Close;
  qryPesquisar.Connection := TSistemaControl.GetInstance.GetConexao.GetConn;

  spbImprimir.Enabled     := False;
end;

procedure TFrmConsultaNegociacao.LimparCampos;
begin
  edtProdutor.Clear;
  edtDistribuidor.Clear;
  edtProdutor.SetFocus;
end;

procedure TFrmConsultaNegociacao.Pesquisar;
begin
  if not ValidarCampos then
    Exit;

  if not TSistemaControl.GetInstance.GetConexao.GetConn.Connected then
  begin
    ShowMessage('Erro: Conexão com o banco de dados não está ativa.');
    Exit;
  end;

  qryPesquisar.SQL.Clear;
  qryPesquisar.SQL.Text :=
    'SELECT neg.negociacao_id ' +
    '     , neg.data_cadastro ' +
    '     , neg.data_aprovacao ' +
    '     , neg.data_conclusao ' +
    '     , neg.data_cancelamento ' +
    '     , neg.status ' +
    '     , neg.valor_total ' +
    '     , pro.nome produtor ' +
    '     , pro.cpf_cnpj produtor_cpf_cnpj ' +
    '     , dis.nome distribuidor ' +
    '     , dis.cnpj distribuidor_cnpj ' +

    '  FROM tab_negociacao neg ' +

    ' LEFT JOIN tab_produtor pro ' +
    ' ON neg.produtor_id = pro.produtor_id ' +

    ' LEFT JOIN tab_distribuidor dis ' +
    ' ON neg.distribuidor_id = dis.distribuidor_id ' +

    ' WHERE (neg.produtor_id = :produtor_id OR :produtor_id IS NULL)' +
    ' AND (neg.distribuidor_id = :distribuidor_id OR :distribuidor_id IS NULL)';

  if edtProdutor.Text <> '' then
    qryPesquisar.ParamByName('produtor_id').AsInteger := Produtor.Id
  else
    qryPesquisar.ParamByName('produtor_id').Clear;

  if edtDistribuidor.Text <> '' then
    qryPesquisar.ParamByName('distribuidor_id').AsInteger := Distribuidor.Id
  else
    qryPesquisar.ParamByName('distribuidor_id').Clear;

  qryPesquisar.Open();

  if qryPesquisar.RecordCount = 0 then
  begin
    ShowMessage('Nenhuma negociação encontrada!');
    edtProdutor.SetFocus;
  end;

  spbImprimir.Enabled := not qryPesquisar.IsEmpty;
end;

procedure TFrmConsultaNegociacao.PesquisarDistribuidor;
begin
  Application.CreateForm(TfrmPesquisaDistribuidor, FrmPesquisaDistribuidor);
  try
    FrmPesquisaDistribuidor.ShowModal;

    if FrmPesquisaDistribuidor.ModalResult = mrCancel then
    begin
      edtDistribuidor.Clear;
      Exit;
    end
    else if FrmPesquisaDistribuidor.ModalResult = mrOk then
    begin
      Distribuidor.Id         := FrmPesquisaDistribuidor.qryPesquisaDistribuidorDISTRIBUIDOR_ID.AsInteger;
      Distribuidor.Nome       := FrmPesquisaDistribuidor.qryPesquisaDistribuidorNOME.AsString;
      edtDistribuidor.Text    := IntToStr(Distribuidor.Id) + ' - ' + Distribuidor.Nome;
    end;

  finally
    FreeAndNil(FrmPesquisaDistribuidor);
  end;
end;

procedure TFrmConsultaNegociacao.PesquisarProdutor;
begin
  Application.CreateForm(TfrmPesquisaProdutor, FrmPesquisaProdutor);
  try
    FrmPesquisaProdutor.ShowModal;

    if FrmPesquisaProdutor.ModalResult = mrCancel then
    begin
      edtProdutor.Clear;
      Exit;
    end
    else if FrmPesquisaProdutor.ModalResult = mrOk then
    begin
      Produtor.Id         := FrmPesquisaProdutor.qryPesquisaProdutorPRODUTOR_ID.AsInteger;
      Produtor.Nome       := FrmPesquisaProdutor.qryPesquisaProdutorNOME.AsString;
      edtProdutor.Text    := IntToStr(Produtor.Id) + ' - ' + Produtor.Nome;
    end;

  finally
    FreeAndNil(FrmPesquisaProdutor);
  end;
end;

procedure TFrmConsultaNegociacao.spbImprimirClick(Sender: TObject);
begin
  frxReport.ShowReport();
end;

procedure TFrmConsultaNegociacao.spbLimparCamposClick(Sender: TObject);
begin
  LimparCampos;
  qryPesquisar.Close;
end;

procedure TFrmConsultaNegociacao.spbPesquisaDistribuidorClick(Sender: TObject);
begin
  PesquisarDistribuidor;
end;

procedure TFrmConsultaNegociacao.spbPesquisaProdutorClick(Sender: TObject);
begin
  PesquisarProdutor;
end;

procedure TFrmConsultaNegociacao.spbPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

function TFrmConsultaNegociacao.ValidarCampos: Boolean;
begin
  Result := False;

  if (Trim(edtProdutor.Text) = '') and (Trim(edtDistribuidor.Text) = '') then
  begin
    ShowMessage('Por favor, informe pelo menos um produtor ou distribuidor para realizar a pesquisa!');
    Exit;
  end;

  Result := True;
end;

end.
