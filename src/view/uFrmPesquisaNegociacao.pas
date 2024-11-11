unit uFrmPesquisaNegociacao;

interface

uses
  uFrmPesquisaBasico,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
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
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  uSistemaController;

type
  TFrmPesquisaNegociacao = class(TFrmPesquisaBasico)
    dbgNegociacao: TDBGrid;
    qryPesquisaNegociacao: TFDQuery;
    dsPesquisaNegociacao: TDataSource;
    qryPesquisaNegociacaoNEGOCIACAO_ID: TIntegerField;
    qryPesquisaNegociacaoSTATUS: TStringField;
    qryPesquisaNegociacaoVALOR_TOTAL: TBCDField;
    qryPesquisaNegociacaoPRODUTOR_ID: TIntegerField;
    qryPesquisaNegociacaoPRODUTOR: TStringField;
    qryPesquisaNegociacaoDISTRIBUIDOR_ID: TIntegerField;
    qryPesquisaNegociacaoDISTRIBUIDOR: TStringField;
    rbCodigo: TRadioButton;
    procedure dbgNegociacaoDblClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    function ValidarCampos: Boolean;
  public

  protected
    procedure Pesquisa; override;
  end;

var
  FrmPesquisaNegociacao: TFrmPesquisaNegociacao;

implementation

{$R *.dfm}

{ TFrmPesquisaNegociacao }

procedure TFrmPesquisaNegociacao.dbgNegociacaoDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisaNegociacao.edtNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    Pesquisa;
end;

procedure TFrmPesquisaNegociacao.FormShow(Sender: TObject);
begin
  qryPesquisaNegociacao.Close;
  qryPesquisaNegociacao.Connection := TSistemaControl.GetInstance.GetConexao.GetConn;
end;

procedure TFrmPesquisaNegociacao.Pesquisa;
begin
  if not ValidarCampos then
    Exit;

  if not TSistemaControl.GetInstance.GetConexao.GetConn.Connected then
  begin
    ShowMessage('Erro: Conexão com o banco de dados não está ativa.');
    Exit;
  end;

  qryPesquisaNegociacao.SQL.Clear;
  qryPesquisaNegociacao.SQL.Text :=
    'SELECT neg.negociacao_id ' +
    '     , neg.status ' +
    '     , neg.valor_total ' +
    '     , neg.produtor_id ' +
    '     , pro.nome produtor ' +
    '     , neg.distribuidor_id ' +
    '     , dis.nome distribuidor ' +

    '  FROM tab_negociacao neg ' +

    ' LEFT JOIN tab_produtor pro ' +
    ' ON neg.produtor_id = pro.produtor_id ' +

    ' LEFT JOIN tab_distribuidor dis ' +
    ' ON neg.distribuidor_id = dis.distribuidor_id';

   if Length(edtNome.Text) > 0 then
   begin
     qryPesquisaNegociacao.SQL.Text :=
     qryPesquisaNegociacao.SQL.Text +
       ' WHERE ' +
       '  neg.negociacao_id = :negociacao_id';

     qryPesquisaNegociacao.ParamByName('negociacao_id').AsInteger := StrToInt(edtNome.Text);
   end;

   qryPesquisaNegociacao.Open();

   if qryPesquisaNegociacao.RecordCount = 0 then
   begin
     ShowMessage('Negociação não encontrada!');
     edtNome.SetFocus;
   end;
end;

function TFrmPesquisaNegociacao.ValidarCampos: Boolean;
begin
  Result := False;

  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Por favor, informe o código do contrato para realizar a pesquisa!');
    Exit;
  end;

  Result := True;
end;

end.
