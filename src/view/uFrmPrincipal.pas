unit uFrmPrincipal;

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
  Vcl.Menus,
  Vcl.Imaging.pngimage,
  dxGDIPlusClasses,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    lblCadastro: TLabel;
    imgCadDistribuidor: TImage;
    imgCadProdutos: TImage;
    imgCadProdutor: TImage;
    imgNegociacao: TImage;
    imgConsultaNegociacao: TImage;
    mmPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Distribuidor1: TMenuItem;
    Produto1: TMenuItem;
    Produtor1: TMenuItem;
    Negociao1: TMenuItem;
    Negociacao1: TMenuItem;
    Consulta1: TMenuItem;
    procedure Distribuidor1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Produtor1Click(Sender: TObject);
    procedure Negociacao1Click(Sender: TObject);
    procedure Consulta1Click(Sender: TObject);
  private
  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  uBiblioteca,
  uFrmCadProduto,
  uFrmCadProdutor,
  uFrmCadDistribuidor,
  uFrmCadNegociacao,
  uFrmConsultaNegociacao;


procedure TFrmPrincipal.Consulta1Click(Sender: TObject);
begin
  CreateForm(TFrmConsultaNegociacao, FrmConsultaNegociacao);
end;

procedure TFrmPrincipal.Distribuidor1Click(Sender: TObject);
begin
  CreateForm(TFrmCadDistribuidor, frmCadDistribuidor);
end;

procedure TFrmPrincipal.Negociacao1Click(Sender: TObject);
begin
  CreateForm(TFrmCadNegociacao, frmCadNegociacao);
end;

procedure TFrmPrincipal.Produto1Click(Sender: TObject);
begin
  CreateForm(TFrmCadProduto, FrmCadProduto);
end;

procedure TFrmPrincipal.Produtor1Click(Sender: TObject);
begin
  CreateForm(TFrmCadProdutor, FrmCadProdutor);
end;

end.
