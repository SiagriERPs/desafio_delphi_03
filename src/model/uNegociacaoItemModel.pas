unit uNegociacaoItemModel;

interface

uses
  uEnumerado,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TNegociacaoItemModel = class
  private
    FAction           : TAction;
    FId               : Integer;
    FNegociacaoId     : Integer;
    FProdutoId        : Integer;
    FProduto          : string;
    FQuantidade       : Integer;
    FPreco            : Currency;

    procedure setAction(const Value: TAction);
    procedure setId(const Value: Integer);
    procedure setNegociacaoId(const Value: Integer);
    procedure setProdutoId(const Value: Integer);
    procedure setProduto(const Value: string);
    procedure setQuantidade(const Value: Integer);
    procedure setPreco(const Value: Currency);

  public
    function obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(pAutoIncremento: Integer): Integer;
    function ObterItensNegociacao(pNegociacaoID: Integer): TList<TNegociacaoItemModel>;

    property Action           : TAction  read FAction            write setAction;
    property Id               : Integer  read FId                write setId;
    property NegociacaoId     : Integer  read FNegociacaoId      write setNegociacaoId;
    property ProdutoId        : Integer  read FProdutoId         write setProdutoId;
    property Produto          : string   read FProduto           write setProduto;
    property Quantidade       : Integer  read FQuantidade        write setQuantidade;
    property Preco            : Currency read FPreco             write setPreco;

  end;

implementation

{ TNegociacaoItemModel }

uses
  uNegociacaoItemDAO;

function TNegociacaoItemModel.GetId(pAutoIncremento: Integer): Integer;
var
  vNegociacaoItemDAO: TNegociacaoItemDAO;
begin
  vNegociacaoItemDAO := TNegociacaoItemDAO.Create;
  try
    Result := vNegociacaoItemDAO.GetId(pAutoIncremento);
  finally
    vNegociacaoItemDAO.Free;
  end;
end;

function TNegociacaoItemModel.obter: TFDQuery;
var
  vNegociacaoItemDAO: TNegociacaoItemDAO;
begin
  vNegociacaoItemDAO := TNegociacaoItemDAO.Create;
  try
    Result := vNegociacaoItemDAO.Obter;
  finally
    vNegociacaoItemDAO.Free;
  end;
end;

function TNegociacaoItemModel.ObterItensNegociacao(pNegociacaoID: Integer): TList<TNegociacaoItemModel>;
var
  vNegociacaoItemDAO: TNegociacaoItemDAO;
begin
  vNegociacaoItemDAO := TNegociacaoItemDAO.Create;
  try
    Result := vNegociacaoItemDAO.CarregarItensNegociacao(pNegociacaoID);
  finally
    vNegociacaoItemDAO.Free;
  end;
end;

function TNegociacaoItemModel.Salvar: Boolean;
var
  vNegociacaoItemDAO: TNegociacaoItemDAO;
begin
  Result := False;

  vNegociacaoItemDAO := TNegociacaoItemDAO.Create;
  try
    case FAction of
      uEnumerado.tacInclude : Result := vNegociacaoItemDAO.Inserir(Self);
      uEnumerado.tacChange  : Result := vNegociacaoItemDAO.Alterar(Self);
      uEnumerado.tacDelete  : Result := vNegociacaoItemDAO.Deletar(Self);
    end;
  finally
    vNegociacaoItemDAO.Free;
  end;
end;

procedure TNegociacaoItemModel.setAction(const Value: TAction);
begin
  FAction := Value;
end;

procedure TNegociacaoItemModel.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TNegociacaoItemModel.setNegociacaoId(const Value: Integer);
begin
  FNegociacaoId := Value;
end;

procedure TNegociacaoItemModel.setPreco(const Value: Currency);
begin
  FPreco := Value;
end;

procedure TNegociacaoItemModel.setProduto(const Value: string);
begin
  FProduto := Value;
end;

procedure TNegociacaoItemModel.setProdutoId(const Value: Integer);
begin
  FProdutoId := Value;
end;

procedure TNegociacaoItemModel.setQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

end.
