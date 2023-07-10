unit ConsultaNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  DistribuidorController, NegociacaoController, ProdutorController, Distribuidor,
  Produtor, System.Generics.Collections, Negociacao, StatusController;

type
  TFConsultaNegociacao = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    btnVisualizar: TButton;
    StringGrid1: TStringGrid;
    btnSair: TButton;
    RadioGroup1: TRadioGroup;
    cbxProdDist: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure cbxProdDistClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    FController: TNegociacaoController;
    FDistribuidorController: TDistribuidorController;
    FProdutorController: TProdutorController;
    FStatusController: TStatusController;
    procedure CarregaDistribuidores;
    procedure CarregaProdutores;
    procedure LimpaCampos;
    procedure LimparGrid(StringGrid: TStringGrid);
    procedure AjustarGrid;
  public
    { Public declarations }
  end;

var
  FConsultaNegociacao: TFConsultaNegociacao;

implementation

{$R *.dfm}

{ TFConsultaNegociacao }


procedure TFConsultaNegociacao.AjustarGrid;
begin
  //nome das colunas
  StringGrid1.Cells[0, 0] := 'Id. Neg';
  StringGrid1.Cells[1, 0] := 'Produtor';
  StringGrid1.Cells[2, 0] := 'Distribuidor';
  StringGrid1.Cells[3, 0] := 'Status';
  StringGrid1.Cells[4, 0] := 'Valor';
  StringGrid1.Cells[5, 0] := 'Data';

  //largura das colunas
  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 100;
  StringGrid1.ColWidths[2] := 100;
  StringGrid1.ColWidths[3] := 80;
  StringGrid1.ColWidths[4] := 80;
  StringGrid1.ColWidths[5] := 80;
end;

procedure TFConsultaNegociacao.btnSairClick(Sender: TObject);
begin
  LimpaCampos;
  Close;
end;

procedure TFConsultaNegociacao.CarregaDistribuidores;
var
  Distribuidores: TObjectList<TDistribuidor>;
  Distribuidor:   TDistribuidor;
begin
  cbxProdDist.Clear;

  Distribuidores := FDistribuidorController.MostrarTodos;
  for Distribuidor in Distribuidores do
  begin
    cbxProdDist.Items.AddObject(Distribuidor.Nome, TObject(Distribuidor));
  end;
end;

procedure TFConsultaNegociacao.CarregaProdutores;
var
  Produtores: TObjectList<TProdutor>;
  Produtor:   TProdutor;
begin
  cbxProdDist.Clear;

  Produtores := FProdutorController.MostrarTodos;
  for Produtor in Produtores do
  begin
    cbxProdDist.Items.AddObject(Produtor.Nome, TObject(Produtor));
  end;
end;

procedure TFConsultaNegociacao.cbxProdDistClick(Sender: TObject);
var
  Negociacoes: TObjectList<TNegociacao>;
  Negociacao:   TNegociacao;
  Produtor, ProdutorFiltro: TProdutor;
  Distribuidor, DistribuidorFiltro: TDistribuidor;
  Row: integer;
begin
    LimparGrid(StringGrid1);
    StringGrid1.RowCount := 1;
    Negociacoes := TObjectList<TNegociacao>.Create;
    Negociacoes.Clear;
    if RadioGroup1.ItemIndex = 0 then
    begin
       ProdutorFiltro := TProdutor(cbxProdDist.Items.Objects[cbxProdDist.ItemIndex]);
       Negociacoes    := FController.MostrarTodosPorProdutor(ProdutorFiltro.ID);
    end
    else
    begin
       DistribuidorFiltro := TDistribuidor(cbxProdDist.Items.Objects[cbxProdDist.ItemIndex]);
       Negociacoes    := FController.MostrarTodosPorDistribuidor(DistribuidorFiltro.ID);
    end;
    StringGrid1.RowCount := Negociacoes.Count + 1;
    for Row := 0 to Negociacoes.Count - 1 do
    begin
      AjustarGrid;
      //dados das colunas
      Negociacao := TNegociacao.Create(Negociacoes[Row].ID, Negociacoes[Row].IdProdutor, Negociacoes[Row].IdDistribuidor, Negociacoes[Row].IdStatus, Negociacoes[Row].ValorTotal, DateToStr(Now), DateToStr(Now), DateToStr(Now), DateToStr(Now));
      StringGrid1.Cells[0, Row + 1] := IntToStr(Negociacao.ID);
      Produtor := FProdutorController.BuscarProdutor(Negociacao.IdProdutor);
      StringGrid1.Cells[1, Row + 1] := Produtor.Nome;
      Distribuidor := FDistribuidorController.BuscarDistribuidor(Negociacao.IdDistribuidor);
      StringGrid1.Cells[2, Row + 1] := Distribuidor.Nome;
      StringGrid1.Cells[3, Row + 1] := FStatusController.BuscarEspecifico(Negociacao.IdStatus);
      StringGrid1.Cells[4, Row + 1] := FormatFloat('#,##0.00', Negociacao.ValorTotal);
      StringGrid1.Cells[5, Row + 1] := DateToStr(Negociacao.DataCriacao);
    end;
end;

procedure TFConsultaNegociacao.FormCreate(Sender: TObject);
begin
  FController             := TNegociacaoController.Create;
  FDistribuidorController := TDistribuidorController.Create;
  FProdutorController     := TProdutorController.Create;
  FStatusController       := TStatusController.Create;
  CarregaProdutores;
end;

procedure TFConsultaNegociacao.FormDestroy(Sender: TObject);
begin
  FController.Free;
  FDistribuidorController.Free;
  FProdutorController.Free;
  FStatusController.Free;
end;

procedure TFConsultaNegociacao.FormShow(Sender: TObject);
begin
  AjustarGrid;
end;

procedure TFConsultaNegociacao.LimpaCampos;
begin
  cbxProdDist.ItemIndex := -1;
  LimparGrid(StringGrid1);
end;

procedure TFConsultaNegociacao.LimparGrid(StringGrid: TStringGrid);
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

procedure TFConsultaNegociacao.RadioGroup1Click(Sender: TObject);
begin
  LimpaCampos;
  if RadioGroup1.ItemIndex = 0 then
    CarregaProdutores
  else
    CarregaDistribuidores;
end;

end.
