unit GETFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, IniFiles, ScktComp, System.Variants, System.Classes, Vcl.Graphics, Controls, Forms,
  Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  ShellAPI, RegularExpressions, ACBrValidador, FireDAC.Comp.Client, Vcl.ActnMan, Vcl.ActnList,
  System.Notification, FireDAC.Stan.Param, cxPC, dxAlertWindow, Vcl.WinXCtrls, FireDAC.Phys.IBBase, FireDAC.Phys.IBWrapper,
  FireDAC.Phys.Intf, ActiveX, System.UITypes, Classe.Mensagem;

{ Procedures }

procedure AbreForm(pClasse: TFormClass; pConsulta, pShowModal: Boolean; var pForm);
function ChecaCampos(Dataset: TDataSet): Boolean;
function SoNumeros(const Texto: string): string;
function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
function FormatarTelefone(Telefone: string): string;
function FormataCPF_CNPJ(CPF_CNPJ: string): string;
function FormataCNPJ(CNPJ: string): string;
function FormataCPF(CPF: string): string;
function SoLetra(Texto: string): Boolean;
function BuscaAux(Tabela, Retorno, Campo_Chave, Valor_CampoChave: string; Conexao: TFDConnection; ExibeMsgErro: Boolean = True): string;
function FormataNome(sNome: string): string;
procedure CentralizarFormulario(var pForm);

implementation

uses
  uNotificacao, Winapi.TlHelp32, System.DateUtils, System.Win.Registry, ConexaoDB;

function SoNumeros(const Texto: string): string;
var
  I: Integer;
  S: string;
begin
  S := '';
  for I := 1 to Length(Texto) do
  begin
    if (CharInSet(Texto[I], ['0' .. '9'])) then
      S := S + Copy(Texto, I, 1);
  end;
  Result := Trim(S);
end;

function ChecaCampos(Dataset: TDataSet): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Dataset.Fields.Count - 1 do
  begin
    if (Dataset.Fields[I].Tag = 10) and (Dataset.Fields[I].text.Trim.IsEmpty) then
    begin
      TMensagem.New('Aliare Cadastros!', 'O campo ' + (Dataset.Fields[I].DisplayName) + ' deve ser preenchido.').Execute;
      (Dataset.Fields[I].FocusControl);
      Result := False;
      Break;
    end;
  end;
end;

procedure AbreForm(pClasse: TFormClass; pConsulta, pShowModal: Boolean; var pForm);
begin
  if pConsulta then
    vgs_TELA := TTipoTela.tpConsulta
  else
    vgs_TELA := TTipoTela.tpCadastro;

  if (pConsulta) or (pShowModal) then
  begin
    if not Assigned(TForm(pForm)) then
      Application.CreateForm(pClasse, pForm);

    if (TForm(pForm).FormStyle = fsMDIChild) or (TForm(pForm).Visible) then
    begin
      TForm(pForm).FormStyle := fsNormal;
      TForm(pForm).Visible := False;
    end;
    TForm(pForm).ShowModal;
  end
  else
  begin
    if not Assigned(TForm(pForm)) then
      Application.CreateForm(pClasse, pForm);
    TForm(pForm).Show;
  end;
end;

function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
begin
  if Expressao then
    Result := ParteTRUE
  else
    Result := ParteFALSE;
end;

function FormatarTelefone(Telefone: string): string;
var
  Tammanho: Integer;
  NumeroTelefone: string;
begin
  Result := '';
  if Trim(Telefone) <> '' then
  begin
    NumeroTelefone := SoNumeros(Telefone);
    Tammanho := Length(NumeroTelefone);
    case Tammanho of
      8:
        Result := Copy(NumeroTelefone, 1, 4) + '-' + Copy(NumeroTelefone, 5, 4);
      9:
        Result := Copy(NumeroTelefone, 1, 5) + '-' + Copy(NumeroTelefone, 6, 4);
      10:
        Result := '(' + Copy(NumeroTelefone, 1, 2) + ')' + Copy(NumeroTelefone, 3, 4) + '-' + Copy(NumeroTelefone, 7, 4);
      11:
        Result := '(' + Copy(NumeroTelefone, 1, 2) + ')' + Copy(NumeroTelefone, 3, 5) + '-' + Copy(NumeroTelefone, 8, 4);
    else
      Result := NumeroTelefone;
    end;
  end;
end;

function FormataCPF_CNPJ(CPF_CNPJ: string): string;
begin
  if CPF_CNPJ.Trim.IsEmpty then
    exit(string.Empty);

  if Length(Trim(CPF_CNPJ)) > 11 then
    Result := FormataCNPJ(Trim(CPF_CNPJ))
  else
    Result := FormataCPF(Trim(CPF_CNPJ));
end;

function FormataCNPJ(CNPJ: string): string;
begin
  Result := Copy(CNPJ, 1, 2) + '.' + Copy(CNPJ, 3, 3) + '.' + Copy(CNPJ, 6, 3) + '/' + Copy(CNPJ, 9, 4) + '-' + Copy(CNPJ, 13, 2);
end;

function FormataCPF(CPF: string): string;
begin
  Result := Copy(CPF, 1, 3) + '.' + Copy(CPF, 4, 3) + '.' + Copy(CPF, 7, 3) + '-' + Copy(CPF, 10, 2);
end;

function SoLetra(Texto: string): Boolean;
var
  nContador: Integer;
begin
  Result := True;
  for nContador := 1 to Length(Texto) do
  begin
    if not(CharInSet(Texto[nContador], ['a' .. 'z', 'A' .. 'Z'])) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function BuscaAux(Tabela, Retorno, Campo_Chave, Valor_CampoChave: string;
  Conexao: TFDConnection; ExibeMsgErro: Boolean = True): string;
var
  Q: TFDQuery;
  sErro: string;
begin
  if not(Assigned(Conexao)) then
  begin
    TMensagem.New('SysVenda Busca!', 'Não foi passado o componente de conexão com banco na função Busca Aux.' + sLineBreak +
      'Tabela da consulta: ' + Tabela + sLineBreak +
      'Campo chave da consulta: ' + Campo_Chave + sLineBreak +
      'Local do erro: GetFuncoes.BuscaAux').Execute;
    Abort;
  end;

  Q := TFDQuery.Create(nil);
  try

    Q.Connection := Conexao;
    try
      Q.SQL.text := Format('select %s as retorno from %s where %s = %s', [Retorno, Tabela, Campo_Chave, Valor_CampoChave]);
      Q.Open();
      if not Q.IsEmpty then
      begin
        Result := Trim(Q.FieldByName('retorno').AsString);
        Q.Close;
      end
      else if (ExibeMsgErro) then
      begin
        Q.Close;

        var
        _Mensagem := Format('Não foi possível localizar dados na tabela %s com o conteúdo informado no campo %s',
          [UpperCase(Tabela), UpperCase(Campo_Chave)]);

        TMensagem.New('Aliare Busca!', _Mensagem).Execute;
        Abort;
      end;
    except
      on Erro: Exception do
      begin
        sErro := Erro.Message;
        Abort;
      end;
    end;
  finally
    FreeAndNil(Q);
  end;
end;

function FormataNome(sNome: string): string;
const
  excecao: array [0 .. 5] of string = (' da ', ' de ', ' do ', ' das ', ' dos ', ' e ');
var
  Tamanho, J: Integer;
  I: Byte;
begin
  Result := AnsiLowerCase(sNome);
  Tamanho := Length(Result);

  for J := 1 to Tamanho do // Se é a primeira letra ou se o caracter anterior é um espaço
    if (J = 1) or ((J > 1) and (Result[J - 1] = chr(32))) then
      Result[J] := AnsiUpperCase(Result[J])[1];
  for I := 0 to Length(excecao) - 1 do
    Result := StringReplace(Result, excecao[I], excecao[I], [rfReplaceAll, rfIgnoreCase]);
end;

procedure CentralizarFormulario(var pForm);
begin
  TForm(pForm).left := (Screen.Width div 2) - (TForm(pForm).Width div 2);
  TForm(pForm).Top := (Screen.Height div 2) - (TForm(pForm).Height div 2);
end;

end.
