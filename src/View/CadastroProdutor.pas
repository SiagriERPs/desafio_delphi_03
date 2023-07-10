unit CadastroProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, ProdutorController, Produtor, System.Generics.Collections,
  CadastroLimiteCredito;

type
  TFCadastroProdutor = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    lblNome: TLabel;
    lblCNPJ: TLabel;
    lbl_cod: TLabel;
    edtNome: TEdit;
    edtCNPJ: TMaskEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    StringGrid1: TStringGrid;
    edtCod: TEdit;
    btnExcluir: TButton;
    RadioGroup1: TRadioGroup;
    btnLimiteCredito: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnLimiteCreditoClick(Sender: TObject);
  private
    { Private declarations }
    FController: TProdutorController;
    FID: integer;
    FisEditing: Boolean;
    CadastroLimiteCredito: TFCadastroLimiteCredito;
    procedure SetProdutor(const ID: integer; const Nome, CNPJ: string);
    procedure LimpaCampos;
    procedure CarregaProdutores;
    procedure VerificaMascara;
  public
    { Public declarations }
    procedure EditarProdutor(const ID: integer; const Nome, CPFCNPJ: string);
  end;

var
  FCadastroProdutor: TFCadastroProdutor;

implementation

{$R *.dfm}


{ TFCadastroProdutor }

procedure TFCadastroProdutor.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TFCadastroProdutor.btnExcluirClick(Sender: TObject);
begin
  if edtCod.Text <> '' then
  begin
    FController.Excluir(StrToInt(edtCod.Text));
    LimpaCampos;
    CarregaProdutores;
  end
  else
  begin
    ShowMessage('Selecione um distribuidor para exclui-lo!');
  end;
end;

procedure TFCadastroProdutor.btnLimiteCreditoClick(Sender: TObject);
begin
  if not (edtCod.Text <> '') then
    ShowMessage('Selecione um PRODUTOR na grade para definir/atualizar o limite de crédito.')
  else
  begin
    if not Assigned(CadastroLimiteCredito) then
      CadastroLimiteCredito := TFCadastroLimiteCredito.Create(Application);

    CadastroLimiteCredito.SetProdutor(StrToInt(edtCod.Text), edtNome.Text);
    CadastroLimiteCredito.ShowModal;
  end;
end;

procedure TFCadastroProdutor.btnSalvarClick(Sender: TObject);
begin
  if FisEditing then
     FController.Atualiza(FID, edtNome.Text, edtCNPJ.Text)
  else
  begin
    if (edtNome.Text <> '') and (edtCNPJ.Text <> '') then
      FController.SalvarProdutor(0, edtNome.Text,edtCNPJ.Text)
    else
      ShowMessage('É necessário informar NOME e CPF/CNPJ para cadastrar novo PRODUTOR');
  end;
  LimpaCampos;
  CarregaProdutores;
end;

procedure TFCadastroProdutor.CarregaProdutores;
var
  Produtores: TObjectList<TProdutor>;
  Produtor:   TProdutor;
  Row: integer;
begin
  StringGrid1.RowCount := 1;
  Produtores := TObjectList<TProdutor>.Create;
  Produtores := FController.MostrarTodos;
  StringGrid1.RowCount := Produtores.Count + 1;
  for Row := 0 to Produtores.Count - 1 do
  begin
    //nome das colunas
    StringGrid1.Cells[0, 0] := 'Cód';
    StringGrid1.Cells[1, 0] := 'Nome';
    StringGrid1.Cells[2, 0] := 'CPF/CNPJ';

    //largura das colunas
    StringGrid1.ColWidths[0] := 50;
    StringGrid1.ColWidths[1] := 300;
    StringGrid1.ColWidths[2] := 160;

    //dados das colunas
    Produtor := TProdutor.Create(Produtores[Row].ID, Produtores[Row].Nome, Produtores[Row].CPFCNPJ);
    StringGrid1.Cells[0, Row + 1] := IntToStr(Produtor.ID);
    StringGrid1.Cells[1, Row + 1] := Produtor.Nome;
    StringGrid1.Cells[2, Row + 1] := Produtor.CPFCNPJ;
  end;
end;

procedure TFCadastroProdutor.EditarProdutor(const ID: integer; const Nome,
  CPFCNPJ: string);
begin
  FisEditing := True;
  SetProdutor(ID, Nome, CPFCNPJ);
end;

procedure TFCadastroProdutor.FormCreate(Sender: TObject);
begin
  FController := TProdutorController.Create;
  FisEditing := False;
  VerificaMascara;
end;

procedure TFCadastroProdutor.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TFCadastroProdutor.FormShow(Sender: TObject);
begin
  CarregaProdutores;
end;

procedure TFCadastroProdutor.LimpaCampos;
begin
  edtCod.Clear;
  edtNome.Clear;
  edtCNPJ.Clear;
end;

procedure TFCadastroProdutor.RadioGroup1Click(Sender: TObject);
begin
  edtCNPJ.Clear;
  VerificaMascara;
end;

procedure TFCadastroProdutor.SetProdutor(const ID: integer; const Nome,
  CNPJ: string);
begin
  FID          := ID;
  edtCod.Text  := IntToStr(ID);
  edtNome.Text := Nome;
  VerificaMascara;
  edtCNPJ.Text := CNPJ;
end;

procedure TFCadastroProdutor.StringGrid1SelectCell(Sender: TObject; ACol,
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
    EditarProdutor(ID, Name, CNPJ);
  end;
end;

procedure TFCadastroProdutor.VerificaMascara;
begin
  if RadioGroup1.ItemIndex = 0 then
    edtCNPJ.EditMask := '000.000.000-00'
  else
    edtCNPJ.EditMask := '00.000.000/0000-00';
end;

end.
