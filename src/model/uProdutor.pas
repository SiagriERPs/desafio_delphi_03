unit uProdutor;

interface

uses
  System.SysUtils;

type
  TProdutor = class
  private
    FID: Integer;
    FNome: string;
    FCPFCNPJ: string;
  public
    constructor Create(ID: Integer; Nome, CPFCNPJ: String);
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;

    function ValidarCNPJ: Boolean;
  end;

implementation

constructor TProdutor.Create(ID: Integer; Nome, CPFCNPJ: String);
begin
  FID := ID;
  FNome := Nome;
  FCPFCNPJ := CPFCNPJ;
end;

function TProdutor.ValidarCNPJ: Boolean;
var
  I, J, Sum, Digit: Integer;
  CNPJArray: array[1..14] of Integer;
  CNPJBase: string;
begin
  // Remove caracteres n�o num�ricos
  CNPJBase := '';
  for I := 1 to Length(FCPFCNPJ) do
    if FCPFCNPJ[I] in ['0'..'9'] then
      CNPJBase := CNPJBase + FCPFCNPJ[I];

  // Verifica se o CNPJ tem 14 d�gitos
  if Length(CNPJBase) <> 14 then
    Exit(False);

  // Converte cada caractere em um n�mero inteiro no array CNPJArray
  for I := 1 to 14 do
    CNPJArray[I] := StrToInt(CNPJBase[I]);

  // Calcula o primeiro d�gito verificador
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
    Exit(False); // Primeiro d�gito verificador inv�lido

  // Calcula o segundo d�gito verificador
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
    Exit(False); // Segundo d�gito verificador inv�lido

  // Se passou por todos os testes, o CNPJ � v�lido
  Result := True;
end;


end.

