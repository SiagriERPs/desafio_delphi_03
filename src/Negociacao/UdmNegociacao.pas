unit UdmNegociacao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Dialogs, ppDB, ppDBPipe,
  ppComm, ppRelatv, ppProd, ppClass, ppReport, ppDesignLayer, ppParameter,
  ppVar, ppPrnabl, ppCtrls, ppBands, ppCache;

type
  TdmNegociacao = class(TDataModule)
    fdqyNegociacao: TFDQuery;
    dsNegociacao: TDataSource;
    dsItens_Negociacao: TDataSource;
    fdqyItens_Negociacao: TFDQuery;
    fdqyListaCodificacao: TFDQuery;
    fdqyListaDistribuidor: TFDQuery;
    fdqyListaProdutor: TFDQuery;
    fdqyListaProduto: TFDQuery;
    fdqyListaProdutoPRODUTO_ID: TIntegerField;
    fdqyListaProdutoPR_NOME: TStringField;
    fdqyListaProdutoPR_PRECOVENDA: TSingleField;
    fdqyListaDistribuidorDISTRIBUIDOR: TStringField;
    fdqyListaDistribuidorCNPJ: TStringField;
    fdqyListaDistribuidorCODIGO_DISTRIBUIDOR: TIntegerField;
    fdqyListaDistribuidorLIMITE_CREDITO: TSingleField;
    fdqyListaDistribuidorVALOR_UTILIZADO: TSingleField;
    fdqyListaDistribuidorVALOR_CREDITO: TFloatField;
    fdqyItens_NegociacaoNEGOCIACAO_ID: TIntegerField;
    fdqyItens_NegociacaoPRODUTO_ID: TIntegerField;
    fdqyItens_NegociacaoPR_NOME: TStringField;
    fdqyItens_NegociacaoPR_PRECOVENDA: TSingleField;
    fdqyItens_NegociacaoIN_VALOR: TSingleField;
    fdqyItens_NegociacaoPRODUTOR_ID: TIntegerField;
    fdqyItens_NegociacaoDISTRIBUIDOR_ID: TIntegerField;
    fdqyItens_NegociacaoValor_Itens: TAggregateField;
    fdqyAtualizaNegociacao: TFDQuery;
    fdqyAtualiza_Credito_Liberado: TFDQuery;
    ppReport: TppReport;
    ppDBPipeline: TppDBPipeline;
    dsRelatorio: TDataSource;
    fdqyRelatorio: TFDQuery;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppDBCalc1: TppDBCalc;
    ppLabel8: TppLabel;
    procedure fdqyNegociacaoNewRecord(DataSet: TDataSet);
    procedure fdqyNegociacaoBeforePost(DataSet: TDataSet);
    procedure fdqyItens_NegociacaoBeforePost(DataSet: TDataSet);
    procedure fdqyItens_NegociacaoNewRecord(DataSet: TDataSet);
    procedure fdqyItens_NegociacaoAfterPost(DataSet: TDataSet);

  private
    { Private declarations }

  public
    { Public declarations }
     procedure AtualizaStatusNegociacao(pedido, novoStatus, StatusAnterior : Integer);
     procedure AtualizaValor(pedido: Integer; valor: Double);
  end;

var
  dmNegociacao: TdmNegociacao;

implementation

uses UdmConexao, UdmFuncoes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmNegociacao.AtualizaStatusNegociacao(pedido, novoStatus,
  StatusAnterior: Integer);
begin
  try
     fdqyAtualizaNegociacao.Params.ParamByName('NEGOCIACAO_ID').AsInteger := pedido;
     if not fdqyAtualizaNegociacao.IsEmpty then begin
       dmConexao.FDTransaction.StartTransaction;
       fdqyAtualizaNegociacao.Edit;
       fdqyAtualizaNegociacao.FieldByName('N_Status').AsInteger := novoStatus;
       case novoStatus  of
         3 : fdqyAtualizaNegociacao.FieldByName('N_DATA_APROVACAO').AsDateTime := date;
         4 : fdqyAtualizaNegociacao.FieldByName('N_DATA_CONCLUSAO').AsDateTime := date;
         5 : fdqyAtualizaNegociacao.FieldByName('N_DATA_CANCELAMENTO').AsDateTime := date;
       end;
       fdqyAtualizaNegociacao.Post;
       fdqyNegociacao.CommitUpdates;
     end
     else begin
       Beep;
       ShowMessage('Nenhum registro foi encontrado');
     end;

  except
     dmConexao.FDTransaction.Rollback;
     ShowMessage('Erro ao atualizar a negociação!');
     Exit;
  end;
end;

procedure TdmNegociacao.AtualizaValor(pedido: Integer; valor: Double);
begin
   try
     fdqyAtualiza_Credito_Liberado.Params.ParamByName('Prod_Distrib_Id').AsInteger := pedido;
     fdqyAtualiza_Credito_Liberado.Params.ParamByName('Valor').AsFloat             := Valor;
     fdqyAtualiza_Credito_Liberado.ExecSQL;
   except
   end;
end;

procedure TdmNegociacao.fdqyItens_NegociacaoAfterPost(DataSet: TDataSet);
begin
   try

     if fdqyItens_Negociacao.ChangeCount > 0
       then fdqyItens_Negociacao.CommitUpdates;

   except

   end;
end;



procedure TdmNegociacao.fdqyItens_NegociacaoBeforePost(DataSet: TDataSet);
begin
  try
     if (fdqyItens_Negociacao.FieldByName('Valor_Itens').AsVariant >
         fdqyListaDistribuidor.FieldByName('VALOR_CREDITO').AsFloat ) then begin
       Beep;
       ShowMessage('Atenção! Valor total dos itens está maior que o Saldo Restante');
       Abort;
      end
      else fdqyNegociacao.FieldByName('N_ValorTotal').AsFloat := fdqyItens_Negociacao.FieldByName('Valor_Itens').AsVariant;
  except

  end;
end;

procedure TdmNegociacao.fdqyItens_NegociacaoNewRecord(DataSet: TDataSet);
begin
   try
     fdqyItens_Negociacao.FieldByName('Produtor_Id').AsInteger     := fdqyItens_Negociacao.MasterSource.DataSet.FieldByName('Produtor_ID').AsInteger;
     fdqyItens_Negociacao.FieldByName('Distribuidor_Id').AsInteger := fdqyItens_Negociacao.MasterSource.DataSet.FieldByName('Distribuidor_Id').AsInteger;
   except

   end;
end;

procedure TdmNegociacao.fdqyNegociacaoBeforePost(DataSet: TDataSet);
begin
  try
    if (fdqyListaDistribuidor.FieldByName('VALOR_CREDITO').AsFloat = 0) then begin
      Beep;
      ShowMessage('Atenção! Produtor sem CRÉDITO para efetuar negociação com esse Distribuidor!');
      fdqyNegociacao.CancelUpdates;
      Abort;
    end;
  except
    fdqyNegociacao.CancelUpdates;
  end;
end;

procedure TdmNegociacao.fdqyNegociacaoNewRecord(DataSet: TDataSet);
var
  nroLivre : Integer;
begin
  try
       nroLivre := dmFuncoes.NumeroLivre(1, 'NEGOCIACAO');
       if nroLivre > 0
          then begin
             fdqyNegociacao.FieldByName('NEGOCIACAO_ID').AsInteger := nroLivre;
             fdqyNegociacao.FieldByName('N_Status').AsInteger      := 2; //Pendente
             fdqyNegociacao.FieldByName('DATACAD').AsDateTime      := date;
          end
          else begin
            Beep;
            ShowMessage('Atenção! Erro ao gerar Número da Negociação');
            Abort;
          end;
   except
     fdqyNegociacao.Cancel;
     raise;
   end;

end;


end.
