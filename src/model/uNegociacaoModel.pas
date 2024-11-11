unit uNegociacaoModel;

interface

uses
  uEnumerado,
  FireDAC.Comp.Client;

type
  TNegociacaoModel = class
  private
    FAction           : TAction;
    FId               : Integer;
    FProdutorId       : Integer;
    FDistribuidorId   : Integer;
    FDataCadastro     : TDate;
    FStatus           : string;
    FValorTotal       : Currency;
    FDataAprovacao    : TDate;
    FDataConclusao    : TDate;
    FDataCancelamento : TDate;

    procedure setAction(const Value: TAction);
    procedure setId(const Value: Integer);
    procedure setProdutorId(const Value: Integer);
    procedure setDistribuidorId(const Value: Integer);
    procedure setDataCadastro(const Value: TDate);
    procedure setStatus(const Value: string);
    procedure setValorTotal(const Value: Currency);
    procedure setDataAprovacao(const Value: TDate);
    procedure setDataConclusao(const Value: TDate);
    procedure setDataCancelamento(const Value: TDate);
  public
    function obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(pAutoIncremento: Integer): Integer;

    property Action           : TAction  read FAction            write setAction;
    property Id               : Integer  read FId                write setId;
    property ProdutorId       : Integer  read FProdutorId        write setProdutorId;
    property DistribuidorId   : Integer  read FDistribuidorId    write setDistribuidorId;
    property DataCadastro     : TDate    read FDataCadastro      write setDataCadastro;
    property Status           : string   read FStatus            write setStatus;
    property ValorTotal       : Currency read FValorTotal        write setValorTotal;
    property DataAprovacao    : TDate    read FDataAprovacao     write setDataAprovacao;
    property DataConclusao    : TDate    read FDataConclusao     write setDataConclusao;
    property DataCancelamento : TDate    read FDataCancelamento  write setDataCancelamento;
  end;

implementation

{ TNegociacaoModel }

uses
  uNegociacaoDAO;

function TNegociacaoModel.GetId(pAutoIncremento: Integer): Integer;
var
  vNegociacaoDAO: TNegociacaoDAO;
begin
  vNegociacaoDAO := TNegociacaoDAO.Create;
  try
    Result := vNegociacaoDAO.GetId(pAutoIncremento);
  finally
    vNegociacaoDAO.Free;
  end;
end;

function TNegociacaoModel.obter: TFDQuery;
var
  vNegociacaoDAO: TNegociacaoDAO;
begin
  vNegociacaoDAO := TNegociacaoDAO.Create;
  try
    Result := vNegociacaoDAO.Obter;
  finally
    vNegociacaoDAO.Free;
  end;
end;

function TNegociacaoModel.Salvar: Boolean;
var
  vNegociacaoDAO: TNegociacaoDAO;
begin
  Result := False;
  vNegociacaoDAO := TNegociacaoDAO.Create;
  try
    case FAction of
      uEnumerado.tacInclude : Result := vNegociacaoDAO.Inserir(Self);
      uEnumerado.tacChange  : Result := vNegociacaoDAO.Alterar(Self);
      uEnumerado.tacDelete  : Result := vNegociacaoDAO.Deletar(Self);
    end;
  finally
    vNegociacaoDAO.Free;
  end;
end;

procedure TNegociacaoModel.setAction(const Value: TAction);
begin
  FAction := Value;
end;

procedure TNegociacaoModel.setDataAprovacao(const Value: TDate);
begin
  FDataAprovacao := Value;
end;

procedure TNegociacaoModel.setDataCadastro(const Value: TDate);
begin
  FDataCadastro := Value;
end;

procedure TNegociacaoModel.setDataCancelamento(const Value: TDate);
begin
  FDataCancelamento := Value;
end;

procedure TNegociacaoModel.setDataConclusao(const Value: TDate);
begin
  FDataConclusao := Value;
end;

procedure TNegociacaoModel.setDistribuidorId(const Value: Integer);
begin
  FDistribuidorId := Value;
end;

procedure TNegociacaoModel.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TNegociacaoModel.setProdutorId(const Value: Integer);
begin
  FProdutorId := Value;
end;

procedure TNegociacaoModel.setStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TNegociacaoModel.setValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
