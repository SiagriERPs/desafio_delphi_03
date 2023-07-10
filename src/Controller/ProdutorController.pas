unit ProdutorController;

interface

uses Produtor, ProdutorDAO, System.Generics.Collections;

type
  TProdutorController = class
  private
    FDAO: TProdutorDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SalvarProdutor( const ID: integer; const Nome, CPFCNPJ: string);
    function MostrarTodos: TObjectList<TProdutor>;
    procedure Atualiza(const ID: integer; const Nome, CPFCNPJ: string);
    procedure Excluir(const ID: integer);
    function BuscarProdutor(const ID: integer): TProdutor;
  end;

implementation

{ TProdutorController }


procedure TProdutorController.Atualiza(const ID: integer; const Nome,
  CPFCNPJ: string);
var
  Produtor : TProdutor;
begin
  Produtor := TProdutor.Create(ID, Nome, CPFCNPJ);
  FDAO.Atualizar(Produtor);
end;

function TProdutorController.BuscarProdutor(const ID: integer): TProdutor;
begin
  Result := FDAO.BuscarProdutor(ID);
end;

constructor TProdutorController.Create;
begin
  FDAO := TProdutorDAO.Create;
end;

destructor TProdutorController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TProdutorController.Excluir(const ID: integer);
begin
  FDAO.Excluir(ID);
end;

function TProdutorController.MostrarTodos: TObjectList<TProdutor>;
begin
  Result := FDAO.BuscarTodos;
end;

procedure TProdutorController.SalvarProdutor(const ID: integer; const Nome,
  CPFCNPJ: string);
var
  Produtor : TProdutor;
begin
  Produtor := TProdutor.Create(ID, Nome, CPFCNPJ);
  FDAO.Salvar(Produtor);
end;

end.
