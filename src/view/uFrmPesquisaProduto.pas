unit uFrmPesquisaProduto;

interface

uses
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
  uSistemaController,
  uFrmPesquisaBasico;

type
  TFrmPesquisaProduto = class(TFrmPesquisaBasico)
    dbgProduto: TDBGrid;
    qryPesquisaProduto: TFDQuery;
    dsPesquisaProduto: TDataSource;
    qryPesquisaProdutoPRODUTO_ID: TIntegerField;
    qryPesquisaProdutoNOME: TStringField;
    qryPesquisaProdutoPRECO_VENDA: TBCDField;
    rbNome: TRadioButton;
    rbCodigo: TRadioButton;
    procedure dbgProdutoDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
  private
  public
  protected
    procedure Pesquisa; override;
  end;

var
  FrmPesquisaProduto: TFrmPesquisaProduto;

implementation

{$R *.dfm}

procedure TFrmPesquisaProduto.dbgProdutoDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisaProduto.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Pesquisa;
end;

procedure TFrmPesquisaProduto.FormShow(Sender: TObject);
begin
  qryPesquisaProduto.Close;
  qryPesquisaProduto.Connection := TSistemaControl.GetInstance.GetConexao.GetConn;
end;

procedure TFrmPesquisaProduto.Pesquisa;
begin
  qryPesquisaProduto.SQL.Clear;
  qryPesquisaProduto.SQL.Text :=
    'SELECT ' +
    '  produto_id, ' +
    '  nome, ' +
    '  preco_venda ' +
    'FROM' +
    '  tab_produto';

   if Length(edtNome.Text) > 0 then
   begin
     if rbNome.Checked then
     begin
       qryPesquisaProduto.SQL.Text :=
       qryPesquisaProduto.SQL.Text +
         ' WHERE ' +
         '  nome LIKE ' + QuotedStr('%' + Trim(edtNome.Text) + '%');
     end
     else if rbCodigo.Checked then
     begin
       qryPesquisaProduto.SQL.Text :=
       qryPesquisaProduto.SQL.Text +
         ' WHERE ' +
         '  produto_id = ' + Trim(edtNome.Text);
     end;

   end;

   qryPesquisaProduto.Open();

   if qryPesquisaProduto.RecordCount = 0 then
   begin
     ShowMessage('Produto não encontrado!');
     edtNome.SetFocus;
   end;
end;

end.
