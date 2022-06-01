unit UdmProdutor;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Datasnap.DBClient, Datasnap.Provider,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Dialogs;

type
  TdmProdutor = class(TDataModule)
    fdqyProdutor: TFDQuery;
    fdqyProd_Distribuidor: TFDQuery;
    ds_Prod_Distribuidor: TDataSource;
    dsProdutor: TDataSource;
    fdqyProdutorPRODUTOR_ID: TIntegerField;
    fdqyProdutorP_NOME: TStringField;
    fdqyProdutorP_STATUS: TSmallintField;
    fdqyProdutorUSUARIO_CAD: TIntegerField;
    fdqyProdutorDATAHORA_CAD: TSQLTimeStampField;
    fdqyProdutorUSUARIO_ALTER: TIntegerField;
    fdqyProdutorDATAHORA_ALTER: TSQLTimeStampField;
    fdqyProdutorP_TIPO: TStringField;
    fdqyProdutorP_INSCRICAOFISCAL: TStringField;
    fdqyProd_DistribuidorPROD_DISTRIB_ID: TIntegerField;
    fdqyProd_DistribuidorPRODUTOR_ID: TIntegerField;
    fdqyProd_DistribuidorDISTRIBUIDOR_ID: TIntegerField;
    fdqyProd_DistribuidorPD_LIMITECREDITO: TSingleField;
    fdqyProd_DistribuidorPD_STATUS: TSmallintField;
    fdqyProd_DistribuidorUSUARIOCAD: TIntegerField;
    fdqyProd_DistribuidorDATAHORACAD: TSQLTimeStampField;
    fdqyProd_DistribuidorUSUARIOALTER: TIntegerField;
    fdqyProd_DistribuidorDATAHORAALTER: TSQLTimeStampField;
    fdqyListaDistribuidor: TFDQuery;
    fdqyProd_DistribuidorD_NOME: TStringField;
    fdqyProd_DistribuidorD_CNPJ: TStringField;
    procedure fdqyProdutorNewRecord(DataSet: TDataSet);
    procedure fdqyProd_DistribuidorNewRecord(DataSet: TDataSet);
    procedure fdqyProd_DistribuidorAfterPost(DataSet: TDataSet);
    procedure fdqyProdutorBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProdutor: TdmProdutor;

implementation

uses UdmConexao, UdmFuncoes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmProdutor.fdqyProdutorBeforePost(DataSet: TDataSet);
begin
  try
    if fdqyProdutor.ChangeCount > 0
      then
         fdqyProdutor.CommitUpdates;

  except
    fdqyProdutor.CancelUpdates;
    dmConexao.FDTransaction.Rollback;
  end;
end;

procedure TdmProdutor.fdqyProdutorNewRecord(DataSet: TDataSet);
var
  nroLivre : Integer;
begin
   try
       nroLivre := dmFuncoes.NumeroLivre(1, 'PRODUTOR');
       if nroLivre > 0
          then begin
             fdqyProdutor.FieldByName('PRODUTOR_ID').AsInteger := nroLivre;
          end
          else begin
            Beep;
            ShowMessage('Atenção! Erro ao gerar ID do Produtor');
            Abort;
          end;
   except
     fdqyProdutor.Cancel;
     raise;
   end;

end;

procedure TdmProdutor.fdqyProd_DistribuidorAfterPost(DataSet: TDataSet);
begin
  try
    if fdqyProd_Distribuidor.ChangeCount > 0
      then
         fdqyProd_Distribuidor.CommitUpdates;

  except
     fdqyProd_Distribuidor.CancelUpdates;
     dmConexao.FDTransaction.Rollback;

  end;
end;

procedure TdmProdutor.fdqyProd_DistribuidorNewRecord(DataSet: TDataSet);
var
  nroLivre : Integer;
begin
  try
       nroLivre := dmFuncoes.NumeroLivre(1, 'PROD_DISTRIBUIDOR');
       if nroLivre > 0
          then begin
             fdqyProd_Distribuidor.FieldByName('PROD_DISTRIB_ID').AsInteger := nroLivre;
          end
          else begin
            Beep;
            ShowMessage('Atenção! Erro ao gerar ID do Produtor_Distribuidor');
            Abort;
          end;
   except
     fdqyProd_Distribuidor.Cancel;
     raise;
   end;
end;

end.
