unit uProdutorCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, FireDAC.Comp.Client;

type
  TfrmProdutorCadastro = class(TForm)
    lblNome: TLabel;
    lblCPFCNPJ: TLabel;
    edtCPFCNPJ: TEdit;
    edtNome: TEdit;
    GroupBox1: TGroupBox;
    grdLimiteCredito: TDBGrid;
    cdsLimiteCredito: TClientDataSet;
    dtsLimiteCredito: TDataSource;
    cdsLimiteCreditoditribuidor: TIntegerField;
    cdsLimiteCreditonomedistribuidor: TStringField;
    cdsLimiteCreditovalor: TFloatField;
    btnOk: TSpeedButton;
    SpeedButton1: TSpeedButton;
    btnAdiciona: TSpeedButton;
    btnRetira: TSpeedButton;
    cdsLimiteCreditoCodigo: TIntegerField;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAdicionaClick(Sender: TObject);
    procedure btnRetiraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCodigo: Integer;
    FNome,
    FCPFCNPJ: String;
    FNovoProdutor: Boolean;

    function ValidarCampos(): Boolean;
    procedure CadastrarProdutor(pCodigo: Integer; pNome, pCPFCNPJ: String);
    procedure AlterarProdutor(pCodigo: Integer; pNome, pCPFCNPJ: String);
    procedure ObterLimiteDeCreditoDoProdutor(pCodigo: Integer);
    procedure RetirarLimiteDeCredito(pCodigo: Integer);
    procedure ApagarLimitesDeCredito();
  public
    { Public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String write FNome;
    property CPFCNPJ: String write FCPFCNPJ;
  end;

implementation

{$R *.dfm}

uses uDM, uLimiteCreditoCadastro, uPrincipal;

procedure TfrmProdutorCadastro.AlterarProdutor(pCodigo: Integer; pNome,
  pCPFCNPJ: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('UPDATE produtor');
    lQry.SQL.Add('SET  nome = :pNome,');
    lQry.SQL.Add('     CPFCNPJ = :pCPFCNPJ');
    lQry.SQL.Add('WHERE codigo = :pCodigo');

    lQry.ParamByName('pCodigo').AsInteger := pCodigo;
    lQry.ParamByName('pNome').AsString := pNome;
    lQry.ParamByName('pCPFCNPJ').AsString := pCPFCNPJ;

    try
      lQry.ExecSQL;
      MessageDlg('Produtor ' + pNome + ' alterado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao alterar o produtor ' + pNome, mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmProdutorCadastro.ApagarLimitesDeCredito();
begin
  cdsLimiteCredito.First;

  try
    while not cdsLimiteCredito.Eof do
    begin
      RetirarLimiteDeCredito(cdsLimiteCredito.FieldByName('codigo').AsInteger);

      cdsLimiteCredito.Next;
    end;
  finally
    cdsLimiteCredito.EmptyDataSet;
  end;

end;

procedure TfrmProdutorCadastro.btnAdicionaClick(Sender: TObject);
var
  lfrmLimiteCreditoCadastro: TfrmLimiteCreditoCadastro;
begin
  lfrmLimiteCreditoCadastro := TfrmLimiteCreditoCadastro.Create(Application);

  try
   lfrmLimiteCreditoCadastro.CodigoProdutor := FCodigo;
   lfrmLimiteCreditoCadastro.ShowModal;
  finally
    FreeAndNil(lfrmLimiteCreditoCadastro);
    ObterLimiteDeCreditoDoProdutor(FCodigo);
  end;
end;

procedure TfrmProdutorCadastro.btnCancelarClick(Sender: TObject);
begin
  if FNovoProdutor and
    not cdsLimiteCredito.IsEmpty then
    begin
      if MessageDlg('Deseja realmente desistir do cadastro atual? Todos os limites de crédito serão perdidos.', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
        ApagarLimitesDeCredito();
    end
  else
    cdsLimiteCredito.EmptyDataSet;

  Close;
end;

procedure TfrmProdutorCadastro.btnOkClick(Sender: TObject);
begin
  if not ValidarCampos() then
    Abort
  else
    if FNovoProdutor then
      CadastrarProdutor(FCodigo, edtNome.Text, edtCPFCNPJ.Text)
    else
      AlterarProdutor(FCodigo, edtNome.Text, edtCPFCNPJ.Text);

  Close;
end;

procedure TfrmProdutorCadastro.btnRetiraClick(Sender: TObject);
begin
  if not cdsLimiteCredito.IsEmpty then
    begin
      RetirarLimiteDeCredito(cdsLimiteCredito.FieldByName('codigo').AsInteger);
      cdsLimiteCredito.Delete;
    end;
end;

procedure TfrmProdutorCadastro.CadastrarProdutor(pCodigo: Integer; pNome, pCPFCNPJ: String);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('INSERT INTO produtor (CODIGO, NOME, CPFCNPJ)');
    lQry.SQL.Add('VALUES (:pCODIGO, :pNOME, :pCPFCNPJ)');

    lQry.ParamByName('pCODIGO').AsInteger := pCodigo;
    lQry.ParamByName('pNOME').AsString := pNome;
    lQry.ParamByName('pCPFCNPJ').AsString := pCPFCNPJ;

    try
      lQry.ExecSQL;
      MessageDlg('Produtor ' + pNome + ' gravado com sucesso!', mtInformation, [mbOk], 0);
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao inserir o produtor ' + pNome, mtInformation, [mbOk], 0);
        Abort;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TfrmProdutorCadastro.FormShow(Sender: TObject);
begin
  edtNome.Text := FNome;
  edtCPFCNPJ.Text := FCPFCNPJ;

  if edtNome.CanFocus then
    edtNome.SetFocus;

  if FCodigo = 0 then
    begin
      FCodigo := DM.ObterCodigoTabela('Codigo', 'Produtor');
      FNovoProdutor := True;
    end
  else
    FNovoProdutor := False;

  ObterLimiteDeCreditoDoProdutor(FCodigo);
end;

//function TfrmProdutorCadastro.GetDistribuidor(pCodigo: Integer): Boolean;
//begin
//  Result := cdsLimiteCredito.Locate('distribuidor', pCodigo, []);
//end;

//function TfrmProdutorCadastro.ObterDistribuidorPeloCodigo(
//  pCodigo: Integer): Boolean;
//begin
//  Result := GetDistribuidor(pCodigo);
//end;

procedure TfrmProdutorCadastro.ObterLimiteDeCreditoDoProdutor(pCodigo: Integer);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('SELECT CODIGO, DISTRIBUIDOR, NOMEDISTRIBUIDOR, VALOR');
    lQry.SQL.Add('FROM CREDITO');
    lQry.SQL.Add('WHERE PRODUTOR = :pProdutor');

    lQry.ParamByName('pProdutor').AsInteger := pCodigo;

    try
      lQry.Open;

      cdsLimiteCredito.DisableControls;

      if not cdsLimiteCredito.Active then
        cdsLimiteCredito.CreateDataSet
      else
        cdsLimiteCredito.EmptyDataSet;

      while not lQry.Eof do
      begin
        cdsLimiteCredito.AppendRecord([lQry.FieldByName('CODIGO').AsString,
                                       lQry.FieldByName('DISTRIBUIDOR').AsString,
                                       lQry.FieldByName('NOMEDISTRIBUIDOR').AsString,
                                       lQry.FieldByName('VALOR').AsString]);
        lQry.Next;
      end;

    except
      On E:Exception do
      begin
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao obter o limite de crédito do produtor.', mtInformation, [mbOk], 0);
      end;
    end;
  finally
    cdsLimiteCredito.EnableControls;
    lQry.Close;
    FreeAndNil(lQry);
  end;
end;

procedure TfrmProdutorCadastro.RetirarLimiteDeCredito(pCodigo: Integer);
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := DM.FDConnection;
    lQry.SQL.Add('DELETE FROM CREDITO');
    lQry.SQL.Add('WHERE CODIGO = :pCodigo');

    lQry.ParamByName('pCodigo').AsInteger := pCodigo;

    try
      lQry.ExecSQL;
    except
      On E:Exception do
      begin
        lQry.Transaction.Rollback;
      end;
    end;
  finally
    FreeAndNil(lQry);
  end;
end;

function TfrmProdutorCadastro.ValidarCampos(): Boolean;
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
