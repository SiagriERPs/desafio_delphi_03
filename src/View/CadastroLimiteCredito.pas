unit CadastroLimiteCredito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Distribuidor,
  System.Generics.Collections, DistribuidorController, LimiteCreditoController,
  Funcoes;

type
  TFCadastroLimiteCredito = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    lblLimiteCredito: TLabel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    edtLimiteCredito: TEdit;
    cbxDistribuidor: TComboBox;
    Label1: TLabel;
    lblProdutor: TLabel;
    edtProdutor: TEdit;
    edtIdProdutor: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtLimiteCreditoExit(Sender: TObject);
    procedure cbxDistribuidorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    FNovoCadastro: boolean;
    FDistribuidorController: TDistribuidorController;
    FController: TLimiteCreditoController;
    procedure CarregaDistribuidores;
    procedure LimpaCampos;
    function BuscaLimite(const IdProduto, IdDistribuidor: integer): Double;
  public
    { Public declarations }
    procedure SetProdutor(const ID: integer; const Nome: string);
  end;

var
  FCadastroLimiteCredito: TFCadastroLimiteCredito;

implementation

{$R *.dfm}

{ TFCadastroLimiteCredito }

procedure TFCadastroLimiteCredito.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
  Close;
end;

procedure TFCadastroLimiteCredito.btnSalvarClick(Sender: TObject);
var
  ValorEdit: string;
  Limite: Double;
  Distribuidor: TDistribuidor;
begin
  if Funcoes.ObterValorDecimal(edtLimiteCredito.Text) then
  begin
    ValorEdit := StringReplace(edtLimiteCredito.Text, '.', '', [rfReplaceAll]); // Remover pontos
    ValorEdit := Trim(ValorEdit); // Remover espaços em branco no início e no fim

    Limite := StrToFloat(ValorEdit);
  end
  else
    Limite := Funcoes.ObterValorInteiro(edtLimiteCredito.Text);

  if cbxDistribuidor.ItemIndex > -1 then
  begin
    Distribuidor := TDistribuidor(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]);
    if not FNovoCadastro then
    begin
       FController.Atualiza(0,StrToInt(edtIdProdutor.Text), Distribuidor.ID, Limite);
       ShowMessage('Limite atualizado com sucesso!');
    end
    else
    begin
      FController.SalvarLimite(0,StrToInt(edtIdProdutor.Text), Distribuidor.ID, Limite);
      ShowMessage('Limite salvo com sucesso!');
    end;
  end;
end;

function TFCadastroLimiteCredito.BuscaLimite(const IdProduto,
  IdDistribuidor: integer): Double;
begin
  if FController.MostrarLimite(IdProduto, IdDistribuidor) <> 0 then
  begin
    Result := FController.MostrarLimite(IdProduto, IdDistribuidor);
    FNovoCadastro := False;
  end
  else
  begin
    FNovoCadastro := True;
    Result := 0;
  end;
end;

procedure TFCadastroLimiteCredito.CarregaDistribuidores;
var
  Distribuidores: TObjectList<TDistribuidor>;
  Distribuidor:   TDistribuidor;
begin
  cbxDistribuidor.Clear;

  Distribuidores := FDistribuidorController.MostrarTodos;
  for Distribuidor in Distribuidores do
  begin
    cbxDistribuidor.Items.AddObject(Distribuidor.Nome, TObject(Distribuidor));
  end;
end;

procedure TFCadastroLimiteCredito.cbxDistribuidorClick(Sender: TObject);
var
  Distribuidor: TDistribuidor;
  Valor: Double;
begin
  if cbxDistribuidor.ItemIndex > -1 then
  begin
    Distribuidor := TDistribuidor(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]);

    Valor := BuscaLimite(StrToInt(edtIdProdutor.Text), Distribuidor.ID);
    edtLimiteCredito.Text := FormatFloat('#,##0.00', Valor);
  end;
end;

procedure TFCadastroLimiteCredito.edtLimiteCreditoExit(Sender: TObject);
var
  Valor: Double;
begin
  if TryStrToFloat(edtLimiteCredito.Text, Valor) then
  begin
    edtLimiteCredito.Text := FormatFloat('#,##0.00', Valor);
  end;
end;

procedure TFCadastroLimiteCredito.FormCreate(Sender: TObject);
begin
  FDistribuidorController := TDistribuidorController.Create;
  FController             := TLimiteCreditoController.Create;
end;

procedure TFCadastroLimiteCredito.FormDestroy(Sender: TObject);
begin
  FDistribuidorController.Free;
  FController.Free;
end;

procedure TFCadastroLimiteCredito.FormShow(Sender: TObject);
begin
  CarregaDistribuidores;
end;

procedure TFCadastroLimiteCredito.LimpaCampos;
begin
  edtIdProdutor.Clear;
  edtProdutor.Clear;
  cbxDistribuidor.Clear;
  edtLimiteCredito.Clear;
end;

procedure TFCadastroLimiteCredito.SetProdutor(const ID: integer; const Nome: string);
begin
  edtIdProdutor.Text := IntToStr(ID);
  edtProdutor.Text   := Nome;
end;

end.
