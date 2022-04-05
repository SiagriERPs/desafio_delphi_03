unit Classe.Negociacoes.Aprovar;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Script,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.Forms, System.SysUtils, System.Classes, StrUtils, DateUtils, Data.DB,
  Classe.Negociacoes.Interfaces, Classe.Negociacoes.LimiteCredito;

type

  TNegociacaoAprovar = class(TInterfacedObject, INegociacaoAprovacao)
  private
    { private declarations }
    FParent: INegociacao;
    FSTATUS: TStatus;
    FIDPRODUTOR: Integer;
    FIDDISTRIBUIDOR: Integer;
    FTOTAL_NEGOCIACAO: Currency;
    FLIMITE: Currency;
    FLIMITEDISPONIVEL: Currency;

    procedure getDADOS;
    procedure getLIMITECREDITO;
    procedure getCOMPROMETIMENTO;
    procedure Validar;
    procedure setAPROVACAO;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(Parent: INegociacao);
    destructor Destroy; override;
    class function New(Parent: INegociacao): INegociacaoAprovacao;
    procedure Execute;
  end;

implementation

{ TNegociacaoAprovar }

class
  function TNegociacaoAprovar.New(Parent: INegociacao): INegociacaoAprovacao;
begin
  Result := Self.Create(Parent);
end;

procedure TNegociacaoAprovar.Validar;
begin
  if FSTATUS = TStatus.stAprovada then
    raise Exception.Create('Negociação já está aprovada.');

  if (FSTATUS <> TStatus.stPendente) then
    raise Exception.Create('Só é possível aprovar negociações PENDENTES.');

  if FLIMITEDISPONIVEL < FTOTAL_NEGOCIACAO then
    raise Exception.Create('Limite disponível inferior ao valor da negociação.');
end;

procedure TNegociacaoAprovar.setAPROVACAO;
begin
  var
  QryUpdate := TFDQuery.Create(nil);
  try
    try
      QryUpdate.Connection := FParent.CONEXAO;
      QryUpdate.SQL.Add('update NEGOCIACOES set STATUS = :STATUS, DATA_APROVACAO = :DATA');
      QryUpdate.SQL.Add('where id = :ID');
      QryUpdate.ParamByName('STATUS').AsString := TStatus.stAprovada.AsValue;
      QryUpdate.ParamByName('DATA').AsDate := Date;
      QryUpdate.ParamByName('ID').AsInteger := FParent.NEGOCIACAO;
      QryUpdate.ExecSQL;
    except
      on e: Exception do
      begin
        raise Exception.Create('Erro ao aprovar negociação!' + sLineBreak + e.Message);
      end;
    end;
  finally
    QryUpdate.Close;
    FreeAndNil(QryUpdate);
  end;
end;

constructor TNegociacaoAprovar.Create(Parent: INegociacao);
begin
  FParent := Parent;
end;

destructor TNegociacaoAprovar.Destroy;
begin
  inherited;
end;

procedure TNegociacaoAprovar.getCOMPROMETIMENTO;
begin
  var
  QryConsulta := TFDQuery.Create(nil);
  try
    QryConsulta.Connection := FParent.CONEXAO;
    QryConsulta.SQL.Add('select ');
    QryConsulta.SQL.Add('  SUM(VALOR) VALOR');
    QryConsulta.SQL.Add('from NEGOCIACOES ');
    QryConsulta.SQL.Add('where ID_PRODUTOR = ' + FIDPRODUTOR.ToString);
    QryConsulta.SQL.Add('  and ID_DISTRIBUIDOR = ' + FIDDISTRIBUIDOR.ToString);
    QryConsulta.SQL.Add('  and STATUS = ' + QuotedStr(TStatus.stAprovada.AsValue));
    QryConsulta.Open();

    FLIMITEDISPONIVEL := FLIMITE - QryConsulta.FieldByName('VALOR').AsCurrency;
  finally
    QryConsulta.Close;
    FreeAndNil(QryConsulta);
  end;
end;

procedure TNegociacaoAprovar.getDADOS;
begin
  var
  QryConsulta := TFDQuery.Create(nil);
  try
    QryConsulta.Connection := FParent.CONEXAO;
    QryConsulta.SQL.Add('select ');
    QryConsulta.SQL.Add(' STATUS,');
    QryConsulta.SQL.Add(' ID_PRODUTOR,');
    QryConsulta.SQL.Add(' ID_DISTRIBUIDOR,');
    QryConsulta.SQL.Add(' VALOR');
    QryConsulta.SQL.Add('from NEGOCIACOES ');
    QryConsulta.SQL.Add('where ID = ' + FParent.NEGOCIACAO.ToString);
    QryConsulta.Open();

    FSTATUS := TStatus.Parse_Value(QryConsulta.FieldByName('STATUS').AsString);
    FIDPRODUTOR := QryConsulta.FieldByName('ID_PRODUTOR').AsInteger;
    FIDDISTRIBUIDOR := QryConsulta.FieldByName('ID_DISTRIBUIDOR').AsInteger;
    FTOTAL_NEGOCIACAO := QryConsulta.FieldByName('VALOR').AsInteger;
  finally
    QryConsulta.Close;
    FreeAndNil(QryConsulta);
  end;
end;

procedure TNegociacaoAprovar.getLIMITECREDITO;
begin
  FLIMITE := TNegociacaoLimiteCredito.New(FIDPRODUTOR, FIDDISTRIBUIDOR, FParent.CONEXAO).Execute;
end;

procedure TNegociacaoAprovar.Execute;
begin
  if FParent.NEGOCIACAO <= 0 then
    raise Exception.Create('Código da negociação não pode ser zerado!' + sLineBreak + 'TNegociacaoAprovar.Execute');

  getDADOS;
  getLIMITECREDITO;
  getCOMPROMETIMENTO;
  Validar;
  setAPROVACAO;
end;

end.
