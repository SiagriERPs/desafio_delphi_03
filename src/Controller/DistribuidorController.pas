unit DistribuidorController;

interface

uses Distribuidor, DistribuidorDAO, System.Generics.Collections;

type
  TDistribuidorController = class
  private
    FDAO: TDistribuidorDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SalvarDistribuidor( const ID: integer; const Nome, CNPJ: string);
    function MostrarTodos: TObjectList<TDistribuidor>;
    procedure Atualiza(const ID: integer; const Nome, CNPJ: string);
    procedure Excluir(const ID: integer);
    function BuscarDistribuidor(const ID: integer): TDistribuidor;
  end;

implementation

{ TDistribuidorController }

procedure TDistribuidorController.Atualiza(const ID: integer; const Nome,
  CNPJ: string);
var
  Distribuidor : TDistribuidor;
begin
  Distribuidor := TDistribuidor.Create(ID, Nome, CNPJ);
  FDAO.Atualizar(Distribuidor);
end;

function TDistribuidorController.BuscarDistribuidor(
  const ID: integer): TDistribuidor;
begin
  Result := FDAO.BuscarDistribuidor(ID);
end;

constructor TDistribuidorController.Create;
begin
  FDAO := TDistribuidorDAO.Create;
end;

destructor TDistribuidorController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TDistribuidorController.Excluir(const ID: integer);
begin
  FDAO.Excluir(ID);
end;

function TDistribuidorController.MostrarTodos: TObjectList<TDistribuidor>;
begin
  Result := FDAO.BuscarTodos;
end;

procedure TDistribuidorController.SalvarDistribuidor( const ID: integer; const Nome, CNPJ: string);
var
  Distribuidor: TDistribuidor;
begin
  Distribuidor := TDistribuidor.Create(0, Nome, CNPJ);
  FDAO.Salvar(Distribuidor);
end;

end.
