unit uFrmPesquisaDistribuidor;

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
  TFrmPesquisaDistribuidor = class(TFrmPesquisaBasico)
    dbgDistribuidor: TDBGrid;
    qryPesquisaDistribuidor: TFDQuery;
    qryPesquisaDistribuidorDISTRIBUIDOR_ID: TIntegerField;
    qryPesquisaDistribuidorNOME: TStringField;
    qryPesquisaDistribuidorCNPJ: TStringField;
    dsPesquisaDistribuidor: TDataSource;
    rbNome: TRadioButton;
    rbCodigo: TRadioButton;
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDistribuidorDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  protected
    procedure Pesquisa; override;
  end;

var
  FrmPesquisaDistribuidor: TFrmPesquisaDistribuidor;

implementation

{$R *.dfm}

procedure TFrmPesquisaDistribuidor.dbgDistribuidorDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisaDistribuidor.edtNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    Pesquisa;
end;

procedure TFrmPesquisaDistribuidor.FormCreate(Sender: TObject);
begin
  qryPesquisaDistribuidor.Close;
  qryPesquisaDistribuidor.Connection := TSistemaControl.GetInstance.GetConexao.GetConn;
end;

procedure TFrmPesquisaDistribuidor.Pesquisa;
begin
  qryPesquisaDistribuidor.Close;
  qryPesquisaDistribuidor.SQL.Clear;
  qryPesquisaDistribuidor.SQL.Text :=
    'SELECT ' +
    '  distribuidor_id, ' +
    '  nome, ' +
    '  cnpj ' +
    'FROM' +
    '  tab_distribuidor';

   if Length(edtNome.Text) > 0 then
   begin
     if rbNome.Checked then
     begin
       qryPesquisaDistribuidor.SQL.Text :=
       qryPesquisaDistribuidor.SQL.Text +
         ' WHERE ' +
         '  nome LIKE ' + QuotedStr('%' + Trim(edtNome.Text) + '%');
     end
     else if rbCodigo.Checked then
     begin
       qryPesquisaDistribuidor.SQL.Text :=
       qryPesquisaDistribuidor.SQL.Text +
         ' WHERE ' +
         '  distribuidor_id = ' + Trim(edtNome.Text);
     end;
   end;

   qryPesquisaDistribuidor.Open();

   if qryPesquisaDistribuidor.RecordCount = 0 then
   begin
     ShowMessage('Distribuidor não encontrado!');
     edtNome.SetFocus;
   end;
end;

end.
