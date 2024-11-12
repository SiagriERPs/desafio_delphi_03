unit ProdutoController;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  uProduto,
  ProdutoDAO;

type
  TProdutoController = class
  private
    FProdutoDAO: TProdutoDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InserirProduto(const Nome: string; PrecoVenda: currency);
    function PesquisarTodos: TObjectList<TProduto>;
  end;

implementation

constructor TProdutoController.Create;
begin
  FProdutoDAO := TProdutoDAO.Create;
end;

destructor TProdutoController.Destroy;
begin
  FProdutoDAO.Free;
  inherited;
end;

procedure TProdutoController.InserirProduto(const Nome: string; PrecoVenda: currency);
begin
  if Nome.Trim.IsEmpty then
    raise Exception.Create('O nome do produto não pode estar vazio.');

  if PrecoVenda < 0 then
    raise Exception.Create('O Preço de venda do produto não pode ser menor que 0.');

  FProdutoDAO.Inserir(Nome, PrecoVenda);
end;



function TProdutoController.PesquisarTodos: TObjectList<TProduto>;
begin
  Result := FProdutoDAO.PesquisarTodos;
end;

end.

