unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  CadastroDistribuidor, CadastroProduto, CadastroProdutor, CadastroNegociacao,
  ManutencaoNegociacao, ConsultaNegociacao;

type
  TFPrincipal = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    btnCadNegociacao: TButton;
    btnCadProdutor: TButton;
    lblNegociacao: TLabel;
    lblProdutor: TLabel;
    btnCadDistribuidor: TButton;
    lblDistribuidor: TLabel;
    Label4: TLabel;
    btnCadProduto: TButton;
    btnManutencaoNeg: TButton;
    btnConsultaNeg: TButton;
    procedure btnCadProdutorClick(Sender: TObject);
    procedure btnCadDistribuidorClick(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
    procedure btnCadNegociacaoClick(Sender: TObject);
    procedure btnManutencaoNegClick(Sender: TObject);
    procedure btnConsultaNegClick(Sender: TObject);
  private
    { Private declarations }
    CadastroProdutor: TFCadastroProdutor;
    CadastroDistribuidor: TFCadastroDistribuidor;
    CadastroProduto: TFCadastroProduto;
    CadastroNegociacao: TFCadastroNegociacao;
    ManutencaoNegociacao: TFManutencaoNegociacao;
    ConsultaNegociacao: TFConsultaNegociacao;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.btnCadDistribuidorClick(Sender: TObject);
begin
  if not Assigned(CadastroDistribuidor) then
    CadastroDistribuidor := TFCadastroDistribuidor.Create(Application);

  CadastroDistribuidor.ShowModal;
end;

procedure TFPrincipal.btnCadNegociacaoClick(Sender: TObject);
begin
  if not Assigned(CadastroNegociacao) then
    CadastroNegociacao := TFCadastroNegociacao.Create(Application);

  CadastroNegociacao.ShowModal;
end;

procedure TFPrincipal.btnCadProdutoClick(Sender: TObject);
begin
  if not Assigned(CadastroProduto) then
    CadastroProduto := TFCadastroProduto.Create(Application);

  CadastroProduto.ShowModal;
end;

procedure TFPrincipal.btnCadProdutorClick(Sender: TObject);
begin
  if not Assigned(CadastroProdutor) then
    CadastroProdutor := TFCadastroProdutor.Create(Application);

  CadastroProdutor.ShowModal;
end;

procedure TFPrincipal.btnConsultaNegClick(Sender: TObject);
begin
  if not Assigned(ConsultaNegociacao) then
    ConsultaNegociacao := TFConsultaNegociacao.Create(Application);

  ConsultaNegociacao.ShowModal;
end;

procedure TFPrincipal.btnManutencaoNegClick(Sender: TObject);
begin
  if not Assigned(ManutencaoNegociacao) then
    ManutencaoNegociacao := TFManutencaoNegociacao.Create(Application);

  ManutencaoNegociacao.ShowModal;
end;

end.
