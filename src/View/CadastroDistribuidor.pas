unit CadastroDistribuidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  DistribuidorController, Vcl.Dialogs, Vcl.Grids;

type
  TFCadastroDistribuidor = class(TForm)
    pnl_principal: TPanel;
    edtNome: TEdit;
    edtCNPJ: TMaskEdit;
    lbl_form: TLabel;
    lblNome: TLabel;
    lblCNPJ: TLabel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    StringGrid1: TStringGrid;
    lbl_cod: TLabel;
    edtCod: TEdit;
    btnExcluir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    FController: TDistribuidorController;
    FID: integer;
    FisEditing: Boolean;
    procedure SetDistribuidor(const ID: integer; const Nome, CNPJ: string);
    procedure LimpaCampos;
    procedure CarregaDistribuidores;
  public
    { Public declarations }
    procedure EditarDistribuidor(const ID: integer; const Nome, CNPJ: string);
  end;

var
  FCadastroDistribuidor: TFCadastroDistribuidor;

implementation

{$R *.dfm}

uses Distribuidor, System.Generics.Collections;

procedure TFCadastroDistribuidor.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TFCadastroDistribuidor.btnExcluirClick(Sender: TObject);
begin
  if edtCod.Text <> '' then
  begin
    FController.Excluir(StrToInt(edtCod.Text));
    LimpaCampos;
    CarregaDistribuidores;
  end
  else
  begin
    ShowMessage('Selecione um distribuidor para exclui-lo!');
  end;
end;

procedure TFCadastroDistribuidor.btnSalvarClick(Sender: TObject);
begin
  if FisEditing then
     FController.Atualiza(FID, edtNome.Text, edtCNPJ.Text)
  else
  begin
    if (edtNome.Text <> '') and (edtCNPJ.Text <> '') then
      FController.SalvarDistribuidor(0, edtNome.Text,edtCNPJ.Text)
    else
      ShowMessage('É necessário informar NOME e CNPJ para cadastrar novo DISTRIBUIDOR');  
  end;
  LimpaCampos;
  CarregaDistribuidores;
end;

procedure TFCadastroDistribuidor.CarregaDistribuidores;
var
  Distribuidores: TObjectList<TDistribuidor>;
  Distribuidor:   TDistribuidor;
  Row: integer;
begin
  StringGrid1.RowCount := 1;
  Distribuidores := TObjectList<TDistribuidor>.Create;
  Distribuidores := FController.MostrarTodos;
  StringGrid1.RowCount := Distribuidores.Count + 1;
  for Row := 0 to Distribuidores.Count - 1 do
  begin
    //nome das colunas
    StringGrid1.Cells[0, 0] := 'Cód';
    StringGrid1.Cells[1, 0] := 'Nome';
    StringGrid1.Cells[2, 0] := 'CNPJ';

    //largura das colunas
    StringGrid1.ColWidths[0] := 50;
    StringGrid1.ColWidths[1] := 300;
    StringGrid1.ColWidths[2] := 160;

    //dados das colunas      
    Distribuidor := TDistribuidor.Create(Distribuidores[Row].ID, Distribuidores[Row].Nome, Distribuidores[Row].CNPJ);
    StringGrid1.Cells[0, Row + 1] := IntToStr(Distribuidor.ID);
    StringGrid1.Cells[1, Row + 1] := Distribuidor.Nome;
    StringGrid1.Cells[2, Row + 1] := Distribuidor.CNPJ;
  end;
end;

procedure TFCadastroDistribuidor.EditarDistribuidor(const ID: integer;
  const Nome, CNPJ: string);
begin
  FisEditing := True;
  SetDistribuidor(ID, Nome, CNPJ);
end;

procedure TFCadastroDistribuidor.FormCreate(Sender: TObject);
begin
  FController := TDistribuidorController.Create;
  FisEditing := False;
end;

procedure TFCadastroDistribuidor.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TFCadastroDistribuidor.FormShow(Sender: TObject);
begin
  CarregaDistribuidores;
end;

procedure TFCadastroDistribuidor.LimpaCampos;
begin
  edtCod.Clear;
  edtNome.Clear;
  edtCNPJ.Clear;
end;

procedure TFCadastroDistribuidor.SetDistribuidor(const ID: integer; const Nome,
  CNPJ: string);
begin
  FID := ID;
  edtCod.Text  := IntToStr(ID);
  edtNome.Text := Nome;
  edtCNPJ.Text := CNPJ;
end;


procedure TFCadastroDistribuidor.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  ID: Integer;
  Name, CNPJ: string;
begin
  if ARow > 0 then
  begin
    ID := StrToIntDef(StringGrid1.Cells[0, ARow], 0);
    Name := StringGrid1.Cells[1, ARow];
    CNPJ := StringGrid1.Cells[2, ARow];
    EditarDistribuidor(ID, Name, CNPJ);
  end;
end;

end.
