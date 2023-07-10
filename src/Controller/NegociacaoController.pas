unit NegociacaoController;

interface

uses Negociacao, NegociacaoDAO, System.Generics.Collections, System.SysUtils;

type
  TNegociacaoController = class
  private
    FDAO: TNegociacaoDAO;
  public
    constructor Create;
    destructor Destroy; override;
    function Salvar(const ID, IdProdutor, IdDistribuidor, IdStatus: integer; const Valortotal: Double): Integer;
    function MostrarTodos: TObjectList<TNegociacao>;
    function BuscarValorNegPorProdutor(const IdProdutor: integer): Double;
    function MostrarTodosPorProdutor(const id: integer): TObjectList<TNegociacao>;
    function MostrarTodosPorDistribuidor(const id: integer): TObjectList<TNegociacao>;
    procedure AtualizarStatus(const ID, IdStatus: integer);
    procedure AtualizaDataAprovacao(const id: integer; const data: string);
    procedure AtualizaDataConclusao(const id: integer; const data: string);
    procedure AtualizaDataCancelamento(const id: integer; const data: string);
    procedure Excluir(const ID: integer);
  end;

implementation

{ TNegociacaoController }


{ TNegociacaoController }

procedure TNegociacaoController.AtualizaDataAprovacao(const id: integer;
  const data: string);
begin
  FDAO.AtualizaDataAprovacao(id, data);
end;

procedure TNegociacaoController.AtualizaDataCancelamento(const id: integer;
  const data: string);
begin
  FDAO.AtualizaDataCancelamento(id, data);
end;

procedure TNegociacaoController.AtualizaDataConclusao(const id: integer;
  const data: string);
begin
  FDAO.AtualizaDataConclusao(id, data);
end;

procedure TNegociacaoController.AtualizarStatus(const ID, IdStatus: integer);
begin
  FDAO.AtualizarStatus(ID, IdStatus);
end;

function TNegociacaoController.BuscarValorNegPorProdutor(
  const IdProdutor: integer): Double;
begin
  Result := FDAO.BuscarValorNegPorProdutor(IdProdutor);
end;

constructor TNegociacaoController.Create;
begin
  FDAO := TNegociacaoDAO.Create;
end;

destructor TNegociacaoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TNegociacaoController.Excluir(const ID: integer);
begin
  FDAO.Excluir(ID);
end;

function TNegociacaoController.MostrarTodos: TObjectList<TNegociacao>;
begin
  Result := FDAO.BuscarTodos;
end;

function TNegociacaoController.MostrarTodosPorDistribuidor(
  const id: integer): TObjectList<TNegociacao>;
begin
  Result := FDAO.BuscarTodosPorDistribuidor(id);
end;

function TNegociacaoController.MostrarTodosPorProdutor(
  const id: integer): TObjectList<TNegociacao>;
begin
  Result := FDAO.BuscarTodosPorProdutor(id);
end;

function TNegociacaoController.Salvar(const ID, IdProdutor, IdDistribuidor,
  IdStatus: integer; const Valortotal: Double): Integer;
var
  Negociacao : TNegociacao;
begin
  Negociacao := TNegociacao.Create(ID, IdProdutor,IdDistribuidor,IdStatus,  Valortotal, DateToStr(Now), DateToStr(Now), DateToStr(Now), DateToStr(Now));
  Result := FDAO.Salvar(Negociacao);
end;

end.
