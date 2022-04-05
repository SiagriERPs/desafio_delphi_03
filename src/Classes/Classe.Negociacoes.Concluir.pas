unit Classe.Negociacoes.Concluir;

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

  TNegociacaoConcluir = class(TInterfacedObject, INegociacaoConclusao)
  private
    { private declarations }
    FParent: INegociacao;
    FSTATUS: TStatus;

    procedure getSTATUS;
    procedure Validar;
    procedure setCONCLUSAO;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(Parent: INegociacao);
    destructor Destroy; override;
    class function New(Parent: INegociacao): INegociacaoConclusao;
    procedure Execute;
  end;

implementation

{ TNegociacaoConcluir }

class function TNegociacaoConcluir.New(Parent: INegociacao): INegociacaoConclusao;
begin
  Result := Self.Create(Parent);
end;

procedure TNegociacaoConcluir.Validar;
begin
  if FSTATUS = TStatus.stConcluida then
    raise Exception.Create('Negociação já está concluída.');

  if (FSTATUS <> TStatus.stAprovada) then
    raise Exception.Create('Não é possível concluir negociação!' + sLineBreak + 'Status não está APROVADA.');
end;

procedure TNegociacaoConcluir.setCONCLUSAO;
begin
  var
  QryUpdate := TFDQuery.Create(nil);
  try
    try
      QryUpdate.Connection := FParent.CONEXAO;
      QryUpdate.SQL.Add('update NEGOCIACOES set STATUS = :STATUS, DATA_CONCLUSAO = :DATA');
      QryUpdate.SQL.Add('where ID = :ID');
      QryUpdate.ParamByName('STATUS').AsString := TStatus.stConcluida.AsValue;
      QryUpdate.ParamByName('DATA').AsDate := Date;
      QryUpdate.ParamByName('ID').AsInteger := FParent.NEGOCIACAO;
      QryUpdate.ExecSQL;
    except
      on e: Exception do
      begin
        raise Exception.Create('Erro ao concluir negociação!' + sLineBreak + e.Message);
      end;
    end;
  finally
    QryUpdate.Close;
    FreeAndNil(QryUpdate);
  end;
end;

constructor TNegociacaoConcluir.Create(Parent: INegociacao);
begin
  FParent := Parent;
end;

destructor TNegociacaoConcluir.Destroy;
begin
  inherited;
end;

procedure TNegociacaoConcluir.Execute;
begin
  if FParent.NEGOCIACAO <= 0 then
    raise Exception.Create('Código da negociação não pode ser zerado!' + sLineBreak + 'TNegociacaoConcluir.Execute');

  getSTATUS;
  Validar;
  setCONCLUSAO;
end;

procedure TNegociacaoConcluir.getSTATUS;
begin
  FSTATUS := TStatus.Parse_Value(FParent.CONEXAO.ExecSQLScalar(Format('select STATUS from NEGOCIACOES where ID = %d',
    [FParent.NEGOCIACAO])));
end;

end.
