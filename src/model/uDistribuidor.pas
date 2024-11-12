unit uDistribuidor;

interface

uses
  System.SysUtils;

type
  TDistribuidor = class
  private
    FID: Integer;
    FNome: string;
    FCNPJ: string;
  public
    constructor Create(ID: Integer; Nome, CNPJ: String);
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property CNPJ: string read FCNPJ write FCNPJ;

    function ValidarCNPJ: Boolean;
  end;

implementation

constructor TDistribuidor.Create(ID: Integer; Nome, CNPJ: String);
begin
  FID := ID;
  FNome := Nome;
  FCNPJ := CNPJ;
end;

function TDistribuidor.ValidarCNPJ: Boolean;
var
  I, J, Sum, Digit: Integer;
  CNPJArray: array[1..14] of Integer;
  CNPJBase: string;
begin
  // Remove caracteres não numéricos
  CNPJBase := '';
  for I := 1 to Length(FCNPJ) do
    if FCNPJ[I] in ['0'..'9'] then
      CNPJBase := CNPJBase + FCNPJ[I];

  // Verifica se o CNPJ tem 14 dígitos
  if Length(CNPJBase) <> 14 then
    Exit(False);

  // Converte cada caractere em um número inteiro no array CNPJArray
  for I := 1 to 14 do
    CNPJArray[I] := StrToInt(CNPJBase[I]);

  // Calcula o primeiro dígito verificador
  Sum := 0;
  J := 5;
  for I := 1 to 12 do
  begin
    Sum := Sum + CNPJArray[I] * J;
    Dec(J);
    if J < 2 then
      J := 9;
  end;
  Digit := (Sum mod 11);
  if Digit < 2 then
    Digit := 0
  else
    Digit := 11 - Digit;

  if CNPJArray[13] <> Digit then
    Exit(False); // Primeiro dígito verificador inválido

  // Calcula o segundo dígito verificador
  Sum := 0;
  J := 6;
  for I := 1 to 13 do
  begin
    Sum := Sum + CNPJArray[I] * J;
    Dec(J);
    if J < 2 then
      J := 9;
  end;
  Digit := (Sum mod 11);
  if Digit < 2 then
    Digit := 0
  else
    Digit := 11 - Digit;

  if CNPJArray[14] <> Digit then
    Exit(False); // Segundo dígito verificador inválido

  // Se passou por todos os testes, o CNPJ é válido
  Result := True;
end;


end.

