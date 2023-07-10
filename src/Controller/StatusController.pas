unit StatusController;

interface

uses Status, StatusDAO, System.Generics.Collections;

type
  TStatusController = class
  private
    FDAO: TStatusDAO;
  public
    constructor Create;
    destructor Destroy; override;
    function MostrarTodos: TObjectList<TStatus>;
    function BuscarEspecifico(const id: integer): String;
  end;

implementation

{ TStatusController }

function TStatusController.BuscarEspecifico(const id: integer): String;
begin
  Result := FDAO.Busca(id);
end;

constructor TStatusController.Create;
begin
  FDAO := TStatusDAO.Create;
end;

destructor TStatusController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

function TStatusController.MostrarTodos: TObjectList<TStatus>;
begin
  Result := FDAO.BuscarTodos;
end;

end.
