unit uLimiteCreditoModel;

interface

uses
  uEnumerado,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TLimiteCreditoModel = class
  private
    FAction          : TAction;
    FLimiteCreditoId : Integer;
    FProdutorId      : Integer;
    FDistribuidorId  : Integer;
    FLimiteCredito   : Currency;
    FDistribuidor    : string;

    procedure setAction(const Value: TAction);
    procedure setLimiteCreditoId(const Value: Integer);
    procedure setProdutorId(const Value: Integer);
    procedure setDistribuidorId(const Value: Integer);
    procedure setLimiteCredito(const Value: Currency);
    procedure setDistribuidor(const Value: string);
  public
    function obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function ObterLimitesCredito(pProdutorId: Integer): TList<TLimiteCreditoModel>;

    property Action          : TAction  read FAction          write setAction;
    property LimiteCreditoId : Integer  read FLimiteCreditoId write setLimiteCreditoId;
    property ProdutorId      : Integer  read FProdutorId      write setProdutorId;
    property DistribuidorId  : Integer  read FDistribuidorId  write setDistribuidorId;
    property LimiteCredito   : Currency read FLimiteCredito   write setLimiteCredito;
    property Distribuidor    : string   read FDistribuidor    write setDistribuidor;
  end;

implementation

{ TLimiteCreditoModel }

uses
  uLimiteCreditoDAO;

function TLimiteCreditoModel.GetId(pAutoIncremento: Integer): Integer;
var
  vLimiteCreditoDAO: TLimiteCreditoDAO;
begin
  vLimiteCreditoDAO := TLimiteCreditoDAO.Create;
  try
    Result := vLimiteCreditoDAO.GetId(pAutoIncremento);
  finally
    vLimiteCreditoDAO.Free;
  end;
end;

function TLimiteCreditoModel.obter: TFDQuery;
var
  vLimiteCreditoDAO: TLimiteCreditoDAO;
begin
  vLimiteCreditoDAO := TLimiteCreditoDAO.Create;
  try
    Result := vLimiteCreditoDAO.Obter;
  finally
    vLimiteCreditoDAO.Free;
  end;
end;

function TLimiteCreditoModel.ObterLimitesCredito(pProdutorId: Integer): TList<TLimiteCreditoModel>;
var
  vLimiteCreditoDAO: TLimiteCreditoDAO;
begin
  vLimiteCreditoDAO := TLimiteCreditoDAO.Create;
  try
    Result := vLimiteCreditoDAO.CarregarLimitesCredito(pProdutorId);
  finally
    vLimiteCreditoDAO.Free;
  end;
end;

function TLimiteCreditoModel.Salvar: Boolean;
var
  vLimiteCreditoDAO: TLimiteCreditoDAO;
begin
  Result := False;

  vLimiteCreditoDAO := TLimiteCreditoDAO.Create;
  try
    case FAction of
      uEnumerado.tacInclude : Result := vLimiteCreditoDAO.Inserir(Self);
      uEnumerado.tacChange  : Result := vLimiteCreditoDAO.Alterar(Self);
      uEnumerado.tacDelete  : Result := vLimiteCreditoDAO.Deletar(Self);
    end;
  finally
    vLimiteCreditoDAO.Free;
  end;
end;

procedure TLimiteCreditoModel.setAction(const Value: TAction);
begin
  FAction := Value;
end;

procedure TLimiteCreditoModel.setDistribuidor(const Value: string);
begin
  FDistribuidor := Value;
end;

procedure TLimiteCreditoModel.setDistribuidorId(const Value: Integer);
begin
  FDistribuidorId := Value;
end;

procedure TLimiteCreditoModel.setLimiteCredito(const Value: Currency);
begin
  FLimiteCredito := Value;
end;

procedure TLimiteCreditoModel.setLimiteCreditoId(const Value: Integer);
begin
  FLimiteCreditoId := Value;
end;

procedure TLimiteCreditoModel.setProdutorId(const Value: Integer);
begin
  FProdutorId := Value;
end;

end.
