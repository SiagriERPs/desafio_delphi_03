unit CadastroNovoProduto;

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
  Vcl.ExtCtrls,
  ProdutoController;

type
  TFCadastroNovoProduto = class(TForm)
    pnPrincipal: TPanel;
    lblNome: TLabel;
    lblPrecoVenda: TLabel;
    edtNome: TEdit;
    edtPrecoVenda: TEdit;
    btnSalvar: TBitBtn;
    btnLimpar: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    FProdutoController: TProdutoController;
    procedure Salvar;
    procedure Limpar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FCadastroNovoProduto: TFCadastroNovoProduto;

implementation

{$R *.dfm}

{ TForm1 }

procedure TFCadastroNovoProduto.btnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFCadastroNovoProduto.btnLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TFCadastroNovoProduto.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

constructor TFCadastroNovoProduto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProdutoController := TProdutoController.Create;
end;

destructor TFCadastroNovoProduto.Destroy;
begin
  FProdutoController.Free;
  inherited;
end;

procedure TFCadastroNovoProduto.Limpar;
begin
  edtNome.Clear;
  edtPrecoVenda.Clear;
end;

procedure TFCadastroNovoProduto.Salvar;
var
  Nome: string;
  PrecoVenda: currency;
begin
  Nome := edtNome.Text;
  PrecoVenda := StrToFloat(edtPrecoVenda.Text);

  try
    FProdutoController.InserirProduto(Nome, PrecoVenda);
    ShowMessage('Produto inserido com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao inserir produto: ' + E.Message);
  end;
end;

end.
