unit Classe.Negociacoes.Negociacao;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Script,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.Forms,
  System.SysUtils, System.Classes, StrUtils, DateUtils, Data.DB,
  Classe.Negociacoes.Interfaces,
  Classe.Negociacoes.Aprovar,
  Classe.Negociacoes.Concluir,
  Classe.Negociacoes.Cancelar;

type
  TNegociacao = class(TInterfacedObject, INegociacao)
  private
    { private declarations }
    FNEGOCIACAO: Integer;
    FCONEXAO: TFDConnection;
    FSTATUS: TStatus;
  protected
    { protected declarations }

  public
    { public declarations }

    constructor Create(const IDNEGOCIACAO: Integer; const NEWSTATUS: TStatus; CONEXAO: TFDConnection);
    destructor Destroy; override;
    class function New(const IDNEGOCIACAO: Integer; const NEWSTATUS: TStatus; CONEXAO: TFDConnection): INegociacao;
    function NEGOCIACAO: Integer;
    function CONEXAO: TFDConnection;
    function NEWSTATUS: TStatus;
    function Execute: INegociacao;
  end;

implementation

{ TNegociacao }

class function TNegociacao.New(const IDNEGOCIACAO: Integer; const NEWSTATUS: TStatus; CONEXAO: TFDConnection): INegociacao;
begin
  Result := Self.Create(IDNEGOCIACAO, NEWSTATUS, CONEXAO);
end;

constructor TNegociacao.Create(const IDNEGOCIACAO: Integer; const NEWSTATUS: TStatus; CONEXAO: TFDConnection);
begin
  FNEGOCIACAO := IDNEGOCIACAO;
  FSTATUS := NEWSTATUS;
  FCONEXAO := CONEXAO;
end;

function TNegociacao.Negociacao: Integer;
begin
  Result := FNEGOCIACAO;
end;

function TNegociacao.CONEXAO: TFDConnection;
begin
  Result := FCONEXAO;
end;

function TNegociacao.NEWSTATUS: TStatus;
begin
  Result := FSTATUS;
end;

destructor TNegociacao.Destroy;
begin
  inherited;
end;

function TNegociacao.Execute: INegociacao;
begin
  Result := Self;

  if FNEGOCIACAO <= 0 then
    raise Exception.Create('Código da negociação não pode ser zerado!' + sLineBreak + 'TNegociacao.Execute');

  case FSTATUS of
    stAprovada:
      begin
        TNegociacaoAprovar.New(Self).Execute;
      end;
    stCancelada:
      begin
        TNegociacaoCancelar.New(Self).Execute;
      end;
    stConcluida:
      begin
        TNegociacaoConcluir.New(Self).Execute;
      end;
  else
    raise Exception.Create('Status ainda não tratado!' + sLineBreak + 'TNegociacao.Execute');
  end;
end;

end.
