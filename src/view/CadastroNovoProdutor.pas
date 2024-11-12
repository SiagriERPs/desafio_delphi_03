unit CadastroNovoProdutor;

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
  ProdutorController;

type
  TFCadastroNovoProdutor = class(TForm)
    pnPrincipal: TPanel;
    lblNome: TLabel;
    lblCNPJ: TLabel;
    edtNome: TEdit;
    edtCNPJ: TEdit;
    btnSalvar: TBitBtn;
    btnLimpar: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    FProdutorController: TProdutorController;
    procedure Salvar;
    procedure Limpar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FCadastroNovoProdutor: TFCadastroNovoProdutor;

implementation

{$R *.dfm}

procedure TFCadastroNovoProdutor.btnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFCadastroNovoProdutor.btnLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TFCadastroNovoProdutor.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

constructor TFCadastroNovoProdutor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProdutorController := TProdutorController.Create;
end;

destructor TFCadastroNovoProdutor.Destroy;
begin
  FProdutorController.Free;
  inherited;
end;

procedure TFCadastroNovoProdutor.Limpar;
begin
  edtNome.Clear;
  edtCNPJ.Clear;
end;

procedure TFCadastroNovoProdutor.Salvar;
var
  Nome, CNPJ: string;
begin
  Nome := EdtNome.Text;
  CNPJ := EdtCNPJ.Text;

  try
    FProdutorController.InserirProdutor(Nome, CNPJ);
    ShowMessage('Produtor inserido com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao inserir produtor: ' + E.Message);
  end;
end;

end.
