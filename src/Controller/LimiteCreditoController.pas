unit LimiteCreditoController;

interface

uses LimiteCredito, LimiteCreditoDAO;

type
  TLimiteCreditoController = class
  private
    FDAO: TLimiteCreditoDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SalvarLimite( const ID, IdProdutor, IdDistribuidor: integer; const LimiteCredito: Double);
    function MostrarLimite(const IdProdutor, IdDistribuidor: integer): Double;
    procedure Atualiza(const ID, IdProdutor, IdDistribuidor: integer; const LimiteCredito: Double);
  end;

implementation

{ TLimiteCreditoController }

procedure TLimiteCreditoController.Atualiza(const ID, IdProdutor, IdDistribuidor: integer; const LimiteCredito: Double);
var
  Limite: TLimiteCredito;
begin
  Limite := TLimiteCredito.Create(ID,IdProdutor, IdDistribuidor, LimiteCredito);
  FDAO.Atualizar(Limite);
end;

constructor TLimiteCreditoController.Create;
begin
  FDAO := TLimiteCreditoDAO.Create;
end;

destructor TLimiteCreditoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

function TLimiteCreditoController.MostrarLimite(const IdProdutor,
  IdDistribuidor: integer): Double;
begin
  Result := FDAO.Buscar(IdProdutor, IdDistribuidor);
end;

procedure TLimiteCreditoController.SalvarLimite(const ID, IdProdutor,
  IdDistribuidor: integer; const LimiteCredito: Double);
var
  Limite: TLimiteCredito;
begin
  Limite := TLimiteCredito.Create(ID,IdProdutor, IdDistribuidor, LimiteCredito);
  FDAO.Salvar(Limite);
end;

end.
