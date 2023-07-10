unit Negociacao;

interface

uses
  System.SysUtils;

type
  TNegociacao = class
  private
    FID: integer;
    FIdProdutor: integer;
    FIdDistribuidor: integer;
    FIdStatus: integer;
    FValorTotal: Double;
    FDataCriacao: TDateTime;
    FDataAprovacao: TDateTime;
    FDataConclusao: TDateTime;
    FDataCancelamento: TDateTime;
  public
    property ID: integer read FID;
    property IdProdutor: integer read FIdProdutor;
    property IdDistribuidor: integer read FIdDistribuidor;
    property IdStatus: integer read FIdStatus;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property DataCriacao: TDateTime read FDataCriacao write FDataCriacao;
    property DataAprovacao: TDateTime read FDataAprovacao write FDataAprovacao;
    property DataConclusao: TDateTime read FDataConclusao write FDataConclusao;
    property DataCancelamento: TDateTime read FDataCancelamento write FDataCancelamento;
    constructor Create(const AID, AIdProdutor, AIdDistribuidor, AIdStatus: integer; AValorTotal: Double;
                      const ADataCriacao, ADataAprovacao, ADataConclusao, ADataCancelamento: string);
    destructor Destroy; override;
  end;

implementation


{ TNegociacao }

constructor TNegociacao.Create(const AID, AIdProdutor, AIdDistribuidor, AIdStatus: integer; AValorTotal: Double;
                      const ADataCriacao, ADataAprovacao, ADataConclusao, ADataCancelamento: string);
begin
  FID             := AID;
  FIdProdutor     := AIdProdutor;
  FIdDistribuidor := AIdDistribuidor;
  FIdStatus       := AIdStatus;
  FValorTotal     := AValorTotal;
  FDataCriacao    := StrToDateTime(ADataCriacao);
  if ADataAprovacao.IsEmpty then
    FDataAprovacao := Now
  else
    FDataAprovacao  := StrToDateTime(ADataAprovacao);

  if ADataConclusao.IsEmpty then
    FDataConclusao := Now
  else
    FDataConclusao  := StrToDateTime(ADataConclusao);

  if ADataCancelamento.IsEmpty then
    FDataCancelamento := Now
  else
    FDataCancelamento := StrToDateTime(ADataCancelamento);
end;

destructor TNegociacao.Destroy;
begin
  Self.Free;
  inherited;
end;

end.
