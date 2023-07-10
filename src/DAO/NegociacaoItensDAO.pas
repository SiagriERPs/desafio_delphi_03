unit NegociacaoItensDAO;

interface

uses NegociacaoItens, System.Generics.Collections, FireDAC.Comp.Client, UDM,
  Funcoes;

type
  TNegociacaoItensDAO = class
    procedure Salvar(const NegociacaoItens: TNegociacaoItens);
    function BuscarTodos(const IdNegociacao: integer): TObjectList<TNegociacaoItens>;
    procedure Excluir(const ID: integer);
  end;

implementation

{ TNegociacaoItens }


function TNegociacaoItensDAO.BuscarTodos(const IdNegociacao: integer): TObjectList<TNegociacaoItens>;
const
  sSQL = 'select * from negociacao_itens where id_negociacao = :id';
var
  Query: TFDQuery;
  NegociacaoItens: TNegociacaoItens;
begin
  Query := TFDQuery.Create(nil);
  Result := TObjectList<TNegociacaoItens>.Create;
  try
    Query.Connection := Dm.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id').AsInteger := IdNegociacao;
    Query.Open;
    while not Query.Eof do
    begin
      NegociacaoItens := TNegociacaoItens.Create(
        Query.FieldByName('id_negociacao_itens').AsInteger,
        Query.FieldByName('id_negociacao').AsInteger,
        Query.FieldByName('id_produto').AsInteger,
        Query.FieldByName('quantidade').AsFloat,
        Query.FieldByName('valorunitario').AsFloat
      );
      Result.Add(NegociacaoItens);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TNegociacaoItensDAO.Excluir(const ID: integer);
const
  sSQL = 'delete from negociacao_itens where id_negociacao = :id';
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

procedure TNegociacaoItensDAO.Salvar(const NegociacaoItens: TNegociacaoItens);
const
  sSQL = 'insert into negociacao_itens (id_negociacao_itens, id_negociacao, id_produto, quantidade, valorunitario) values (:id_negociacao_itens, :id_negociacao, :id_produto, :quantidade, :valorunitario)';
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.Conexão;
    Query.SQL.Clear;
    Query.SQL.Add(sSQL);
    Query.ParamByName('id_negociacao_itens').AsInteger := Funcoes.VerificarProxID('negociacao_itens');
    Query.ParamByName('id_negociacao').AsInteger       := NegociacaoItens.IdNegociacao;
    Query.ParamByName('id_produto').AsInteger          := NegociacaoItens.IdProduto;
    Query.ParamByName('quantidade').AsFloat            := NegociacaoItens.Quantidade;
    Query.ParamByName('valorunitario').AsFloat         := NegociacaoItens.ValorUnitario;
    Query.ExecSQL;
  finally
    Query.Free
  end;
end;

end.
