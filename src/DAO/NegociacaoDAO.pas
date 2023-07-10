unit NegociacaoDAO;

interface

uses Negociacao, System.Generics.Collections, FireDAC.Comp.Client, UDM, Funcoes;

type
  TNegociacaoDAO = class
    function Salvar(const Negociacao: TNegociacao): Integer;
    function BuscarTodos: TObjectList<TNegociacao>;
    function BuscarTodosPorProdutor(const id: integer): TObjectList<TNegociacao>;
    function BuscarTodosPorDistribuidor(const id: integer): TObjectList<TNegociacao>;
    function BuscarValorNegPorProdutor(const ID: integer): Double;
    procedure AtualizarStatus(const Id, IdStatus: integer);
    procedure AtualizaDataAprovacao(const Id: integer; const data: string);
    procedure AtualizaDataConclusao(const Id: integer; const data: string);
    procedure AtualizaDataCancelamento(const Id: integer; const data: string);
    procedure Excluir(const ID: integer);
  end;

implementation

uses
  System.SysUtils;

{ TNegociacaoDAO }

procedure TNegociacaoDAO.AtualizaDataAprovacao(const Id: integer;
  const data: string);
const
  sSQL = 'update negociacao SET data_aprovacao = :data_aprovacao WHERE id_negociacao = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('data_aprovacao').AsDate      := StrToDate(data);
    Query.ParamByName('id').AsInteger               := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TNegociacaoDAO.AtualizaDataCancelamento(const Id: integer;
  const data: string);
const
  sSQL = 'update negociacao SET data_cancelamento = :data_cancelamentoWHERE id_negociacao = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('data_cancelamento').AsDate   := StrToDate(data);
    Query.ParamByName('id').AsInteger               := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TNegociacaoDAO.AtualizaDataConclusao(const Id: integer;
  const data: string);
const
  sSQL = 'update negociacao SET data_conclusao = :data_conclusao WHERE id_negociacao = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_status').AsDate           := StrToDate(data);
    Query.ParamByName('id').AsInteger               := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TNegociacaoDAO.AtualizarStatus(const Id, IdStatus: integer);
const
  sSQL = 'update negociacao SET id_status = :id_status WHERE id_negociacao = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_status').AsInteger        := IdStatus;
    Query.ParamByName('id').AsInteger               := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TNegociacaoDAO.BuscarTodos: TObjectList<TNegociacao>;
const
  sSQL = 'select * from negociacao';
var
  Query: TFDQuery;
  Negociacao: TNegociacao;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TNegociacao>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.Open;
    while not Query.Eof do
    begin
      Negociacao := TNegociacao.Create(
        Query.FieldByName('id_negociacao').AsInteger,
        Query.FieldByName('id_produtor').AsInteger,
        Query.FieldByName('id_distribuidor').AsInteger,
        Query.FieldByName('id_status').AsInteger,
        Query.FieldByName('valortotal').AsFloat,
        Query.FieldByName('data_criacao').AsString,
        Query.FieldByName('data_aprovacao').AsString,
        Query.FieldByName('data_conclusao').AsString,
        Query.FieldByName('data_cancelamento').AsString
      );
      Result.Add(Negociacao);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TNegociacaoDAO.BuscarTodosPorDistribuidor(const id: integer): TObjectList<TNegociacao>;
const
  sSQL = 'select * from negociacao where id_distribuidor = :id';
var
  Query: TFDQuery;
  Negociacao: TNegociacao;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TNegociacao>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := id;
    Query.Open;
    while not Query.Eof do
    begin
      Negociacao := TNegociacao.Create(
        Query.FieldByName('id_negociacao').AsInteger,
        Query.FieldByName('id_produtor').AsInteger,
        Query.FieldByName('id_distribuidor').AsInteger,
        Query.FieldByName('id_status').AsInteger,
        Query.FieldByName('valortotal').AsFloat,
        Query.FieldByName('data_criacao').AsString,
        Query.FieldByName('data_aprovacao').AsString,
        Query.FieldByName('data_conclusao').AsString,
        Query.FieldByName('data_cancelamento').AsString
      );
      Result.Add(Negociacao);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TNegociacaoDAO.BuscarTodosPorProdutor(const id: integer): TObjectList<TNegociacao>;
const
  sSQL = 'select * from negociacao where id_produtor = :id';
var
  Query: TFDQuery;
  Negociacao: TNegociacao;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TNegociacao>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := id;
    Query.Open;
    while not Query.Eof do
    begin
      Negociacao := TNegociacao.Create(
        Query.FieldByName('id_negociacao').AsInteger,
        Query.FieldByName('id_produtor').AsInteger,
        Query.FieldByName('id_distribuidor').AsInteger,
        Query.FieldByName('id_status').AsInteger,
        Query.FieldByName('valortotal').AsFloat,
        Query.FieldByName('data_criacao').AsString,
        Query.FieldByName('data_aprovacao').AsString,
        Query.FieldByName('data_conclusao').AsString,
        Query.FieldByName('data_cancelamento').AsString
      );
      Result.Add(Negociacao);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TNegociacaoDAO.BuscarValorNegPorProdutor(const ID: integer): Double;
const
  sSQL = 'select sum(valortotal) as total from negociacao where id_produtor = :id and id_status = 2';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := ID;
    Query.Open;
    if not Query.IsEmpty then
    begin
      Result := Query.FieldByName('total').AsFloat;
    end;
  finally
    Query.Free;
  end;
end;

procedure TNegociacaoDAO.Excluir(const ID: integer);
const
  sSQL = 'delete from negociacao where id_negociacao = :id';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;


function TNegociacaoDAO.Salvar(const Negociacao: TNegociacao): Integer;
const
  sSQL = 'insert into negociacao (id_negociacao, id_produtor, id_distribuidor, id_status, valortotal, data_criacao, data_aprovacao, data_conclusao, data_cancelamento)'+
         ' values (:id_negociacao, :id_produtor, :id_distribuidor, :id_status, :valortotal, :data_criacao, null, null, null)';
var
  Query: TFDQuery;
  Id: integer;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Id                                             := Funcoes.VerificarProxID('negociacao');
    Query.ParamByName('id_negociacao').AsInteger   := Id;
    Query.ParamByName('id_produtor').AsInteger     := Negociacao.IdProdutor;
    Query.ParamByName('id_distribuidor').AsInteger := Negociacao.IdDistribuidor;
    Query.ParamByName('id_status').AsInteger       := Negociacao.IdStatus;
    Query.ParamByName('valortotal').AsFloat        := Negociacao.ValorTotal;
    Query.ParamByName('data_criacao').AsDate        := Now;
    Query.ExecSQL;
    Result := Id;
  finally
    Query.Free
  end;
end;

end.
