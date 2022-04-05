unit Classe.Negociacoes.Interfaces;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Script,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.Forms,
  System.SysUtils, System.Classes, StrUtils, DateUtils, Data.DB;

type
  TStatus = (stUnknow, stPendente, stAprovada, stConcluida, stCancelada);

  TStatusHelper = record helper for TStatus
    function AsByte: Byte; inline;
    function AsValue: String; inline;
    function Descricao: string; inline;
    function Descritiva: string; inline;
    class function Parse_Value(const Value: String): TStatus; static;
  end;

  INegociacao = interface
    ['{DDC0110C-0869-41A9-B255-FDBA7FB3E96C}']
    function NEGOCIACAO: Integer;
    function CONEXAO: TFDConnection;
    function NEWSTATUS: TStatus;
    function Execute: INegociacao;
  end;

  INegociacaoAprovacao = interface
    ['{97D91BD6-CC52-4AF4-9A1A-F871321EAC19}']
    procedure Execute;
  end;

  INegociacaoCancelamento = interface
    ['{903F2575-6816-493C-B4E7-CFFA6C2F944E}']
    procedure Execute;
  end;

  INegociacaoConclusao = interface
    ['{643B6B16-7DB1-44E0-91EA-A827C1380A6C}']
    procedure Execute;
  end;

  INegociacaoLimiteCredito = interface
    ['{356163A8-AA76-4B47-9553-4AFC8E83DF87}']
    function Execute: Currency;
  end;

implementation

{ TStatusHelper }

function TStatusHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TStatusHelper.AsValue: String;
begin
  case Self of
    stPendente:
      Result := 'PEN';
    stAprovada:
      Result := 'APR';
    stConcluida:
      Result := 'CON';
    stCancelada:
      Result := 'CAN';
  else
    raise Exception.CreateFmt('AsByte [%d] não tratado [function TStatusHelper.AsValue]', [Self.AsByte])
  end;
end;

function TStatusHelper.Descricao: string;
begin
  case Self of
    stPendente:
      Result := 'Pendente';
    stAprovada:
      Result := 'Aprovada';
    stConcluida:
      Result := 'Concluída';
    stCancelada:
      Result := 'Cancelada';
  else
    raise Exception.CreateFmt('Descrição [%d] não tratado [function TStatusHelper.Descricao]', [Self.AsByte]);
  end;
end;

function TStatusHelper.Descritiva: string;
begin
  case Self of
    stAprovada:
      Result := 'Aprovação';
    stConcluida:
      Result := 'Conclusão';
    stCancelada:
      Result := 'Cancelamento';
  else
    raise Exception.CreateFmt('Descritiva [%d] não tratado [function TStatusHelper.Descritiva]', [Self.AsByte]);
  end;
end;

class function TStatusHelper.Parse_Value(const Value: String): TStatus;
begin
  if Value = 'APR' then
    Result := stAprovada
  else if Value = 'PEN' then
    Result := stPendente
  else if Value = 'CON' then
    Result := stConcluida
  else if Value = 'CAN' then
    Result := stCancelada
  else
    raise Exception.CreateFmt('Valor [%s] não tratado [function TStatusHelper.Parse_Value]', [Value]);
end;

end.
