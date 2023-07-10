unit CadastroNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.ComCtrls, NegociacaoController, Negociacao, DistribuidorController,
  ProdutoController, ProdutorController, Distribuidor, Produto, Produtor,
  NegociacaoItens, NegociacaoItensController, Funcoes, LimiteCreditoController;

type
  TFCadastroNegociacao = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    lblTotal: TLabel;
    lblQtd: TLabel;
    edtPreco: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    StringGrid1: TStringGrid;
    edtQtd: TEdit;
    btnExcluir: TButton;
    edtTotal: TEdit;
    cbxProdutor: TComboBox;
    lblProdutor: TLabel;
    lblDistribuidor: TLabel;
    cbxDistribuidor: TComboBox;
    lblProduto: TLabel;
    cbxProduto: TComboBox;
    lblPreco: TLabel;
    btnAdd: TButton;
    btnRemover: TButton;
    GroupBox1: TGroupBox;
    lblNegociacao: TLabel;
    cbxNegociacao: TComboBox;
    btnNovo: TButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure cbxProdutoClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure cbxNegociacaoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    FController: TNegociacaoController;
    FProdutoController: TProdutoController;
    FProdutorController: TProdutorController;
    FDistribuidorController: TDistribuidorController;
    FNegociacaoItensController: TNegociacaoItensController;
    FLimiteCreditoController: TLimiteCreditoController;
    FID: integer;
    FisEditing: Boolean;
    procedure SetNegociacao(const ID, IdProdutor, IdDistribuidor, IdStatus: integer; const Valortotal: Double);
    procedure LimpaCampos;
    procedure HabilitaCampos;
    procedure DesabilitaCampos;
    procedure CarregaNegociacao;
    procedure AdicionarCampos(const ID: integer; const Nome: string; const Quantidade, Valor: Double);
    procedure RemoverCampos(const Index: integer);
    procedure LimparGrid(StringGrid: TStringGrid);
  public
    { Public declarations }
    ValorTotal: Double;
  end;

var
  FCadastroNegociacao: TFCadastroNegociacao;

implementation

uses
  System.Generics.Collections;

{$R *.dfm}

{ TFCadastroNegociacao }

{ TFCadastroNegociacao }

procedure TFCadastroNegociacao.AdicionarCampos(const ID: integer;
  const Nome: string; const Quantidade, Valor: Double);
var
  NextRow: Integer;
begin
  NextRow := StringGrid1.RowCount;

  StringGrid1.RowCount := NextRow + 1;

  StringGrid1.Cells[0, NextRow] := IntToStr(ID);
  StringGrid1.Cells[1, NextRow] := Nome;
  StringGrid1.Cells[2, NextRow] := FloatToStr(Quantidade);
  StringGrid1.Cells[3, NextRow] := FormatFloat('#,##0.00', Valor);

  ValorTotal := ValorTotal + (Valor * Quantidade);
  edtTotal.Text := FormatFloat('#,##0.00', ValorTotal); 
end;

procedure TFCadastroNegociacao.btnAddClick(Sender: TObject);
var
  Produto : TProduto;
  ValorEdit: string;
  Preco: Double;
begin
  if (cbxProdutor.ItemIndex = -1) or (cbxDistribuidor.ItemIndex = -1) or
     (cbxProduto.ItemIndex = -1) or (edtQtd.Text = '') then
  begin
     ShowMessage('DEVEM ser informados os seguintes campos: PRODUTOR, DISTRIBUIDOR, PRODUTO e QUANTIDADE.');
     Abort;
  end;

  if Funcoes.ObterValorDecimal(edtPreco.Text) then
  begin
    ValorEdit := StringReplace(edtPreco.Text, '.', '', [rfReplaceAll]);
    ValorEdit := Trim(ValorEdit);

    Preco := StrToFloat(ValorEdit);
  end
  else
    Preco := Funcoes.ObterValorInteiro(edtPreco.Text);

  Produto := TProduto(cbxProduto.Items.Objects[cbxProduto.ItemIndex]);
  AdicionarCampos(Produto.ID, Produto.Nome, StrToFloat(edtQtd.Text), Preco);
  edtQtd.Clear;
  cbxProduto.ItemIndex := -1;
  edtPreco.Clear;
end;

procedure TFCadastroNegociacao.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
  Close;
end;

procedure TFCadastroNegociacao.btnExcluirClick(Sender: TObject);
var
  Negociacao: TNegociacao;
begin
  if cbxNegociacao.ItemIndex > -1 then
  begin
    Negociacao    := TNegociacao(cbxNegociacao.Items.Objects[cbxNegociacao.ItemIndex]);
    FController.Excluir(Negociacao.ID);
    FNegociacaoItensController.Excluir(Negociacao.ID);
    ShowMessage('Negociação excluída com sucesso!');
    LimpaCampos;
    LimparGrid(StringGrid1);
    cbxNegociacao.ItemIndex := -1;
    CarregaNegociacao;
  end;
end;

procedure TFCadastroNegociacao.btnNovoClick(Sender: TObject);
var
  Produtores: TObjectList<TProdutor>;
  Produtor:   TProdutor;
  Distribuidores: TObjectList<TDistribuidor>;
  Distribuidor:   TDistribuidor;
  Produtos: TObjectList<TProduto>;
  Produto:   TProduto;
begin
  if cbxNegociacao.ItemIndex <> -1 then
    Abort;

  cbxProdutor.Clear;
  cbxDistribuidor.Clear;
  cbxProduto.Clear;

  Produtores := FProdutorController.MostrarTodos;
  for Produtor in Produtores do
  begin
    cbxProdutor.Items.AddObject(Produtor.Nome, TObject(Produtor));
  end;

  Distribuidores := FDistribuidorController.MostrarTodos;
  for Distribuidor in Distribuidores do
  begin
    cbxDistribuidor.Items.AddObject(Distribuidor.Nome, TObject(Distribuidor));
  end;

  Produtos := FProdutoController.MostrarTodos;
  for Produto in Produtos do
  begin
    cbxProduto.Items.AddObject(Produto.Nome, TObject(Produto));
  end;

  HabilitaCampos;
end;

procedure TFCadastroNegociacao.btnRemoverClick(Sender: TObject);
var
  Linha: Integer;
begin
  Linha := StringGrid1.Row;
  if (Linha > 0) and (Linha < StringGrid1.RowCount) then
     RemoverCampos(Linha);
end;

procedure TFCadastroNegociacao.btnSalvarClick(Sender: TObject);
var
  ValorEdit: string;
  Preco, LimiteCredito, ValorAtualComprado: Double;
  Produtor: TProdutor;
  Distribuidor: TDistribuidor;
  Row, Col, IdNegociacao: Integer;
begin
  if (cbxProdutor.ItemIndex = -1) or (cbxDistribuidor.ItemIndex = -1) or (edtTotal.Text = '') then
  begin
     ShowMessage('DEVEM ser informados os seguintes campos: PRODUTOR, DISTRIBUIDOR e Adicionado Produtos a negocicação.');
     Abort;
  end;

  if Funcoes.ObterValorDecimal(edtTotal.Text) then
  begin
    ValorEdit := StringReplace(edtTotal.Text, '.', '', [rfReplaceAll]); // Remover pontos
    ValorEdit := Trim(ValorEdit); // Remover espaços em branco no início e no fim

    Preco := StrToFloat(ValorEdit);
  end
  else
    Preco := Funcoes.ObterValorInteiro(edtTotal.Text);

  Produtor := TProdutor(cbxProdutor.Items.Objects[cbxProdutor.ItemIndex]);
  Distribuidor := TDistribuidor(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]);

  LimiteCredito := FLimiteCreditoController.MostrarLimite(Produtor.ID, Distribuidor.ID);

  if not (LimiteCredito > 0) then
  begin
    ShowMessage('O Produtor selecionado não tem limite de crédito com distribuidor selecionado.');
    Abort;
  end;

  ValorAtualComprado := FController.BuscarValorNegPorProdutor(Produtor.ID);

  if (Preco + ValorAtualComprado) > LimiteCredito then
  begin
    ShowMessage('O valor total da negociação somado ao valor acumulado de negociações aprovadas é maior que o limite de crédito do produtor com o distribuidor.');
    Abort;
  end;

  if Preco > LimiteCredito then
  begin
    ShowMessage('O valor total da negociação é maior que o limite de crédito do produtor com o distribuidor.');
    Abort;
  end;

  IdNegociacao := FController.Salvar(0, Produtor.ID, Distribuidor.ID, 1, Preco);

  for Row := 1 to StringGrid1.RowCount - 1 do
  begin
    ValorEdit := '';
    Preco := 0;
    if Funcoes.ObterValorDecimal(StringGrid1.Cells[3, Row]) then
    begin
      ValorEdit := StringReplace(StringGrid1.Cells[3, Row], '.', '', [rfReplaceAll]);
      ValorEdit := Trim(ValorEdit);

      Preco := StrToFloat(ValorEdit);
    end
    else
      Preco := Funcoes.ObterValorInteiro(edtTotal.Text);

    FNegociacaoItensController.Salvar(0,IdNegociacao,StrToInt(StringGrid1.Cells[0,Row]),StrToFloat(StringGrid1.Cells[2,Row]), Preco);
  end;

  LimpaCampos;
  ShowMessage('Negociação salva com sucesso!');
  CarregaNegociacao;
end;

procedure TFCadastroNegociacao.CarregaNegociacao;
var
  Negociacoes: TObjectList<TNegociacao>;
  Negociacao:   TNegociacao;
begin
  cbxNegociacao.Clear;

  Negociacoes := FController.MostrarTodos;
  for Negociacao in Negociacoes do
  begin
    cbxNegociacao.Items.AddObject(IntToStr(Negociacao.ID), TObject(Negociacao));
  end;
end;

procedure TFCadastroNegociacao.cbxNegociacaoClick(Sender: TObject);
var
  Negociacao: TNegociacao;
  Produtor: TProdutor;
  Distribuidor: TDistribuidor;
  Produto: TProduto;
  NegociacaoItens: TNegociacaoItens;
  Itens: TObjectList<TNegociacaoItens>;
  Row: integer;
begin
  DesabilitaCampos;
  edtQtd.Clear;
  cbxProduto.Items.Clear;
  cbxProdutor.Items.Clear;
  cbxDistribuidor.Items.Clear;
  ValorTotal := 0;
  LimparGrid(StringGrid1);

  Negociacao    := TNegociacao(cbxNegociacao.Items.Objects[cbxNegociacao.ItemIndex]);

  edtPreco.Text := FormatFloat('#,##0.00', Negociacao.ValorTotal);

  Produtor := TProdutor(FProdutorController.BuscarProdutor(Negociacao.IdProdutor));
  cbxProdutor.Items.Add(Produtor.Nome);
  cbxProdutor.ItemIndex := 0;

  Distribuidor  := TDistribuidor(FDistribuidorController.BuscarDistribuidor(Negociacao.IdDistribuidor));
  cbxDistribuidor.Items.Add(Distribuidor.Nome);
  cbxDistribuidor.ItemIndex := 0;

  Itens := TObjectList<TNegociacaoItens>.Create;
  Itens := FNegociacaoItensController.MostrarTodos(Negociacao.ID);
  StringGrid1.RowCount := Itens.Count + 1;
  for Row := 0 to Itens.Count - 1 do
  begin
    Produto := TProduto(FProdutoController.BuscarProduto(Itens[Row].IdProduto));
    NegociacaoItens := TNegociacaoItens.Create(Itens[Row].ID, Negociacao.ID, Produto.ID, Itens[Row].Quantidade, Itens[Row].ValorUnitario) ;
    StringGrid1.Cells[0, Row + 1] := IntToStr(NegociacaoItens.IdProduto);
    StringGrid1.Cells[1, Row + 1] := Produto.Nome;
    StringGrid1.Cells[2, Row + 1] := FloatToStr(NegociacaoItens.Quantidade);
    StringGrid1.Cells[3, Row + 1] := FormatFloat('#,##0.00', NegociacaoItens.ValorUnitario);

    ValorTotal := ValorTotal + (NegociacaoITens.Quantidade * NegociacaoItens.ValorUnitario);
    edtTotal.Text := FormatFloat('#,##0.00', ValorTotal);
  end;
  btnExcluir.Enabled := True;
end;

procedure TFCadastroNegociacao.cbxProdutoClick(Sender: TObject);
var
  Produto: TProduto;
  Valor: Double;
begin
  if cbxProduto.ItemIndex > -1 then
  begin
    Produto := TProduto(cbxProduto.Items.Objects[cbxProduto.ItemIndex]);
    edtPreco.Text := FormatFloat('#,##0.00', Produto.Preco);
  end;
end;

procedure TFCadastroNegociacao.DesabilitaCampos;
begin
  cbxProdutor.Enabled       := False;
  cbxDistribuidor.Enabled   := False;
  cbxProduto.Enabled        := False;
  edtQtd.Enabled            := False;
  StringGrid1.Enabled       := False;
  btnSalvar.Enabled         := False;
  btnExcluir.Enabled        := False;
  btnAdd.Enabled            := False;
  btnRemover.Enabled        := False;
end;

procedure TFCadastroNegociacao.FormCreate(Sender: TObject);
begin
   FController                := TNegociacaoController.Create;
   FProdutoController         := TProdutoController.Create;
   FProdutorController        := TProdutorController.Create;
   FDistribuidorController    := TDistribuidorController.Create;
   FNegociacaoItensController := TNegociacaoItensController.Create;
   FLimiteCreditoController   := TLimiteCreditoController.Create;
   ValorTotal := 0;
end;

procedure TFCadastroNegociacao.FormDestroy(Sender: TObject);
begin
  LimpaCampos;
  FController.Free;
  FProdutoController.Free;
  FProdutorController.Free;
  FDistribuidorController.Free;
  FLimiteCreditoController.Free;
end;

procedure TFCadastroNegociacao.FormShow(Sender: TObject);
begin
  DesabilitaCampos;
  CarregaNegociacao;
  //nome das colunas
  StringGrid1.Cells[0, 0] := 'Cód';
  StringGrid1.Cells[1, 0] := 'Produto';
  StringGrid1.Cells[2, 0] := 'Quantidade';
  StringGrid1.Cells[3, 0] := 'Valor';

  //largura das colunas
  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 200;
  StringGrid1.ColWidths[2] := 100;
  StringGrid1.ColWidths[3] := 160;

  ValorTotal := 0;
end;

procedure TFCadastroNegociacao.HabilitaCampos;
begin
  cbxProdutor.Enabled       := True;
  cbxDistribuidor.Enabled   := True;
  cbxProduto.Enabled        := True;
  edtQtd.Enabled            := True;
  StringGrid1.Enabled       := True;
  btnSalvar.Enabled         := True;
  btnExcluir.Enabled        := True;
  btnAdd.Enabled            := True;
  btnRemover.Enabled        := True;
end;

procedure TFCadastroNegociacao.LimpaCampos;
begin
  cbxProdutor.ItemIndex := -1;
  cbxDistribuidor.ItemIndex := -1;
  cbxNegociacao.ItemIndex := -1;
  cbxProduto.ItemIndex := -1;
  edtPreco.Clear;
  edtQtd.Clear;
  edtTotal.Clear;
  LimparGrid(StringGrid1);
end;

procedure TFCadastroNegociacao.LimparGrid(StringGrid: TStringGrid);
var
  Row, Col: Integer;
begin
  for Row := 0 to StringGrid.RowCount - 1 do
  begin
    for Col := 0 to StringGrid.ColCount - 1 do
    begin
      StringGrid.Cells[Col, Row] := '';
    end;
  end;

  StringGrid.RowCount := 1;
end;

procedure TFCadastroNegociacao.RemoverCampos(const Index: integer);
var
  Row, Col: Integer;
  Valor, Quantidade: Double;
  Produto : TProduto;
  ValorEdit: string;
begin
  if (Index > 0) and (Index < StringGrid1.RowCount) then
  begin
    Quantidade := StrToFloat(StringGrid1.Cells[2, Index]);

    if Funcoes.ObterValorDecimal(StringGrid1.Cells[3, Index]) then
    begin
      ValorEdit := StringReplace(StringGrid1.Cells[3, Index], '.', '', [rfReplaceAll]);
      ValorEdit := Trim(ValorEdit);

      Valor := StrToFloat(ValorEdit);
    end
    else
      Valor := Funcoes.ObterValorInteiro(StringGrid1.Cells[3, Index]);
    
    for Row := Index + 1 to StringGrid1.RowCount - 1 do
    begin
      for Col := 0 to StringGrid1.ColCount - 1 do
      begin
        StringGrid1.Cells[Col, Row - 1] := StringGrid1.Cells[Col, Row];
      end;
    end;



    StringGrid1.RowCount := StringGrid1.RowCount - 1;
    ValorTotal := ValorTotal - (Valor * Quantidade);
    edtTotal.Text := FormatFloat('#,##0.00', ValorTotal);
  end;
end;

procedure TFCadastroNegociacao.SetNegociacao(const ID, IdProdutor,
  IdDistribuidor, IdStatus: integer; const Valortotal: Double);
begin
  FID := ID;
end;

end.
