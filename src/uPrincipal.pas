unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, dxGDIPlusClasses,
  Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Negociaes1: TMenuItem;
    ProdutoresRurais1: TMenuItem;
    Distribuidores1: TMenuItem;
    N1: TMenuItem;
    Produtos1: TMenuItem;
    Cadastro1: TMenuItem;
    Image1: TImage;
    Gestor1: TMenuItem;
    N2: TMenuItem;
    procedure ProdutoresRurais1Click(Sender: TObject);
    procedure Distribuidores1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Cadastro1Click(Sender: TObject);
    procedure Gestor1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}


uses GETFuncoes, uCadastroProdutores, uCadastroDistribuidores,
  uCadastroProdutos, uCadastroNegociacoes, uGestorNegociacoes;

procedure TfrmPrincipal.Cadastro1Click(Sender: TObject);
begin
  AbreForm(TfrmCadNegociacoes, False, False, frmCadNegociacoes);
end;

procedure TfrmPrincipal.Distribuidores1Click(Sender: TObject);
begin
  AbreForm(TfrmCadDistribuidores, False, False, frmCadDistribuidores);
end;

procedure TfrmPrincipal.Gestor1Click(Sender: TObject);
begin
  AbreForm(TfrmGestorNegociacoes, False, True, frmGestorNegociacoes);
end;

procedure TfrmPrincipal.ProdutoresRurais1Click(Sender: TObject);
begin
  AbreForm(TfrmCadProdutores, False, False, frmCadProdutores);
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  AbreForm(TfrmCadProdutos, False, False, frmCadProdutos);
end;

end.
