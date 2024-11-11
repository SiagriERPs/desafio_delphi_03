unit uFrmPesquisaProdutor;

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
  Data.DB,
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
  FireDAC.Comp.Client,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  uBiblioteca,
  uSistemaController;

type
  TFrmPesquisaProdutor = class(TFrmPesquisaBasico)
    dsPesquisaProdutor: TDataSource;
    qryPesquisaProdutor: TFDQuery;
    dbgProdutor: TDBGrid;
    qryPesquisaProdutorPRODUTOR_ID: TIntegerField;
    qryPesquisaProdutorNOME: TStringField;
    qryPesquisaProdutorCPF_CNPJ: TStringField;
    qryPesquisaProdutorLIMITE_CREDITO: TBCDField;
    rbNome: TRadioButton;
    rbCodigo: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgProdutorDblClick(Sender: TObject);
  private
  public
  protected
    procedure Pesquisa; override;
  end;

var
  FrmPesquisaProdutor: TFrmPesquisaProdutor;

implementation

{$R *.dfm}

{ TFrmPesquisaProdutor }

procedure TFrmPesquisaProdutor.dbgProdutorDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisaProdutor.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Pesquisa;
end;

procedure TFrmPesquisaProdutor.FormShow(Sender: TObject);
begin
  qryPesquisaProdutor.Close;
  qryPesquisaProdutor.Connection := TSistemaControl.GetInstance.GetConexao.GetConn;
end;

procedure TFrmPesquisaProdutor.Pesquisa;
begin
  qryPesquisaProdutor.SQL.Clear;
  qryPesquisaProdutor.SQL.Text :=
    'SELECT ' +
    '  produtor_id, ' +
    '  nome, ' +
    '  cpf_cnpj, ' +
    '  limite_credito ' +
    'FROM' +
    '  tab_produtor';

   if Length(edtNome.Text) > 0 then
   begin
     if rbNome.Checked then
     begin
       qryPesquisaProdutor.SQL.Text :=
       qryPesquisaProdutor.SQL.Text +
         ' WHERE ' +
         '  nome LIKE ' + QuotedStr('%' + Trim(edtNome.Text) + '%');
     end
     else if rbCodigo.Checked then
     begin
       qryPesquisaProdutor.SQL.Text :=
       qryPesquisaProdutor.SQL.Text +
         ' WHERE ' +
         '  produtor_id = ' + Trim(edtNome.Text);
     end;
   end;

   qryPesquisaProdutor.Open();

   if qryPesquisaProdutor.RecordCount = 0 then
   begin
     ShowMessage('Produtor não encontrado!');
     edtNome.SetFocus;
   end;
end;
end.
