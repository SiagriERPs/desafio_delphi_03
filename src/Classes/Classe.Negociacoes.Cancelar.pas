unit Classe.Negociacoes.Cancelar;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Script,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.Forms, System.SysUtils, System.Classes, StrUtils, DateUtils, Data.DB,
  Classe.Negociacoes.Interfaces;

type

  TNegociacaoCancelar = class(TInterfacedObject, INegociacaoCancelamento)
  private
    { private declarations }
    FParent: INegociacao;
    FSTATUS: TStatus;

    procedure getSTATUS;
    procedure Validar;
    procedure setCANCELAMENTO;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(Parent: INegociacao);
    destructor Destroy; override;
    class function New(Parent: INegociacao): INegociacaoCancelamento;
    procedure Execute;
  end;

implementation

{ TNegociacaoCancelar }

class function TNegociacaoCancelar.New(Parent: INegociacao): INegociacaoCancelamento;
begin
  Result := Self.Create(Parent);
end;

procedure TNegociacaoCancelar.Validar;
begin
  if FSTATUS = TStatus.stCancelada then
    raise Exception.Create('Negociação já está cancelada.');

  if not(FSTATUS in [TStatus.stPendente, TStatus.stAprovada]) then
    raise Exception.CreateFmt('Não foi possível cancelar negociação!' + sLineBreak + 'Status está %s.', [FSTATUS.Descricao.ToUpper]);
end;

procedure TNegociacaoCancelar.setCANCELAMENTO;
begin
  var
  QryUpdate := TFDQuery.Create(nil);
  try
    try
      QryUpdate.Connection := FParent.CONEXAO;
      QryUpdate.SQL.Add('update NEGOCIACOES set STATUS = :STATUS, DATA_CANCELAMENTO = :DATA');
      QryUpdate.SQL.Add('where ID = :ID');
      QryUpdate.ParamByName('STATUS').AsString := TStatus.stCancelada.AsValue;
      QryUpdate.ParamByName('DATA').AsDate := Date;
      QryUpdate.ParamByName('ID').AsInteger := FParent.NEGOCIACAO;
      QryUpdate.ExecSQL;
    except
      on e: Exception do
      begin
        raise Exception.Create('Erro ao cancelar negociação!' + sLineBreak + e.Message);
      end;
    end;
  finally
    QryUpdate.Close;
    FreeAndNil(QryUpdate);
  end;
end;

constructor TNegociacaoCancelar.Create(Parent: INegociacao);
begin
  FParent := Parent;
end;

destructor TNegociacaoCancelar.Destroy;
begin
  inherited;
end;

procedure TNegociacaoCancelar.Execute;
begin
  if FParent.NEGOCIACAO <= 0 then
    raise Exception.Create('Código da negociação não pode ser zerado!' + sLineBreak + 'TNegociacaoCancelar.Execute');

  getSTATUS;
  Validar;
  setCANCELAMENTO;
end;

procedure TNegociacaoCancelar.getSTATUS;
begin
  FSTATUS := TStatus.Parse_Value(FParent.CONEXAO.ExecSQLScalar(Format('select STATUS from NEGOCIACOES where ID = %d', [FParent.NEGOCIACAO])));
end;

end.
