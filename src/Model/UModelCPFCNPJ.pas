unit UModelCPFCNPJ;

interface

uses sysutils;

type
  TModelCPFCNPJ = class

  private
    FCPF_CNPJ   : String;

    function isValidCnpj  : Boolean;
    function isValidCpf   : Boolean;
    function GetStrNumber(const S: string) : String;
  protected
  public
    property CPF_CNPJ     : String read FCPF_CNPJ   write FCPF_CNPJ;
    function formatar     : String;

  end;

implementation

{ TModelCPFCNPJ }

function TModelCPFCNPJ.formatar: String;
begin
  result:= '';
  FCPF_CNPJ := GetStrNumber(FCPF_CNPJ);
  if Length(FCPF_CNPJ) <> 0 then
    if Length(FCPF_CNPJ) = 14 then
    Begin
      if isValidCnpj = True Then
      Begin
        Result :=  Copy(FCPF_CNPJ, 1,2)
        + '.' + Copy(FCPF_CNPJ, 3,3)
        +'.' + Copy(FCPF_CNPJ, 6,3)
        + '/' +Copy(FCPF_CNPJ, 9,4)
        + '-' + Copy(FCPF_CNPJ, 13,2);
      End
      else
        Result := 'INVALIDO';
    end
    Else
    if Length(FCPF_CNPJ) = 11 then
    Begin
      if isValidCpf = True Then
      Begin
        Result := Copy(FCPF_CNPJ, 1,3)
        + '.' + Copy(FCPF_CNPJ, 4,3)
        + '.' + Copy(FCPF_CNPJ,7,3)
        + '-' + Copy(FCPF_CNPJ, 10,2);
      End
      Else
        Result := 'INVALIDO';
    End
    Else
      Result := 'INVALIDO';
end;


function TModelCPFCNPJ.GetStrNumber(const S: string): String;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

function TModelCPFCNPJ.isValidCnpj: Boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12: integer;
  d1,d2: integer;
  num: string;
  digitado, calculado: string;
begin
  num := GetStrNumber(FCPF_CNPJ);
  n1:=StrToInt(num[1]);
  n2:=StrToInt(num[2]);
  n3:=StrToInt(num[3]);
  n4:=StrToInt(num[4]);
  n5:=StrToInt(num[5]);
  n6:=StrToInt(num[6]);
  n7:=StrToInt(num[7]);
  n8:=StrToInt(num[8]);
  n9:=StrToInt(num[9]);
  n10:=StrToInt(num[10]);
  n11:=StrToInt(num[11]);
  n12:=StrToInt(num[12]);
  d1:=n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+n4*2+n3*3+n2*4+n1*5;
  d1:=11-(d1 mod 11);
  if d1>=10 then
    d1:=0;
  d2:=d1*2+n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+n5*2+n4*3+n3*4+n2*5+n1*6;
  d2:=11-(d2 mod 11);
  if d2>=10 then
    d2:=0;
  calculado:= IntToStr(d1)+inttostr(d2);
  digitado:=num[13]+num[14];
  if calculado=digitado then
    Result := true
  else
    Result := false;
end;


function TModelCPFCNPJ.isValidCpf: Boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
  d1,d2: integer;
  num: String;
  digitado, calculado: string;
begin
  num := GetStrNumber(FCPF_CNPJ);
  n1:=StrToInt(num[1]);
  n2:=StrToInt(num[2]);
  n3:=StrToInt(num[3]);
  n4:=StrToInt(num[4]);
  n5:=StrToInt(num[5]);
  n6:=StrToInt(num[6]);
  n7:=StrToInt(num[7]);
  n8:=StrToInt(num[8]);
  n9:=StrToInt(num[9]);
  d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:=11-(d1 mod 11);
  if d1>=10 then
    d1:=0;
  d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
  d2:=11-(d2 mod 11);
  if d2>=10 then
    d2:=0;
  calculado:=inttostr(d1)+inttostr(d2);
  digitado:=num[10]+num[11];
  if calculado=digitado then
    Result:=true
  else
    Result:=false;
end;

end.
