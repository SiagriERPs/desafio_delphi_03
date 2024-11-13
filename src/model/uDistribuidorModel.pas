unit uDistribuidorModel;

interface

uses
  uEnumerado,
  FireDAC.Comp.Client;

type
  TDistribuidorModel = class
  private
    FAction        : TAction;
    FId            : Integer;
    FNome          : string;
    FCpfCnpj       : string;

    procedure setAction(const Value: TAction);
    procedure setId(const Value: Integer);
    procedure setNome(const Value: string);
    procedure setCpfCnpj(const Value: string);
  public
    function obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(pAutoIncremento: Integer): Integer;

    property Action        : TAction  read FAction        write setAction;
    property Id            : Integer  read FId            write setId;
    property Nome          : string   read FNome          write setNome;
    property CpfCnpj       : string   read FCpfCnpj       write setCpfCnpj;
  end;

implementation

{ TDistribuidorModel }

uses
  uDistribuidorDAO;

function TDistribuidorModel.GetId(pAutoIncremento: Integer): Integer;
var
  vDistribuidorDAO: TDistribuidorDAO;
begin
  vDistribuidorDAO := TDistribuidorDAO.Create;
  try
    Result := vDistribuidorDAO.GetId(pAutoIncremento);
  finally
    vDistribuidorDAO.Free;
  end;
end;

function TDistribuidorModel.obter: TFDQuery;
var
  vDistribuidorDAO: TDistribuidorDAO;
begin
  vDistribuidorDAO := TDistribuidorDAO.Create;
  try
    Result := vDistribuidorDAO.Obter;
  finally
    vDistribuidorDAO.Free;
  end;
end;

function TDistribuidorModel.Salvar: Boolean;
var
  vDistribuidorDAO: TDistribuidorDAO;
begin
  Result := False;

  vDistribuidorDAO := TDistribuidorDAO.Create;
  try
    case FAction of
      uEnumerado.tacInclude : Result := vDistribuidorDAO.Inserir(Self);
      uEnumerado.tacChange  : Result := vDistribuidorDAO.Alterar(Self);
      uEnumerado.tacDelete  : Result := vDistribuidorDAO.Deletar(Self);
    end;
  finally
    vDistribuidorDAO.Free;
  end;
end;

procedure TDistribuidorModel.setAction(const Value: TAction);
begin
  FAction := Value;
end;

procedure TDistribuidorModel.setCpfCnpj(const Value: string);
begin
  FCpfCnpj := Value;
end;

procedure TDistribuidorModel.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TDistribuidorModel.setNome(const Value: string);
begin
  FNome := Value;
end;

end.
