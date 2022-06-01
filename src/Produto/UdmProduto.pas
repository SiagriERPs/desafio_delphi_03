unit UdmProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Dialogs;

type
  TdmProduto = class(TDataModule)
    fdqyProduto: TFDQuery;
    fdqyProdutoPRODUTO_ID: TIntegerField;
    fdqyProdutoPR_NOME: TStringField;
    fdqyProdutoPR_PRECOVENDA: TSingleField;
    fdqyProdutoPR_STATUS: TSmallintField;
    fdqyProdutoUSUARIOCAD: TIntegerField;
    fdqyProdutoDATAHORACAD: TSQLTimeStampField;
    fdqyProdutoUSUARIOALTER: TIntegerField;
    fdqyProdutoDATAHORAALTER: TSQLTimeStampField;
    procedure fdqyProdutoNewRecord(DataSet: TDataSet);
    procedure fdqyProdutoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProduto: TdmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao, UdmFuncoes;

{$R *.dfm}

procedure TdmProduto.fdqyProdutoAfterPost(DataSet: TDataSet);
begin
  try
     dmConexao.FDTransaction.CommitRetaining;
  except

  end;
end;

procedure TdmProduto.fdqyProdutoNewRecord(DataSet: TDataSet);
var
  nroLivre : Integer;
begin
   try
       nroLivre := dmFuncoes.NumeroLivre(1, 'PRODUTO');
       if nroLivre > 0
          then begin
             fdqyProduto.FieldByName('PRODUTO_ID').AsInteger := nroLivre;
          end
          else begin
            Beep;
            ShowMessage('Atenção! Erro ao gerar Código do Produto');
            Abort;
          end;
   except
     fdqyProduto.Cancel;
     raise;
   end;
end;

end.
