unit uDistribuidorCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Comp.Client;

type
  TfrmDistribuidorCadastro = class(TForm)
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    edtCPFCNPJ: TEdit;
    edtNome: TEdit;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCodigo: Integer;
    FNome,
    FCPFCNPJ: String;
    FNovoDistribuidor: Boolean;

    function ValidarCampos(): Boolean;
    procedure CadastrarDistribuidor(pCodigo: Integer; pNome, pCPFCNPJ: String);
    procedure AlterarDistribuidor(pCodigo: Integer; pNome, pCPFCNPJ: String);
  public
    { Public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String write FNome;
    property CPFCNPJ: String write FCPFCNPJ;
  end;


implementation

{$R *.dfm}

uses uDM;

procedure TfrmDistribuidorCadastro.AlterarDistribuidor(pCodigo: Integer; pNome,
  pCPFCNPJ: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('UPDATE distribuidor');
    lQry.SQL.Add('SET  nome = :pNome,');
    lQry.SQL.Add('     CPFCNPJ = :pCPFCNPJ');
    lQry.SQL.Add('WHERE codigo = :pCodigo');

    lQry.ParamByName('pCodigo').AsInteger := pCodigo;
    lQry.ParamByName('pNome').AsString := pNome;
    lQry.ParamByName('pCPFCNPJ').AsString := pCPFCNPJ;

    try
      lQry.ExecSQL;
      MessageDlg('Distribuidor ' + pNome + ' alterado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao alterar o distribuidor ' + pNome, mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmDistribuidorCadastro.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDistribuidorCadastro.btnOkClick(Sender: TObject);
begin
  if not ValidarCampos() then
    Abort
  else
    if FNovoDistribuidor then
      CadastrarDistribuidor(FCodigo, edtNome.Text, edtCPFCNPJ.Text)
    else
      AlterarDistribuidor(FCodigo, edtNome.Text, edtCPFCNPJ.Text);

  Close;
end;

procedure TfrmDistribuidorCadastro.CadastrarDistribuidor(pCodigo: Integer;
  pNome, pCPFCNPJ: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('INSERT INTO distribuidor (CODIGO, NOME, CPFCNPJ)');
    lQry.SQL.Add('VALUES (:pCODIGO, :pNOME, :pCPFCNPJ)');

    lQry.ParamByName('pCODIGO').AsInteger := pCodigo;
    lQry.ParamByName('pNOME').AsString := pNome;
    lQry.ParamByName('pCPFCNPJ').AsString := pCPFCNPJ;

    try
      lQry.ExecSQL;
      MessageDlg('Distribuidor ' + pNome + ' gravado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao inserir o distribuidor ' + pNome, mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmDistribuidorCadastro.FormShow(Sender: TObject);
begin
  edtNome.Text := FNome;
  edtCPFCNPJ.Text := FCPFCNPJ;

  if edtNome.CanFocus then
    edtNome.SetFocus;

  if FCodigo = 0 then
    begin
      FCodigo := DM.ObterCodigoTabela('Codigo', 'Distribuidor');
      FNovoDistribuidor := True;
    end
  else
    FNovoDistribuidor := False;
end;

function TfrmDistribuidorCadastro.ValidarCampos(): Boolean;
var
  lCPFCNPJ: String;
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
      begin
        //Removendo a máscara
        lCPFCNPJ := StringReplace(StringReplace(StringReplace(edtCPFCNPJ.Text, '.', '', []), '-', '', []), '/', '', []);

        if Length(lCPFCNPJ) < 11 then
          begin
            MessageDlg('O tamanho do campo CPF/CNPJ não é válido. Verifique.', mtInformation, [mbOk], 0);
            edtCPFCNPJ.SetFocus;
          end
        else
          Result := True;
      end;
end;

end.
