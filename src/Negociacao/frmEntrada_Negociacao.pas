unit frmEntrada_Negociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmBasico, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids;

type
  TfmEntrada_Negociacao = class(TfmAnyForm)
    Panel1: TPanel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    dlcProdutor: TDBLookupComboBox;
    dlcProd_Distribuidor: TDBLookupComboBox;
    Label5: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    Label6: TLabel;
    dbeLimiteCredito: TDBEdit;
    Panel2: TPanel;
    dsSituacao: TDataSource;
    dsListaProdutor: TDataSource;
    dsListaDistribuidor: TDataSource;
    dlcListaProduto: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    Label7: TLabel;
    Label8: TLabel;
    dbeSaldoRestante: TDBEdit;
    Label9: TLabel;
    dsListaProduto: TDataSource;
    Label10: TLabel;
    DBEdit2: TDBEdit;
    Label11: TLabel;
    dbe_InValor: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure dlcProdutorCloseUp(Sender: TObject);
    procedure dlcListaProdutoCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEntrada_Negociacao: TfmEntrada_Negociacao;

implementation

uses UdmConexao, UdmFuncoes, UdmNegociacao;

{$R *.dfm}

procedure TfmEntrada_Negociacao.dlcListaProdutoCloseUp(Sender: TObject);
begin
  inherited;
  if dmNegociacao.dsItens_Negociacao.State in [dsInsert, dsEdit] then
    dmNegociacao.dsItens_Negociacao.DataSet.FieldByName('In_Valor').AsFloat :=  dlcListaProduto.DataSource.DataSet.FieldbyName('PR_PRECOVENDA').AsFloat;

end;

procedure TfmEntrada_Negociacao.dlcProdutorCloseUp(Sender: TObject);
begin
  inherited;
  try
    if (dlcProdutor.text <> '') then begin
      dmNegociacao.fdqyListaDistribuidor.Close;
      dmNegociacao.fdqyListaDistribuidor.Params.ParamByName('PRODUTOR_ID').AsInteger := dlcProdutor.KeyValue;
      dmNegociacao.fdqyListaDistribuidor.Open;
    end;

  except

  end;
end;

procedure TfmEntrada_Negociacao.FormActivate(Sender: TObject);
begin
  inherited;
  with dmNegociacao do begin
    fdqyListaCodificacao.Close;
    fdqyListaCodificacao.Params.ParamByName('INTER01').AsInteger := 2;
    fdqyListaCodificacao.Params.ParamByName('INTER02').AsInteger := 5;
    fdqyListaCodificacao.Open;

    fdqyListaProdutor.Close;
    fdqyListaProdutor.Open;

    fdqyNegociacao.Close;
    fdqyNegociacao.Open;

    fdqyItens_Negociacao.Close;
    fdqyItens_Negociacao.Open;

  end;
end;

end.
