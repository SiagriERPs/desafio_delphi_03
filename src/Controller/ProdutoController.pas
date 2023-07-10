unit ProdutoController;

interface

uses Produto, ProdutoDAO, System.Generics.Collections;

type
  TProdutoController = class
  private
    FDAO: TProdutoDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SalvarProduto( const ID: integer; const Nome: string; const Preco: Double);
    function MostrarTodos: TObjectList<TProduto>;
    procedure Atualiza(const ID: integer; const Nome: string; const Preco: Double);
    procedure Excluir(const ID: integer);
    function BuscarProduto(const ID: integer): TProduto;
  end;

implementation

{ TProdutoController }

procedure TProdutoController.Atualiza(const ID: integer; const Nome: string;
  const Preco: Double);
var
  Produto : TProduto;
begin
  Produto := TProduto.Create(ID, Nome, Preco);
  FDAO.Atualizar(Produto);
end;

function TProdutoController.BuscarProduto(const ID: integer): TProduto;
begin
  Result := FDAO.BuscarProduto(ID);
end;

constructor TProdutoController.Create;
begin
  FDAO := TProdutoDAO.Create;
end;

destructor TProdutoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TProdutoController.Excluir(const ID: integer);
begin
  FDAO.Excluir(ID);
end;

function TProdutoController.MostrarTodos: TObjectList<TProduto>;
begin
  Result := FDAO.BuscarTodos;
end;

procedure TProdutoController.SalvarProduto(const ID: integer;
  const Nome: string; const Preco: Double);
var
  Produto : TProduto;
begin
  Produto := TProduto.Create(ID, Nome, Preco);
  FDAO.Salvar(Produto);
end;

end.
