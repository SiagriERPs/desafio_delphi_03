unit Principal;

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
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFPrincipal = class(TForm)
    pnPrincipal: TPanel;
    lblTitulo: TLabel;
    btnDistribuidor: TBitBtn;
    btnProduto: TBitBtn;
    btnProdutor: TBitBtn;
    btnNegociacao: TBitBtn;
    procedure btnProdutorClick(Sender: TObject);
    procedure btnDistribuidorClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses CadastroProdutor,
     CadastroDistribuidor,
     CadastroNovoProduto;

procedure TFPrincipal.btnDistribuidorClick(Sender: TObject);
begin
  Application.CreateForm(TFCadastroDistribuidor, FCadastroDistribuidor);
  FCadastroDistribuidor.ShowModal;
end;

procedure TFPrincipal.btnProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TFCadastroNovoProduto, FCadastroNovoProduto);
  FCadastroNovoProduto.ShowModal;
end;

procedure TFPrincipal.btnProdutorClick(Sender: TObject);
begin
  Application.CreateForm(TFCadastroProdutor, FCadastroProdutor);
  FCadastroProdutor.ShowModal;
end;

end.
