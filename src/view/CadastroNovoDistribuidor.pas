unit CadastroNovoDistribuidor;

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
  Vcl.ExtCtrls,
  Vcl.Buttons,
  uDistribuidor,
  DistribuidorController,
  DistribuidorDAO;

type
  TFCadastroNovoDistribuidor = class(TForm)
    pnPrincipal: TPanel;
    edtNome: TEdit;
    edtCNPJ: TEdit;
    lblNome: TLabel;
    lblCNPJ: TLabel;
    btnSalvar: TBitBtn;
    btnLimpar: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    FDistribuidorController: TDistribuidorController;
    procedure Salvar;
    procedure Limpar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FCadastroNovoDistribuidor: TFCadastroNovoDistribuidor;

implementation

{$R *.dfm}

procedure TFCadastroNovoDistribuidor.btnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFCadastroNovoDistribuidor.btnLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TFCadastroNovoDistribuidor.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

constructor TFCadastroNovoDistribuidor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDistribuidorController := TDistribuidorController.Create;

end;

destructor TFCadastroNovoDistribuidor.Destroy;
begin
  FDistribuidorController.Free;
  inherited;
end;

procedure TFCadastroNovoDistribuidor.Limpar;
begin
  edtNome.Clear;
  edtCNPJ.Clear;
end;

procedure TFCadastroNovoDistribuidor.Salvar;
var
  Nome, CNPJ: string;
begin
  Nome := EdtNome.Text;
  CNPJ := EdtCNPJ.Text;

  try
    FDistribuidorController.InserirDistribuidor(Nome, CNPJ);
    ShowMessage('Distribuidor inserido com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao inserir distribuidor: ' + E.Message);
  end;
end;

end.
