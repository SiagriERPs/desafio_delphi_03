unit Funcoes;

interface

uses UDM;

function VerificarProxID(const NomeTabela: string): integer;
function ObterValorDecimal(const Valor: string): boolean;
function ObterValorInteiro(const Valor: string): Double;

implementation

uses
  System.SysUtils;

{ TFuncoes }

function VerificarProxID(const NomeTabela: string): integer;
var
  sSQL: string;
begin
  sSQL := 'select MAX(id_' + NomeTabela + ') as ultimo_id from ' + NomeTabela;
  DM.QueryAux.Close;
  DM.QueryAux.SQL.Clear;
  DM.QueryAux.SQL.Add(sSQL);
  DM.QueryAux.Open;
  try
    Result := DM.QueryAux.FieldByName('ultimo_id').AsInteger + 1;
  finally
    DM.QueryAux.Close;
  end;
end;

function ObterValorDecimal(const Valor: string): boolean;
var
  PosVirgula: Integer;
begin
  // Encontra a posição da vírgula na string
  PosVirgula := Pos(',', Valor);

  if PosVirgula > 0 then
  begin
    if StrToInt(Copy(Valor, PosVirgula + 1, Length(Valor) - PosVirgula)) > 0 then
    begin
      Result := True;
    end
    else
      Result := False;
  end;
end;

function ObterValorInteiro(const Valor: string): Double;
var
  PosVirgula: Integer;
  ValorStr : string;
begin
  // Encontra a posição da vírgula na string
  PosVirgula := Pos(',', Valor);

  if PosVirgula > 0 then
  begin

    ValorStr := StringReplace((Copy(Valor, 1, PosVirgula - 1)), '.', '', [rfReplaceAll]); // Remover pontos
    ValorStr := Trim(ValorStr); // Remover espaços em branco no início e no fim
    Result := StrToFloat(ValorStr);
  end;
end;

end.
