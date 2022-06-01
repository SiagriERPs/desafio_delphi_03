unit Funcoes;

interface

uses
 {$IFDEF Win32} Windows, Registry,{$ELSE} WinTypes, WinProcs, {$ENDIF}
  Messages, Classes,  Db, SysUtils, WinSVC,dbclient,inifiles,sconnect,
  winsock, DBCtrls, ComCtrls, StdCtrls, Mask, Variants;

type

  EFalhaImpressao = Class(Exception);

 function NumeroLivre( NomeTabela : string; DataSet, Numeracao : TDataSet) : Integer;
 function Idade( DataNascimento : TDateTime ; hoje : TDateTime) : Real;
 function InsereZeros(Str : String; Numero : Integer) : String;
 function PreencheEspaco(NomeCampo : String; qtd : integer) : string;

 {Função que retorna o diretório System do Windows}
 function GetSystemDir: string;

{ Procedure que executa qualquer Query }
 procedure ExecutaQuery(Query : TDataSet; ParamName : array of string;
                       ParamValue : array of Variant );

 procedure ExecutaQueryR(Query : TClientDataSet; ParamName : array of string;
                       ParamValue : array of Variant );

 procedure ExecutaQueryRsql(Query : TClientDataSet; PSql:string );


 {funcao devolve o dia da semana}
 function DiadaSemana(data:Tdatetime):string;

 {funçao devolve a versao do windows}
 function VersaoWindows:string;

 {funçao devolve a versao do sistema}
 function VersaoSistema:String;


 Function NomeComputador : string;


 procedure LimpaCampo;

 function CNPJFormatado(CNPJ: String):String;

 function RemoveAcento(const Texto: AnsiString): AnsiString;

implementation

uses
  Controls, Forms, Consts, Dialogs, WinSpool, Printers;

Function NomeComputador : string;
var
  NomeComputer : array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  BufSize: DWORD;
begin
  BufSize := SizeOf(NomeComputer);
  GetComputerName (NomeComputer, BufSize);
  NomeComputador := NomeComputer;
end;


function RemoveAcento(const Texto: AnsiString): AnsiString;
const

  Acentos   = 'áéíóúÁÉÍÓÚàèìòùÀÈÌÒÙäëïöüÄËÏÖÜãõÃÕâêîôûÂÊÎÔÛçÇñÑ';
  Normais   = 'aeiouAEIOUaeiouAEIOUaeiouAEIOUaoAOaeiouAEIOUcCnN';
var
  a: Integer;
begin
  Result := '';
  for a := 1 to Length(Texto) do
    if Pos(Texto[a], Acentos) > 0 then
      Result := Result + Normais[Pos(Texto[a], Acentos)]
    else
      Result := Result + Texto[a];
end;

function LeArquivotexto(nomearquivo:string):String;
var
  F: TextFile;
  res , temp: string;
begin
  AssignFile(F, nomearquivo);
  Reset(F);
  res := '';
  while not eof(f) do
  begin
    readln(f,temp);
    res := res + temp;
  end;
  CloseFile(F);
  result := res;
end;



function InsereZeros(Str : String; Numero : Integer) : String;
var
   i : Integer;
begin
     for i := 1 to (Numero-Length(Trim(Str))) do
         Str := '0'+Str;
     InsereZeros := Str;
end;

function PreencheEspaco(NomeCampo : String; qtd : integer) : string;
var
  i, tam :integer;
begin
  tam:=Length(NomeCampo);
  if qtd > tam
    then
      for i:= tam to qtd-1 do
        NomeCampo:=NomeCampo+' '
    else
      if qtd < tam
        then
          NomeCampo:=copy(NomeCampo,1,qtd);
  Result:=NomeCampo
end;

function Idade( DataNascimento : TDateTime ; hoje : TDateTime ) : Real;
var
   Dia, Mes, Ano : word;
   DiaH, MesH, AnoH : word;
   UltimoAniversario : TDateTime;
begin
  try
     DecodeDate( DataNascimento, Ano, Mes, Dia );
     DecodeDate( hoje, AnoH, MesH, DiaH );
     if ((AnoH = Ano) AND (MesH >= Mes)) OR
        ((AnoH = Ano + 1) AND ((MesH < Mes) OR ((MesH = Mes) AND (DiaH < Dia)))) then
        UltimoAniversario := DataNascimento
     else if (AnoH > Ano) then begin
             if (MesH < Mes) OR (MesH = Mes) And (DiaH < Dia) then
                UltimoAniversario := EncodeDate( AnoH-1, Mes, Dia )
             else
                 UltimoAniversario := EncodeDate( AnoH, Mes, Dia );
     end else begin
         Result := -1;
         Exit;
     end;
     Dia := Trunc(UltimoAniversario - DataNascimento);
     Ano := Dia div 365;
     Dia := Trunc(Date - UltimoAniversario) + Dia mod 365;
     Mes := Dia div 30;
     Dia := Dia mod 30;
     Result := Ano * 256 + Mes + Dia / 100;
  except
        DecodeDate(DataNascimento, Ano, Mes, Dia );
        DecodeDate(Date, AnoH, MesH, DiaH );
        Result := AnoH-Ano;
  end;
end;

    function GetSystemDir: string;
    {$IFDEF WIN32}
    var
      Buffer: array[0..1023] of Char;
    begin
      SetString(Result, Buffer, GetSystemDirectory(Buffer, SizeOf(Buffer)));
    {$ELSE}
    begin
      Result[0] := Char(GetSystemDirectory(@Result[1], 254));
    {$ENDIF}
    end;


function NumeroLivre( NomeTabela : string; DataSet, Numeracao : TDataSet) : Integer;
var
   NroLivre   : Integer;
begin
   NroLivre := 0;

   if (Numeracao is TClientDataset) then
   begin
     with (Numeracao As TClientDataset) do begin
          ExecutaQuery((Numeracao As TClientDataset), ['NomeTabela'], [NomeTabela]);

          if FieldByName('NMRNUMEROLIVRE').AsInteger <> 0 then
             while NroLivre = 0 do
                   try
                      Edit;
                      NroLivre := FieldByName('NMRNUMEROLIVRE').AsInteger;
                      FieldByName('NMRNUMEROLIVRE').AsInteger := NroLivre + 1;
                      Post;
                      ApplyUpdates(-1);
                   except
                      CancelUpdates;
                      Close;
                      NroLivre := 0;
                      Result := NroLivre;
                      Exit;
                   end;
          Result := NroLivre;
          Close;
     end;
   end;


end;


procedure ExecutaQuery( Query : TDataSet; ParamName : array of string;
                                                    ParamValue : array of Variant );
var
   i       : Integer;
   Nome    : string;
   SQLText : string;
begin
     if (query is TClientDataset) then
     begin
       with (Query as TClientDataset) do try
              if Active then Close;
              Screen.Cursor := crHourGlass;
              for i := Low(ParamName) to High(ParamName) do begin
                  Nome := ParamName[i];
                  case Params.ParamByName(Nome).DataType of
                       ftBCD      : Params.ParamByName(Nome).AsBCD := ParamValue[i];
                       ftBoolean  : Params.ParamByName(Nome).AsBoolean := ParamValue[i];
                       ftCurrency : Params.ParamByName(Nome).AsCurrency := ParamValue[i];
                       ftDate     : Params.ParamByName(Nome).AsDate := ParamValue[i];
                       ftDateTime : Params.ParamByName(Nome).AsDateTime := ParamValue[i];
                       ftInteger  : Params.ParamByName(Nome).AsInteger := ParamValue[i];
                       ftFloat    : Params.ParamByName(Nome).AsFloat := ParamValue[i];
                       ftSmallint : Params.ParamByName(Nome).AsSmallInt := ParamValue[i];
                       ftString   : Params.ParamByName(Nome).AsString := ParamValue[i];
                       ftTime     : Params.ParamByName(Nome).AsTime := ParamValue[i];
                       ftWord     : Params.ParamByName(Nome).AsWord := ParamValue[i];
                  end;
              end;
              Open;
            except
                   Screen.Cursor := crDefault;
                   raise;
            end;
            Screen.Cursor := crDefault;
     end;

     Screen.Cursor := crDefault;

end;


procedure ExecutaQueryR(Query : TClientDataSet; ParamName : array of string;
                       ParamValue : array of Variant );
var
   i       : Integer;
   Nome    : string;

begin

      with Query  do
      try
        try
          if not query.RemoteServer.Connected
          then try
                 query.RemoteServer.Connected := true;
               except
                 showmessage('Erro. Não foi possivel conectar ao servidor ');
                 raise;
               end;
          if Active then Close;
          Screen.Cursor := crHourGlass;
          for i := Low(ParamName) to High(ParamName) do
          begin
            Nome := ParamName[i];
            case Params.ParamByName(Nome).DataType of
                         ftBCD      : Params.ParamByName(Nome).AsBCD := ParamValue[i];
                         ftBoolean  : Params.ParamByName(Nome).AsBoolean := ParamValue[i];
                         ftCurrency : Params.ParamByName(Nome).AsCurrency := ParamValue[i];
                         ftDate     : Params.ParamByName(Nome).AsDate := ParamValue[i];
                         ftDateTime : Params.ParamByName(Nome).AsDateTime := ParamValue[i];
                         ftInteger  : Params.ParamByName(Nome).AsInteger := ParamValue[i];
                         ftFloat    : Params.ParamByName(Nome).AsFloat := ParamValue[i];
                         ftSmallint : Params.ParamByName(Nome).AsSmallInt := ParamValue[i];
                         ftString   : Params.ParamByName(Nome).AsString := ParamValue[i];
                         ftTime     : Params.ParamByName(Nome).AsTime := ParamValue[i];
                         ftWord     : Params.ParamByName(Nome).AsWord := ParamValue[i];
            end;
          end;
          Open;
        except
           raise;
        end;
      finally
        Screen.Cursor := crDefault;
        query.RemoteServer.Connected := false;
      end;
end;

procedure ExecutaQueryRsql(Query : TClientDataSet; PSql:string );
var
   i       : Integer;
   Nome    : string;

begin

      with Query  do
      try
        try
          Screen.Cursor := crHourGlass;
          if (query.RemoteServer <> nil) and (not query.RemoteServer.Connected)
          then try
                 query.RemoteServer.Connected := true;
               except
                 showmessage('Erro. Não foi possivel conectar ao servidor ');
                 raise;
               end;
          if Active then Close;
          query.CommandText := PSQL;

          Open;
        except
           raise;
        end;
      finally
        Screen.Cursor := crDefault;
        if (query.RemoteServer <> nil) then
            query.RemoteServer.Connected := false;
      end;
end;



function DiadaSemana(data:Tdatetime):string;
var
  dias : array[1..7] of string;
begin
  dias[1] := 'Domingo';
  dias[2] := 'Segunda';
  dias[3] := 'Terça';
  dias[4] := 'Quarta';
  dias[5] := 'Quinta';
  dias[6] := 'Sexta';
  dias[7] := 'Sabado';
  DiadaSemana := dias[DayOfWeek(data)];
end;

function VersaoSistema:String;

    procedure GetBuildInfo(var V1, V2, V3, V4: Word);
    var
       VerInfoSize,
       VerValueSize,
       Dummy       : DWORD;
       VerInfo         : Pointer;
       VerValue        : PVSFixedFileInfo;
    begin
         VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
         GetMem(VerInfo, VerInfoSize);
         GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
         VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
         With VerValue^ do begin
              V1 := dwFileVersionMS shr 16;
              V2 := dwFileVersionMS and $FFFF;
              V3 := dwFileVersionLS shr 16;
              V4 := dwFileVersionLS and $FFFF;
         end;
         FreeMem(VerInfo, VerInfoSize);
    end;

var
  V1, V2, V3, V4: Word;
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' +
            IntToStr(V2) + '.' +
            IntToStr(V3) + '.' +
            IntToStr(V4);
end;

function VersaoWindows:string;
var
  verInfoS : TOsVersionInfo;
  str : String;
begin
  try
    str := '';
    verInfoS.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    if GetVersionEx(verInfoS) then begin
      str := str+'SO:';
      case verInfos.dwPlatformId of
        VER_PLATFORM_WIN32s : str := str +'Windows 95';
        VER_PLATFORM_WIN32_WINDOWS : str := str +'Windows 95 Osr2 / 98';
        VER_PLATFORM_WIN32_NT : str := str +'Windows NT';
      end;
      str := str+'  | Versão:'+ IntToStr(verInfos.dwMajorVersion) +   IntToStr(verInfos.dwMinorVersion);
      str := str+'  | Compilação:'+IntToStr(verInfos.dwBuildNumber);

    end;
    VersaoWindows := str;
  except
    VersaoWindows := 'ERRO';
  end;
end;


//limpa os campos que não estão relacionados com algum datasource.
procedure LimpaCampo;
var i : Integer;
begin
  with Screen.Forms[0] do
    for i := 0 to ComponentCount - 1 do begin
       if (Components[i] is TDBEdit)
         then (Components[i] as TDBEdit).Clear;
       if (Components[i] is TMaskEdit)
         then (Components[i] as TMaskEdit).Clear;
       if (Components[i] is TEdit)
         then (Components[i] as TEdit).Clear;

    end;
end;


function CNPJFormatado(CNPJ: String):String;
begin
  CNPJFormatado := Copy(CNPJ, 1, 2) + '.' + Copy(CNPJ, 3, 3) + '.' +
                   Copy(CNPJ, 6, 3) + '/' + Copy(CNPJ, 9, 4) + '-' +
                   Copy(CNPJ, 13, 2);
end;


end.
