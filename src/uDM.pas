unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXInterbase, Data.DB, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dialogs;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDTransaction1: TFDTransaction;
    qryProdutor: TFDQuery;
    qryProduto: TFDQuery;
    qryDistribuidor: TFDQuery;
    qryNegociacao: TFDQuery;
    qryNegociacaoDetalhe: TFDQuery;
    dtsProdutor: TDataSource;
    dtsProduto: TDataSource;
    qryProdutoCODIGO: TSmallintField;
    qryProdutoNOME: TStringField;
    qryProdutoVALOR: TSingleField;
    dtsDistribuidor: TDataSource;
    qryDistribuidorCODIGO: TSmallintField;
    qryDistribuidorNOME: TStringField;
    qryDistribuidorCPFCNPJ: TStringField;
    dtsNegociacao: TDataSource;
    qryNegociacaoCODIGO: TSmallintField;
    qryNegociacaoPRODUTOR: TSmallintField;
    qryNegociacaoDISTRIBUIDOR: TSmallintField;
    qryNegociacaoVALOR: TSingleField;
    qryNegociacaoDATA: TDateField;
    qryNegociacaoSTATUS: TSmallintField;
    qryNegociacaoDetalheCODIGO: TSmallintField;
    qryNegociacaoDetalheNEGOCIACAO: TSmallintField;
    qryNegociacaoDetalhePRODUTO: TSmallintField;
    qryConsultaProduto: TFDQuery;
    qryConsultaProdutoCODIGO: TSmallintField;
    qryConsultaProdutoNOME: TStringField;
    qryConsultaProdutoVALOR: TSingleField;
    dtsConsultaProduto: TDataSource;
    qryConsultaNegociacao: TFDQuery;
    dtsConsultaNegociacao: TDataSource;
    qryConsultaNegociacaoCODIGO: TSmallintField;
    qryConsultaNegociacaoPRODUTOR: TSmallintField;
    qryConsultaNegociacaoNOMEPRODUTOR: TStringField;
    qryConsultaNegociacaoDISTRIBUIDOR: TSmallintField;
    qryConsultaNegociacaoNOMEDISTRIBUIDOR: TStringField;
    qryConsultaNegociacaoNOMESTATUS: TStringField;
    qryConsultaNegociacaoSTATUS: TSmallintField;
    qryConsultaNegociacaoDATA: TDateField;
    qryConsultaNegociacaoVALOR: TSingleField;
    qryProdutorCODIGO: TSmallintField;
    qryProdutorNOME: TStringField;
    qryProdutorCPFCNPJ: TStringField;
    qryCredito: TFDQuery;
    dtsCredito: TDataSource;
    qryCreditoCODIGO: TSmallintField;
    qryCreditoPRODUTOR: TSmallintField;
    qryCreditoDISTRIBUIDOR: TSmallintField;
    qryCreditoVALOR: TSingleField;
    qryCreditoNOMEDISTRIBUIDOR: TStringField;
    qryConsultaCredito: TFDQuery;
    qryConsultaCreditoVALOR: TFloatField;
    qryConsultaCreditoUsado: TFDQuery;
    FloatField1: TFloatField;
  private
    { Private declarations }
    function GetCodigoTabela(pCampo, pNomeTabela: String): Integer;
  public
    { Public declarations }
    function ObterCodigoTabela(pCampo, pNomeTabela: String): Integer;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.GetCodigoTabela(pCampo, pNomeTabela: String): Integer;
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(Self);

  try
    lQry.Connection := FDConnection;
    lQry.SQL.Add('SELECT MAX(' + pCampo + ') AS Codigo');
    lQry.SQL.Add('FROM ' + pNomeTabela);

    try
      lQry.Open;

      Result := lQry.FieldByName('Codigo').AsInteger + 1;
    except
      On E:Exception do
      begin
        MessageDlg('Ocoreu o erro ' + E.Message + ' ao obter o código da tabela ' + pNomeTabela, mtInformation, [mbOk], 0);
      end;
    end;
  finally
    lQry.Close;
    FreeAndNil(lQry);
  end;
end;

function TDM.ObterCodigoTabela(pCampo, pNomeTabela: String): Integer;
begin
  Result := GetCodigoTabela(pCampo, pNomeTabela);
end;

end.
