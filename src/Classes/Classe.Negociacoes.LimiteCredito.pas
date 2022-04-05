unit Classe.Negociacoes.LimiteCredito;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Script,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.Forms, System.SysUtils, System.Classes, StrUtils, DateUtils, Data.DB,
  Classe.Negociacoes.Interfaces;

type

  TNegociacaoLimiteCredito = class(TInterfacedObject, INegociacaoLimiteCredito)
  private
    { private declarations }
    FCONEXAO: TFDConnection;
    FIDPRODUTOR: Integer;
    FIDDISTRIBUIDOR: Integer;

  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const IDPRODUTOR: Integer; const IDDISTRIBUIDOR: Integer; const CONEXAO: TFDConnection);
    destructor Destroy; override;
    class function New(const IDPRODUTOR: Integer; const IDDISTRIBUIDOR: Integer; const CONEXAO: TFDConnection): INegociacaoLimiteCredito;
    function Execute: Currency;
  end;

implementation

{ TNegociacaoLimiteCredito }

class function TNegociacaoLimiteCredito.New(const IDPRODUTOR: Integer; const IDDISTRIBUIDOR: Integer; const CONEXAO: TFDConnection): INegociacaoLimiteCredito;
begin
  Result := Self.Create(IDPRODUTOR, IDDISTRIBUIDOR, CONEXAO);
end;

constructor TNegociacaoLimiteCredito.Create(const IDPRODUTOR: Integer; const IDDISTRIBUIDOR: Integer; const CONEXAO: TFDConnection);
begin
  FIDPRODUTOR := IDPRODUTOR;
  FIDDISTRIBUIDOR := IDDISTRIBUIDOR;
  FCONEXAO := CONEXAO;
end;

destructor TNegociacaoLimiteCredito.Destroy;
begin
  inherited;
end;

function TNegociacaoLimiteCredito.Execute: Currency;
begin
  if FIDPRODUTOR <= 0 then
    raise Exception.Create('Código do produtor rural não pode ser zerado!' + sLineBreak + 'TNegociacaoLimiteCredito.Execute');

  if FIDDISTRIBUIDOR <= 0 then
    raise Exception.Create('Código do distribuidor não pode ser zerado!' + sLineBreak + 'TNegociacaoLimiteCredito.Execute');

  Result := FCONEXAO.ExecSQLScalar(Format('select LIMITE_CREDITO from PRODUTORES_LIMITES where ID_PRODUTOR = %d and ID_DISTRIBUIDOR = %d',
    [FIDPRODUTOR, FIDDISTRIBUIDOR]));
end;

end.
