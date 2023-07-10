unit CadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, ProdutoController, Produto, System.Generics.Collections, Funcoes;

type
  TFCadastroProduto = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    lblNome: TLabel;
    lblPreco: TLabel;
    lbl_cod: TLabel;
    edtNome: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    StringGrid1: TStringGrid;
    edtCod: TEdit;
    btnExcluir: TButton;
    edtPreco: TEdit;
    procedure edtPrecoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    FController: TProdutoController;
    FID: integer;
    FisEditing: Boolean;
    procedure SetProduto(const ID: integer; const Nome: string; const Preco: Double);
    procedure LimpaCampos;
    procedure CarregaProdutos;
  public
    { Public declarations }
    procedure EditarProduto(const ID: integer; const Nome: string; const Preco: Double);
  end;

var
  FCadastroProduto: TFCadastroProduto;

implementation

{$R *.dfm}

procedure TFCadastroProduto.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TFCadastroProduto.btnExcluirClick(Sender: TObject);
begin
  if edtCod.Text <> '' then
  begin
    FController.Excluir(StrToInt(edtCod.Text));
    LimpaCampos;
    CarregaProdutos;
  end
  else
  begin
    ShowMessage('Selecione um distribuidor para exclui-lo!');
  end;
end;

procedure TFCadastroProduto.btnSalvarClick(Sender: TObject);
var
  ValorEdit: string;
  Preco: Double;
begin

  if Funcoes.ObterValorDecimal(edtPreco.Text) then
  begin
    ValorEdit := StringReplace(edtPreco.Text, '.', '', [rfReplaceAll]); // Remover pontos
    ValorEdit := Trim(ValorEdit); // Remover espaços em branco no início e no fim

    Preco := StrToFloat(ValorEdit);
  end
  else
    Preco := Funcoes.ObterValorInteiro(edtPreco.Text);

  if FisEditing then
     FController.Atualiza(FID, edtNome.Text, Preco)
  else
  begin
    if (edtNome.Text <> '') and (edtPreco.Text <> '') then
      FController.SalvarProduto(0, edtNome.Text, Preco)
    else
      ShowMessage('É necessário informar NOME e PREÇO para cadastrar novo PRODUTOR');
  end;
  LimpaCampos;
  CarregaProdutos;
end;

procedure TFCadastroProduto.CarregaProdutos;
var
  Produtos: TObjectList<TProduto>;
  Produto:   TProduto;
  Row: integer;
begin
  StringGrid1.RowCount := 1;
  Produtos := TObjectList<TProduto>.Create;
  Produtos := FController.MostrarTodos;
  StringGrid1.RowCount := Produtos.Count + 1;
  for Row := 0 to Produtos.Count - 1 do
  begin
    //nome das colunas
    StringGrid1.Cells[0, 0] := 'Cód';
    StringGrid1.Cells[1, 0] := 'Nome';
    StringGrid1.Cells[2, 0] := 'Preço';

    //largura das colunas
    StringGrid1.ColWidths[0] := 50;
    StringGrid1.ColWidths[1] := 300;
    StringGrid1.ColWidths[2] := 160;

    //dados das colunas
    Produto := TProduto.Create(Produtos[Row].ID, Produtos[Row].Nome, Produtos[Row].Preco);
    StringGrid1.Cells[0, Row + 1] := IntToStr(Produto.ID);
    StringGrid1.Cells[1, Row + 1] := Produto.Nome;
    StringGrid1.Cells[2, Row + 1] := FormatFloat('#,##0.00', Produto.Preco);
  end;
end;

procedure TFCadastroProduto.EditarProduto(const ID: integer; const Nome: string;
  const Preco: Double);
begin
  FisEditing := True;
  SetProduto(ID, Nome, Preco);
end;

procedure TFCadastroProduto.edtPrecoExit(Sender: TObject);
var
  Valor: Double;
begin
  if TryStrToFloat(edtPreco.Text, Valor) then
  begin
    edtPreco.Text := FormatFloat('#,##0.00', Valor);
  end;
end;

procedure TFCadastroProduto.FormCreate(Sender: TObject);
begin
  FController := TProdutoController.Create;
  FisEditing := False;
end;

procedure TFCadastroProduto.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TFCadastroProduto.FormShow(Sender: TObject);
begin
  CarregaProdutos;
end;

procedure TFCadastroProduto.LimpaCampos;
begin
  edtCod.Clear;
  edtNome.Clear;
  edtPreco.Clear;
end;

procedure TFCadastroProduto.SetProduto(const ID: integer; const Nome: string;
  const Preco: Double);
begin
  FID           := ID;
  edtCod.Text   := IntToStr(ID);
  edtNome.Text  := Nome;
  edtPreco.Text := FormatFloat('#,##0.00', Preco);
end;

procedure TFCadastroProduto.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  ID: Integer;
  Name, PrecoStr: string;
  Preco: Double;
begin
  if ARow > 0 then
  begin
    ID := StrToIntDef(StringGrid1.Cells[0, ARow], 0);
    Name := StringGrid1.Cells[1, ARow];
    if Funcoes.ObterValorDecimal(StringGrid1.Cells[2, ARow]) then
    begin
      PrecoStr := StringReplace(StringGrid1.Cells[2, ARow], '.', '', [rfReplaceAll]); // Remover pontos
      PrecoStr := Trim(PrecoStr); // Remover espaços em branco no início e no fim

      Preco := StrToFloat(PrecoStr);      
    end
    else
      Preco := Funcoes.ObterValorInteiro(StringGrid1.Cells[2, ARow]);
    
    
    EditarProduto(ID, Name, Preco);
  end;
end;

end.
