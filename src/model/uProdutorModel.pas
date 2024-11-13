unit uProdutorModel;

interface

uses
  uEnumerado,
  FireDAC.Comp.Client;

type
  TProdutorModel = class
  private
    FAction        : TAction;
    FId            : Integer;
    FNome          : string;
    FCpfCnpj       : string;
    FLimiteCredito : Currency;

    procedure setAction(const Value: TAction);
    procedure setId(const Value: Integer);
    procedure setNome(const Value: string);
    procedure setCpfCnpj(const Value: string);
    procedure setLimiteCredito(const Value: Currency);
  public
    function obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(pAutoIncremento: Integer): Integer;

    property Action        : TAction  read FAction        write setAction;
    property Id            : Integer  read FId            write setId;
    property Nome          : string   read FNome          write setNome;
    property CpfCnpj       : string   read FCpfCnpj       write setCpfCnpj;
    property LimiteCredito : Currency read FLimiteCredito write setLimiteCredito;
  end;

implementation

{ TProdutorModel }

uses
  uProdutorDAO;

function TProdutorModel.GetId(pAutoIncremento: Integer): Integer;
var
  vProdutorDAO: TProdutorDAO;
begin
  vProdutorDAO := TProdutorDAO.Create;
  try
    Result := vProdutorDAO.GetId(pAutoIncremento);
  finally
    vProdutorDAO.Free;
  end;
end;

function TProdutorModel.obter: TFDQuery;
var
  vProdutorDAO: TProdutorDAO;
begin
  vProdutorDAO := TProdutorDAO.Create;
  try
    Result := vProdutorDAO.Obter;
  finally
    vProdutorDAO.Free;
  end;
end;

function TProdutorModel.Salvar: Boolean;
var
  vProdutorDAO: TProdutorDAO;
begin
  Result := False;

  vProdutorDAO := TProdutorDAO.Create;
  try
    case FAction of
      uEnumerado.tacInclude : Result := vProdutorDAO.Inserir(Self);
      uEnumerado.tacChange  : Result := vProdutorDAO.Alterar(Self);
      uEnumerado.tacDelete  : Result := vProdutorDAO.Deletar(Self);
    end;
  finally
    vProdutorDAO.Free;
  end;
end;

procedure TProdutorModel.setAction(const Value: TAction);
begin
  FAction := Value;
end;

procedure TProdutorModel.setCpfCnpj(const Value: string);
begin
  FCpfCnpj := Value;
end;

procedure TProdutorModel.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TProdutorModel.setLimiteCredito(const Value: Currency);
begin
  FLimiteCredito := Value;
end;

procedure TProdutorModel.setNome(const Value: string);
begin
  FNome := Value;
end;

end.
