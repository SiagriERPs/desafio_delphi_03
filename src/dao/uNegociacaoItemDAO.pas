unit uNegociacaoItemDAO;

interface

uses
  uConexao,
  uNegociacaoItemModel,
  System.SysUtils,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TNegociacaoItemDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Inserir(pNegociacaoItem: TNegociacaoItemModel): Boolean;
    function Alterar(pNegociacaoItem: TNegociacaoItemModel): Boolean;
    function Deletar(pNegociacaoItem: TNegociacaoItemModel): Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function Obter: TFDQuery;
    function CarregarItensNegociacao(pNegociacaoId: Integer): TList<TNegociacaoItemModel>;
  end;

implementation

{ TNegociacaoItemDAO }

uses
  uSistemaController;

function TNegociacaoItemDAO.CarregarItensNegociacao(pNegociacaoId: Integer): TList<TNegociacaoItemModel>;
var
  vQry            : TFDQuery;
  vItemNegociacao : TNegociacaoItemModel;
  vListaItem      : TList<TNegociacaoItemModel>;
begin
  vListaItem := TList<TNegociacaoItemModel>.Create;
  vQry := FConexao.CreateQuery();

  try
    vQry.Open(
      'SELECT tin.item_negociacao_id ' +
      '     , tin.negociacao_id ' +
      '     , tin.produto_id ' +
      '     , tin.quantidade ' +
      '     , tin.preco ' +
      '     , tp.nome produto ' +
//      '     , (tin.quantidade * tin.preco) vlr_total ' +
      '  FROM tab_item_negociacao tin ' +

      ' INNER JOIN tab_produto tp ' +
      ' ON tin.produto_id = tp.produto_id' +

      ' WHERE tin.negociacao_id = :negociacao_id ',
      [pNegociacaoId]
    );

    while not vQry.Eof do
    begin
      vItemNegociacao := TNegociacaoItemModel.Create;

      vItemNegociacao.Id           := vQry.FieldByName('item_negociacao_id').AsInteger;
      vItemNegociacao.NegociacaoId := vQry.FieldByName('negociacao_id').AsInteger;
      vItemNegociacao.ProdutoId    := vQry.FieldByName('produto_id').AsInteger;
      vItemNegociacao.Produto      := vQry.FieldByName('produto').AsString;
      vItemNegociacao.Quantidade   := vQry.FieldByName('quantidade').AsInteger;
      vItemNegociacao.Preco        := vQry.FieldByName('preco').AsCurrency;

      vListaItem.Add(vItemNegociacao);
      vQry.Next;
    end;
    Result := vListaItem;
  finally
    vQry.Free;
  end;
end;

constructor TNegociacaoItemDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance.GetConexao;
end;

function TNegociacaoItemDAO.Deletar(pNegociacaoItem: TNegociacaoItemModel): Boolean;
var
  vQry: TFDQuery;
begin
  Result := False;

  if not FConexao.GetConn.Connected then
  begin
    raise Exception.Create('A conexão com o banco de dados não está ativa.');
    Exit;
  end;

  FConexao.StartTransaction;
  try
    vQry := FConexao.CreateQuery;
    try
      vQry.SQL.Text :=
         'DELETE FROM tab_item_negociacao ' +
         ' WHERE item_negociacao_id = :item_negociacao_id ' +
         ' AND negociacao_id        = :negociacao_id';
      vQry.ParamByName('item_negociacao_id').AsInteger := pNegociacaoItem.Id;
      vQry.ParamByName('negociacao_id').AsInteger      := pNegociacaoItem.NegociacaoId;
      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código da negociação é válida.');
      end;

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao deletar a negociação : [' + E.Message + ']');
    end;
  end;
end;

function TNegociacaoItemDAO.GetId(pAutoIncremento: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();
  try
    vQry.Open('SELECT COALESCE(MAX(negociacao_id), 0) + ' + IntToStr(pAutoIncremento) + ' FROM tab_negociacao');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TNegociacaoItemDAO.Inserir(pNegociacaoItem: TNegociacaoItemModel): Boolean;
var
  vQry: TFDQuery;
begin
  if not FConexao.GetConn.Connected then
  begin
    raise Exception.Create('A conexão com o banco de dados não está ativa.');
    Exit;
  end;

  FConexao.StartTransaction;
  try
    vQry := FConexao.CreateQuery;
    try
      vQry.ExecSQL(
        'INSERT INTO tab_item_negociacao ( ' +
        '  item_negociacao_id, ' +
        '  negociacao_id, ' +
        '  produto_id, ' +
        '  quantidade, ' +
        '  preco) ' +
        ' VALUES ( '+
        '  :item_negociacao_id,' +
        '  :negociacao_id,' +
        '  :produto_id, ' +
        '  :quantidade, ' +
        '  :preco) ',
        [
          pNegociacaoItem.Id,
          pNegociacaoItem.NegociacaoId,
          pNegociacaoItem.ProdutoId,
          pNegociacaoItem.Quantidade,
          pNegociacaoItem.Preco
        ]
      );

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao inserir item na negociação: ' + E.Message);
    end;
  end;
end;

function TNegociacaoItemDAO.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CreateQuery();

  vQry.Open('SELECT item_negociacao_id, negociacao_id, produtor_id, quantidade, preco FROM tab_item_negociacao ORDER BY item_negociacao_id');

  Result := vQry;
end;

function TNegociacaoItemDAO.Alterar(pNegociacaoItem: TNegociacaoItemModel): Boolean;
var
  vQry: TFDQuery;
begin
  Result := False;

  if not FConexao.GetConn.Connected then
  begin
    raise Exception.Create('A conexão com o banco de dados não está ativa.');
    Exit;
  end;

  FConexao.StartTransaction;
  try
    vQry := FConexao.CreateQuery();
    try
      vQry.SQL.Text :=
        'UPDATE tab_item_negociacao SET ' +
        '  produto_id              = :produto_id, ' +
        '  quantidade              = :quantidade, ' +
        '  preco                   = :preco ' +
        ' WHERE item_negociacao_id = :item_negociacao_id' +
        ' AND negociacao_id        = :negociacao_id';

      vQry.ParamByName('produto_id').AsInteger          := pNegociacaoItem.ProdutoId;
      vQry.ParamByName('quantidade').AsInteger          := pNegociacaoItem.Quantidade;
      vQry.ParamByName('preco').AsFloat                 := pNegociacaoItem.Preco;
      vQry.ParamByName('item_negociacao_id').AsInteger  := pNegociacaoItem.Id;
      vQry.ParamByName('negociacao_id').AsInteger       := pNegociacaoItem.NegociacaoId;

      vQry.ExecSQL;

      if vQry.RowsAffected = 0 then
      begin
        raise Exception.Create('Nenhum registro foi atualizado. Verifique se o código da negociacao é válido.');
      end;

      FConexao.CommitTransaction;
      Result := True;
    finally
      vQry.Free;
    end;
  except
    on E: Exception do
    begin
      FConexao.RollbackTransaction;
      raise Exception.Create('Erro ao atualizar o produto: ' + E.Message);
    end;
  end;
end;

end.
