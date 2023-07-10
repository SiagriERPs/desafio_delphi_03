unit StatusDAO;

interface

uses Status, System.Generics.Collections, FireDAC.Comp.Client, UDM;

type
  TStatusDAO = class
  public
    function BuscarTodos: TObjectList<TStatus>;
    function Busca(const id: integer): String;
  end;

implementation

{ TStatusDAO }

function TStatusDAO.Busca(const id: integer): String;
const
  sSQL = 'select * from status_negociacao where id_status = :id';
var
  Query: TFDQuery;
  Status: TStatus;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := id;
    Query.Open;
    if not Query.IsEmpty then
      Result := Query.FieldByName('status').AsString;
  finally
    Query.Free;
  end;
end;

function TStatusDAO.BuscarTodos: TObjectList<TStatus>;
const
  sSQL = 'select * from status_negociacao';
var
  Query: TFDQuery;
  Status: TStatus;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TStatus>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.Open;
    while not Query.Eof do
    begin
      Status := TStatus.Create(
        Query.FieldByName('id_status').AsInteger,
        Query.FieldByName('status').AsString
      );
      Result.Add(Status);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

end.
