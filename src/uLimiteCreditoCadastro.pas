unit uLimiteCreditoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Mask, FireDAC.Comp.Client, Vcl.NumberBox;

type
  TfrmLimiteCreditoCadastro = class(TForm)
    Label5: TLabel;
    cboDistribuidor: TDBLookupComboBox;
    Label2: TLabel;
    btnOk: TSpeedButton;
    SpeedButton1: TSpeedButton;
    edtValor: TNumberBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCodigoProdutor: Integer;
    function ObterDistribuidorPeloCodigo(pCodigoProdutor, pCodigoDistribuidor: Integer): Boolean;
    function ValidarCampos(): Boolean;
    procedure CadastrarLimiteCredito(pCodigoProdutor, pCodigoDistribuidor: Integer;
                                     pNomeDistribuidor, pValor: String);
  public
    { Public declarations }
    Property CodigoProdutor: Integer read FCodigoProdutor write FCodigoProdutor;
  end;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmLimiteCreditoCadastro.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLimiteCreditoCadastro.btnOkClick(Sender: TObject);
begin
  if not ValidarCampos() then
    Abort
  else
  if not ObterDistribuidorPeloCodigo(FCodigoProdutor, cboDistribuidor.KeyValue) then
    CadastrarLimiteCredito(FCodigoProdutor, cboDistribuidor.KeyValue,
                           cboDistribuidor.Text,  edtValor.Text)
  else
    begin
      MessageDlg('Esse distibuidor já foi adicionado. Verifique', mtInformation, [mbOk], 0);
      Abort;
    end;

  Close;
end;

procedure TfrmLimiteCreditoCadastro.CadastrarLimiteCredito(pCodigoProdutor,
  pCodigoDistribuidor: Integer; pNomeDistribuidor, pValor: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('INSERT INTO credito (PRODUTOR, DISTRIBUIDOR, NOMEDISTRIBUIDOR, VALOR)');
    lQry.SQL.Add('VALUES (:pProdutor, :pDistribuidor, :pNomeDistribuidor, :pValor)');

    lQry.ParamByName('pProdutor').AsInteger := pCodigoProdutor;
    lQry.ParamByName('pDistribuidor').AsInteger := pCodigoDistribuidor;
    lQry.ParamByName('pNomeDistribuidor').AsString := pNomeDistribuidor;
    lQry.ParamByName('pValor').AsFloat := StrToFloat(pValor);

    try
      lQry.ExecSQL;
      MessageDlg('Limite de crédito gravado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao inserir o limite de crédito.', mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmLimiteCreditoCadastro.FormShow(Sender: TObject);
begin
  if not DM.qryDistribuidor.Active then
    DM.qryDistribuidor.Open;

  cboDistribuidor.SetFocus;
end;

function TfrmLimiteCreditoCadastro.ObterDistribuidorPeloCodigo(
  pCodigoProdutor, pCodigoDistribuidor: Integer): Boolean;
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('SELECT CODIGO');
    lQry.SQL.Add('FROM CREDITO');
    lQry.SQL.Add('WHERE PRODUTOR = :pProdutor AND DISTRIBUIDOR = :pDistribuidor');

    lQry.ParamByName('pProdutor').AsInteger := pCodigoProdutor;
    lQry.ParamByName('pDistribuidor').AsInteger := pCodigoDistribuidor;

    try
      lQry.Open;

     Result := not lQry.IsEmpty;
   except
      On E:Exception do
      begin
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao obter o distribuidor.', mtInformation, [mbOk], 0);
      end;
    end;
  finally
    lQry.Close;
    FreeAndNil(lQry);
  end;
end;

function TfrmLimiteCreditoCadastro.ValidarCampos: Boolean;
begin
  Result := False;

  if cboDistribuidor.Text = '' then
    begin
      MessageDlg('Por favor selecione um distribuidor.', mtInformation, [mbOk], 0);
      cboDistribuidor.SetFocus;
    end
  else
    if edtValor.Text = '' then
      begin
        MessageDlg('O campo Valor não pode ficar em branco. Verifique.', mtInformation, [mbOk], 0);
        edtValor.SetFocus;
      end
    else
      if edtValor.Text = '0' then
        begin
          MessageDlg('O campo Valor não pode ser zero. Verifique.', mtInformation, [mbOk], 0);
          edtValor.SetFocus;
        end
      else
        Result := True;
end;

end.
