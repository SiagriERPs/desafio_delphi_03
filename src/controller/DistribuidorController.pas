unit DistribuidorController;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  uDistribuidor,
  DistribuidorDAO;

type
  TDistribuidorController = class
  private
    FDistribuidorDAO: TDistribuidorDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InserirDistribuidor(const Nome, CNPJ: string);
    function PesquisarTodos: TObjectList<TDistribuidor>;
  end;

implementation

constructor TDistribuidorController.Create;
begin
  FDistribuidorDAO := TDistribuidorDAO.Create;
end;

destructor TDistribuidorController.Destroy;
begin
  FDistribuidorDAO.Free;
  inherited;
end;

procedure TDistribuidorController.InserirDistribuidor(const Nome, CNPJ: string);
begin
  if Nome.Trim.IsEmpty then
    raise Exception.Create('O nome do distribuidor não pode estar vazio.');

  if CNPJ.Trim.IsEmpty then
    raise Exception.Create('O CNPJ do distribuidor não pode estar vazio.');

  FDistribuidorDAO.Inserir(Nome, CNPJ);
end;



function TDistribuidorController.PesquisarTodos: TObjectList<TDistribuidor>;
begin
  Result := FDistribuidorDAO.PesquisarTodos;
end;

end.

