unit CadastroProdutor;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  System.Generics.Collections,
  ProdutorController,
  uProdutor,
  CadastroNovoProdutor;

type
  TFCadastroProdutor = class(TForm)
    pnTopo: TPanel;
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    btnPesquisar: TBitBtn;
    edtNome: TEdit;
    edtCPFCNPJ: TEdit;
    pnGrid: TPanel;
    pnRodape: TPanel;
    btnFechar: TBitBtn;
    btnNovo: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    StringGrid1: TStringGrid;
    procedure btnNovoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    FProdutorController: TProdutorController;
    procedure Pesquisar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FCadastroProdutor: TFCadastroProdutor;

implementation

{$R *.dfm}

procedure TFCadastroProdutor.btnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFCadastroProdutor.btnNovoClick(Sender: TObject);
begin
  Application.CreateForm(TFCadastroNovoProdutor, FCadastroNovoProdutor);
  FCadastroNovoProdutor.ShowModal;
end;

procedure TFCadastroProdutor.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

constructor TFCadastroProdutor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProdutorController := TProdutorController.Create;
end;

destructor TFCadastroProdutor.Destroy;
begin
  FProdutorController.Free;
  inherited;
end;

procedure TFCadastroProdutor.Pesquisar;
var
  Produtores: TObjectList<TProdutor>;
  Row: Integer;
  Produtor: TProdutor;
begin
  StringGrid1.RowCount := 1;
  Produtores := TObjectList<TProdutor>.Create;
  Produtores := FProdutorController.PesquisarTodos;
  StringGrid1.RowCount := Produtores.Count + 1;
  for Row := 0 to Produtores.Count - 1 do
  begin
    StringGrid1.Cells[0, 0] := 'ID';
    StringGrid1.Cells[1, 0] := 'Nome';
    StringGrid1.Cells[2, 0] := 'CNPJ';
    StringGrid1.ColWidths[0] := 50;
    StringGrid1.ColWidths[1] := 300;
    StringGrid1.ColWidths[2] := 160;
    Produtor := TProdutor.Create(Produtores[Row].ID, Produtores[Row].Nome, Produtores[Row].CPFCNPJ);
    StringGrid1.Cells[0, Row + 1] := IntToStr(Produtor.ID);
    StringGrid1.Cells[1, Row + 1] := Produtor.Nome;
    StringGrid1.Cells[2, Row + 1] := Produtor.CPFCNPJ;
  end;
end;

end.
