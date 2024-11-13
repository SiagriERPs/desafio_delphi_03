unit uStatusController;

interface

uses
  uStatusDAO,
  uStatusModel,
  uEnumerado;

type
  TStatusController = class
  private
    FStatusDAO : TStatusDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function AprovarNegociacao(const pNegociacaoId: Integer): Boolean;
    function ConcluirNegociacao(const pNegociacaoId: Integer): Boolean;
    function CancelarNegociacao(const pNegociacaoId: Integer): Boolean;
    function ObterStatusNegociacao(const pNegociacaoId: Integer): string;
  end;

implementation

{ TStatusController }
constructor TStatusController.Create;
begin
  FStatusDAO := TStatusDao.Create;
end;

destructor TStatusController.Destroy;
begin
  FStatusDAO.Free;
  inherited;
end;

function TStatusController.ObterStatusNegociacao(const pNegociacaoId: Integer): string;
var
  vStatusModel : TStatusModel;
begin
  vStatusModel := TStatusModel.Create;
  try
    vStatusModel.NegociacaoID := pNegociacaoId;
    Result := FStatusDAO.ObterStatusNegociacao(pNegociacaoId);
  finally
    vStatusModel.Free;
  end;
end;

function TStatusController.AprovarNegociacao(const pNegociacaoId: Integer): Boolean;
var
  vStatusModel: TStatusModel;
begin
  vStatusModel := TStatusModel.Create;
  try
    vStatusModel.NegociacaoID := pNegociacaoId;

    if vStatusModel.Aprovar then
    begin
      FStatusDAO.AtualizarStatus(pNegociacaoId, vStatusModel.StatusAtual);
      Result := True;
    end
    else
      Result := False;
  finally
    vStatusModel.Free;
  end;
end;

function TStatusController.CancelarNegociacao(const pNegociacaoId: Integer): Boolean;
var
  vStatusModel: TStatusModel;
begin
  vStatusModel := TStatusModel.Create;
  try
    vStatusModel.NegociacaoID := pNegociacaoId;

    if vStatusModel.Cancelar then
    begin
      FStatusDao.AtualizarStatus(pNegociacaoId, vStatusModel.StatusAtual);
      Result := True;
    end
    else
      Result := False;
  finally
    vStatusModel.Free;
  end;
end;

function TStatusController.ConcluirNegociacao(const pNegociacaoId: Integer): Boolean;
var
  vStatusModel: TStatusModel;
begin
  vStatusModel := TStatusModel.Create;
  try
    vStatusModel.NegociacaoID := pNegociacaoId;

    if vStatusModel.Concluir then
    begin
      FStatusDao.AtualizarStatus(pNegociacaoId, vStatusModel.StatusAtual);
      Result := True;
    end
    else
      Result := False;
  finally
    vStatusModel.Free;
  end;
end;

end.
