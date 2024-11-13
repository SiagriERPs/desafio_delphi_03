unit uStatusModel;

interface

uses
  uEnumerado;

type
  TStatusModel = class
  private
    FNegociacaoId : Integer;
    FStatusAtual  : TStatus;
  public
    property NegociacaoId : Integer read FNegociacaoId write FNegociacaoId;
    property StatusAtual  : TStatus read FStatusAtual  write FStatusAtual;

    function Aprovar  : Boolean;
    function Concluir : Boolean;
    function Cancelar : Boolean;
  end;

implementation

{ TStatusModel }

function TStatusModel.Aprovar: Boolean;
begin
  if FStatusAtual = TStatus.Pendente then
  begin
    FStatusAtual := TStatus.Aprovada;
    Result       := True;
  end
  else
    Result := False;
end;

function TStatusModel.Concluir: Boolean;
begin
  if FStatusAtual = TStatus.Aprovada then
  begin
    FStatusAtual := TStatus.Concluida;
    Result       := True;
  end
  else
    Result := False;
end;

function TStatusModel.Cancelar: Boolean;
begin
  if FStatusAtual <> TStatus.Concluida then
  begin
    FStatusAtual := TStatus.Cancelada;
    Result       := True;
  end
  else
    Result := False;
end;


end.
