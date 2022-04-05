unit Classe.Mensagem;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Script,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.Forms,
  System.SysUtils, System.Classes, StrUtils, DateUtils, Data.DB, uNotificacao;

type

  IMensagem = interface
    ['{07666AC2-1B9F-4A0D-9FD6-3E3D9B759962}']
    function Execute: Boolean;
  end;

  TMensagem = class(TInterfacedObject, IMensagem)
  private
    { private declarations }
    FTITULO: string;
    FMENSAGEM: string;
    FPERGUNTA: Boolean;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(pTitulo, pMensagem: string; pPergunta: Boolean = False);
    destructor Destroy; override;
    class function New(pTitulo, pMensagem: string; pPergunta: Boolean = False): IMensagem;
    function Execute: Boolean;
  end;

implementation

{ TMensagem }

class function TMensagem.New(pTitulo, pMensagem: string; pPergunta: Boolean = False): IMensagem;
begin
  Result := Self.Create(pTitulo, pMensagem, pPergunta);
end;

constructor TMensagem.Create(pTitulo, pMensagem: string; pPergunta: Boolean = False);
begin
  FTITULO := pTitulo;
  FMENSAGEM := pMensagem;
  FPERGUNTA := pPergunta;
end;

destructor TMensagem.Destroy;
begin
  inherited;
end;

function TMensagem.Execute: Boolean;
begin
  if FTITULO.Trim.IsEmpty then
    FTITULO := 'Aliare Informa!';

  var
  FNOTIFICACAO := TfrmNotificacao.Create(nil);
  try
    FNOTIFICACAO.lblMsg.Caption := FMENSAGEM;
    FNOTIFICACAO.imgQuestion.Visible := FPERGUNTA;
    FNOTIFICACAO.pnlCancelar.Visible := FNOTIFICACAO.imgQuestion.Visible;
    FNOTIFICACAO.imgInfo.Visible := not FNOTIFICACAO.imgQuestion.Visible;
    FNOTIFICACAO.lblTitulo.Caption := FTITULO;
    FNOTIFICACAO.ShowModal;
    Result := FNOTIFICACAO.pResult;
  finally
    FreeAndNil(FNOTIFICACAO);
  end;
end;

end.
