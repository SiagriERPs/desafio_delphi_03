unit uProdutoModel;

interface

uses
  uEnumerado,
  FireDAC.Comp.Client;

type
  TProdutoModel = class
  private
    FAction     : TAction;
    FId         : Integer;
    FNome       : string;
    FPrecoVenda : Currency;

    procedure setAction(const Value: TAction);
    procedure setId(const Value: Integer);
    procedure setNome(const Value: string);
    procedure setPrecoVenda(const Value: Currency);
  public
    function obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(pAutoIncremento: Integer): Integer;

    property Action     : TAction  read FAction     write setAction;
    property Id         : Integer  read FId         write setId;
    property Nome       : string   read FNome       write setNome;
    property PrecoVenda : Currency read FPrecoVenda write setPrecoVenda;
  end;

implementation

{ TProdutoModel }

uses
  uProdutoDAO;

function TProdutoModel.GetId(pAutoIncremento: Integer): Integer;
var
  vProdutoDAO: TProdutoDAO;
begin
  vProdutoDAO := TProdutoDAO.Create;
  try
    Result := vProdutoDAO.GetId(pAutoIncremento);
  finally
    vProdutoDAO.Free;
  end;
end;

function TProdutoModel.obter: TFDQuery;
var
  vProdutoDAO: TProdutoDAO;
begin
  vProdutoDAO := TProdutoDAO.Create;
  try
    Result := vProdutoDAO.Obter;
  finally
    vProdutoDAO.Free;
  end;
end;

function TProdutoModel.Salvar: Boolean;
var
  vProdutoDAO: TProdutoDAO;
begin
  Result := False;

  vProdutoDAO := TProdutoDAO.Create;
  try
    case FAction of
      uEnumerado.tacInclude : Result := vProdutoDAO.Inserir(Self);
      uEnumerado.tacChange  : Result := vProdutoDAO.Alterar(Self);
      uEnumerado.tacDelete  : Result := vProdutoDAO.Deletar(Self);
    end;
  finally
    vProdutoDAO.Free;
  end;
end;

procedure TProdutoModel.setAction(const Value: TAction);
begin
  FAction := Value;
end;

procedure TProdutoModel.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TProdutoModel.setNome(const Value: string);
begin
  FNome := Value;
end;

procedure TProdutoModel.setPrecoVenda(const Value: Currency);
begin
  FPrecoVenda := Value;
end;

end.
