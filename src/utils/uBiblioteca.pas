unit uBiblioteca;

interface

uses
  vcl.Forms,
  StrUtils,
  System.SysUtils,
  System.Classes,
  uEnumerado;

  procedure CreateForm(T: TComponentClass; Form: TForm);

  function SetEditMask(pIndex: Integer): string;
  function GetStringStatus(pStatus: TStatus): string;
  function ValidaCNPJ(pCNPJ: string): Boolean;
  function ValidaCPF(pCPF: string): Boolean;

implementation

procedure CreateForm(T: TComponentClass; Form: TForm);
begin
  Application.CreateForm(T, Form);

  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

function SetEditMask(pIndex: Integer): string;
begin
  case pIndex of
    0 : Result := '000.000.000-00';
    1 : Result := '00.000.000/0000-00';
  else
    Result := '';
  end;
end;

function GetStringStatus(pStatus: TStatus): string;
begin
  case pStatus of
    TStatus.Pendente: Result  := 'Pendente';
    TStatus.Aprovada: Result  := 'Aprovada';
    TStatus.Concluida: Result := 'Concluida';
    TStatus.Cancelada: Result := 'Cancelada';
  else
    Result := 'Status Desconhecido';
  end;
end;

function ValidaCNPJ(pCNPJ: string): Boolean;
var  D1 : array[1..12] of byte;
     I,
     DF1,
     DF2,
     DF3,
     DF4,
     DF5,
     DF6,
     Resto1,
     Resto2,
     PrimeiroDigito,
     SegundoDigito : integer;
begin
  Result := true;
  if Length(pCNPJ) = 14 then
  begin
    for I := 1 to 12 do
       if CharInSet(pCNPJ[I], ['0'..'9']) then
         D1[I] := StrToInt(pCNPJ[I])
       else
         Result := false;

    if Result then
    begin

      DF1 := 5*D1[1] + 4*D1[2] + 3*D1[3] + 2*D1[4] + 9*D1[5] + 8*D1[6] +
             7*D1[7] + 6*D1[8] + 5*D1[9] + 4*D1[10] + 3*D1[11] + 2*D1[12];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
           PrimeiroDigito := 0
      else
           PrimeiroDigito := 11 - Resto1;
      DF4 := 6*D1[1] + 5*D1[2] + 4*D1[3] + 3*D1[4] + 2*D1[5] + 9*D1[6] +
             8*D1[7] + 7*D1[8] + 6*D1[9] + 5*D1[10] + 4*D1[11] + 3*D1[12] +
             2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;
      if (PrimeiroDigito <> StrToInt(pCNPJ[13])) or
        (SegundoDigito <> StrToInt(pCNPJ[14])) then
        Result := false;
    end;
  end
  else
  if Length(pCNPJ) <> 0 then
    Result := false;
end;

function ValidaCPF(pCPF: string): Boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9:integer;
  d1,d2:integer;
  digitado, calculado:string;
begin
  n1:= StrToInt(pCPF[1]);
  n2:= StrToInt(pCPF[2]);
  n3:= StrToInt(pCPF[3]);
  n4:= StrToInt(pCPF[4]);
  n5:= StrToInt(pCPF[5]);
  n6:= StrToInt(pCPF[6]);
  n7:= StrToInt(pCPF[7]);
  n8:= StrToInt(pCPF[8]);
  n9:= StrToInt(pCPF[9]);
  d1:= n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:= 11-(d1 mod 11);
  if d1>=10 then d1:=0;
    d2:= d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
  d2:= 11-(d2 mod 11);
  if d2>=10 then d2:=0;
    calculado:= inttostr(d1)+inttostr(d2);
  digitado:= pCPF[10]+pCPF[11];
  if calculado = digitado then
    ValidaCPF:=true
  else
    ValidaCPF:=false;
end;

end.
