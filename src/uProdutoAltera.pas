unit uProdutoAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmProdutoAltera = class(TForm)
    grdDistribuidor: TDBGrid;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
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
var
  lfrmProdutoCadastro: TfrmProdutoCadastro;
begin
  lfrmProdutoCadastro := TfrmProdutoCadastro.Create(Application);

  try
    lfrmProdutoCadastro.Codigo := DM.qryProduto.FieldByName('Codigo').AsInteger;
    lfrmProdutoCadastro.Nome := DM.qryProduto.FieldByName('nome').AsString;
    lfrmProdutoCadastro.Preco := DM.qryProduto.FieldByName('valor').AsString;
    lfrmProdutoCadastro.ShowModal;
    DM.qryProduto.DisableControls;
  finally
    FreeAndNil(lfrmProdutoCadastro);
    DM.qryProduto.Close;
    DM.qryProduto.Open;
    DM.qryProduto.EnableControls;
  end;
end;

procedure TfrmProdutoAltera.btnFecharClick(Sender: TObject);
begin
  DM.qryProduto.Close;
  Close;
end;

procedure TfrmProdutoAltera.FormShow(Sender: TObject);
begin
  DM.qryProduto.Open;
end;

end.
