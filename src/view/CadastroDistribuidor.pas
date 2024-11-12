unit CadastroDistribuidor;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  CadastroNovoDistribuidor,
  DistribuidorController,
  uDistribuidor,
  DistribuidorDAO,
  System.Generics.Collections;

type
  TFCadastroDistribuidor = class(TForm)
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
    FDistribuidorController: TDistribuidorController;
    procedure Pesquisar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FCadastroDistribuidor: TFCadastroDistribuidor;

implementation

{$R *.dfm}

procedure TFCadastroDistribuidor.btnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFCadastroDistribuidor.btnNovoClick(Sender: TObject);
begin
  Application.CreateForm(TFCadastroNovoDistribuidor, FCadastroNovoDistribuidor);
  FCadastroNovoDistribuidor.ShowModal;
end;

procedure TFCadastroDistribuidor.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

constructor TFCadastroDistribuidor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDistribuidorController := TDistribuidorController.Create;
end;

destructor TFCadastroDistribuidor.Destroy;
begin
  FDistribuidorController.Free;
  inherited;
end;

procedure TFCadastroDistribuidor.Pesquisar;
var
  Distribuidores: TObjectList<TDistribuidor>;
  Row: Integer;
  Distribuidor: TDistribuidor;
begin
  StringGrid1.RowCount := 1;
  Distribuidores := TObjectList<TDistribuidor>.Create;
  Distribuidores := FDistribuidorController.PesquisarTodos;
  StringGrid1.RowCount := Distribuidores.Count + 1;
  for Row := 0 to Distribuidores.Count - 1 do
  begin
    StringGrid1.Cells[0, 0] := 'ID';
    StringGrid1.Cells[1, 0] := 'Nome';
    StringGrid1.Cells[2, 0] := 'CNPJ';
    StringGrid1.ColWidths[0] := 50;
    StringGrid1.ColWidths[1] := 300;
    StringGrid1.ColWidths[2] := 160;
    Distribuidor := TDistribuidor.Create(Distribuidores[Row].ID, Distribuidores[Row].Nome, Distribuidores[Row].CNPJ);
    StringGrid1.Cells[0, Row + 1] := IntToStr(Distribuidor.ID);
    StringGrid1.Cells[1, Row + 1] := Distribuidor.Nome;
    StringGrid1.Cells[2, Row + 1] := Distribuidor.CNPJ;
  end;
end;

end.
