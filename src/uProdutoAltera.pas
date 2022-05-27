unit uProdutoAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmProdutoAltera = class(TForm)
    grdDistribuidor: TDBGrid;
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutoAltera: TfrmProdutoAltera;

implementation

{$R *.dfm}

uses uDM, uProdutoCadastro;

procedure TfrmProdutoAltera.btnAlterarClick(Sender: TObject);
begin
  DataModule1.qryProduto.Edit;

  frmProdutoCadastro.edtNome.Text := DataModule1.qryProduto.FieldByName('nome').AsString;
  frmProdutoCadastro.edtPreco.Text := DataModule1.qryProduto.FieldByName('valor').AsString;

  frmProdutoCadastro.ShowModal;
end;

procedure TfrmProdutoAltera.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutoAltera.FormShow(Sender: TObject);
begin
  if DataModule1.qryProduto.Active = False then
    DataModule1.qryProduto.Open;
end;

end.
