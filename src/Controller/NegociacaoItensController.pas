unit NegociacaoItensController;

interface

uses NegociacaoItens, NegociacaoItensDAO, System.Generics.Collections;

type
  TNegociacaoItensController = class
  private
    FDAO: TNegociacaoItensDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Salvar(const ID, IdNegociacao, IdProdutor: integer; const Quantidade, Valorunitario: Double);
    function MostrarTodos(const IdNegocicao: integer): TObjectList<TNegociacaoItens>;
    procedure Excluir(const ID: integer);
  end;

implementation

{ TNegociacaoItensController }

constructor TNegociacaoItensController.Create;
begin
  FDAO := TNegociacaoItensDAO.Create;
end;

destructor TNegociacaoItensController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TNegociacaoItensController.Excluir(const ID: integer);
begin
  FDAO.Excluir(ID);
end;

function TNegociacaoItensController.MostrarTodos(const IdNegocicao: integer): TObjectList<TNegociacaoItens>;
begin
  Result := FDAO.BuscarTodos(IdNegocicao);
end;

procedure TNegociacaoItensController.Salvar(const ID, IdNegociacao,
  IdProdutor: integer; const Quantidade, Valorunitario: Double);
var
  NegociacaoItens : TNegociacaoItens;
begin
  NegociacaoItens := TNegociacaoItens.Create(ID, IdNegociacao, IdProdutor, Quantidade, Valorunitario);
  FDAO.Salvar(NegociacaoItens);
end;

end.
