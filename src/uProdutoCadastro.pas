unit uProdutoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Comp.Client,
  Vcl.NumberBox;

type
  TfrmProdutoCadastro = class(TForm)
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    edtNome: TEdit;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtPreco: TNumberBox;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCodigo: Integer;
    FNome,
    FPreco: String;
    FNovoProduto: Boolean;

    function ValidarCampos(): Boolean;
    procedure CadastrarProduto(pCodigo: Integer; pNome, pPreco: String);
    procedure AlterarProduto(pCodigo: Integer; pNome, pPreco: String);
  public
    { Public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String write FNome;
    property Preco: String write FPreco;

  end;


implementation

{$R *.dfm}

uses uDM;

procedure TfrmProdutoCadastro.AlterarProduto(pCodigo: Integer; pNome,
  pPreco: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('UPDATE produto');
    lQry.SQL.Add('SET  nome = :pNome,');
    lQry.SQL.Add('     valor = :pValor');
    lQry.SQL.Add('WHERE codigo = :pCodigo');

    lQry.ParamByName('pCodigo').AsInteger := pCodigo;
    lQry.ParamByName('pNome').AsString := pNome;
    lQry.ParamByName('pValor').AsFloat := StrToFloat(pPreco);

    try
      lQry.ExecSQL;
      MessageDlg('Produto ' + pNome + ' alterado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao alterar o produto ' + pNome, mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmProdutoCadastro.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutoCadastro.btnOkClick(Sender: TObject);
begin
  if not ValidarCampos() then
    Abort
  else
    if FNovoProduto then
      CadastrarProduto(FCodigo, edtNome.Text, edtPreco.Text)
    else
      AlterarProduto(FCodigo, edtNome.Text, edtPreco.Text);

  Close;
end;

procedure TfrmProdutoCadastro.CadastrarProduto(pCodigo: Integer; pNome,
  pPreco: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('INSERT INTO produto (CODIGO, NOME, VALOR)');
    lQry.SQL.Add('VALUES (:pCODIGO, :pNOME, :pVALOR)');

    lQry.ParamByName('pCODIGO').AsInteger := pCodigo;
    lQry.ParamByName('pNOME').AsString := pNome;
    lQry.ParamByName('pVALOR').AsFloat := StrToFloat(pPreco);

    try
      lQry.ExecSQL;
      MessageDlg('Produto ' + pNome + ' gravado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao inserir o produto ' + pNome, mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmProdutoCadastro.FormShow(Sender: TObject);
begin
  edtNome.Text := FNome;
  edtPreco.Text := FPreco;

  if edtNome.CanFocus then
    edtNome.SetFocus;

  if FCodigo = 0 then
    begin
      FCodigo := DM.ObterCodigoTabela('Codigo', 'Produto');
      FNovoProduto := True;
    end
  else
    FNovoProduto := False;
end;

function TfrmProdutoCadastro.ValidarCampos: Boolean;
begin
  Result := False;

  if edtNome.Text = '' then
    begin
      MessageDlg('O campo nome não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
      edtNome.SetFocus;
    end
  else
    if Length(edtNome.Text) < 3 then
      begin
        MessageDlg('O campo nome não é válido. Verifique.', mtInformation, [mbOk], 0);
        edtNome.SetFocus;
      end
    else
    if edtPreco.Text = '' then
      begin
        MessageDlg('O campo Preço não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
        edtPreco.SetFocus;
      end
    else
      if edtPreco.Text = '0' then
        begin
          MessageDlg('O campo Preço não pode ser zero. Verifique.', mtInformation, [mbOk], 0);
          edtPreco.SetFocus;
        end
      else
        Result := True;
end;

end.
