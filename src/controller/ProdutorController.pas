unit ProdutorController;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  uProdutor,
  ProdutorDAO;

type
  TProdutorController = class
  private
    FProdutorDAO: TProdutorDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InserirProdutor(const Nome, CNPJ: string);
    function PesquisarTodos: TObjectList<TProdutor>;
  end;

implementation

constructor TProdutorController.Create;
begin
  FProdutorDAO := TProdutorDAO.Create;
end;

destructor TProdutorController.Destroy;
begin
  FProdutorDAO.Free;
  inherited;
end;

procedure TProdutorController.InserirProdutor(const Nome, CNPJ: string);
begin
  if Nome.Trim.IsEmpty then
    raise Exception.Create('O nome do produtor não pode estar vazio.');

  if CNPJ.Trim.IsEmpty then
    raise Exception.Create('O CNPJ do produtor não pode estar vazio.');

  FProdutorDAO.Inserir(Nome, CNPJ);
end;



function TProdutorController.PesquisarTodos: TObjectList<TProdutor>;
begin
  Result := FProdutorDAO.PesquisarTodos;
end;

end.

