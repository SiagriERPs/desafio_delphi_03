unit UdmDistribuidor;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Dialogs;

type
  TdmDistribuidor = class(TDataModule)
    fdqyDistribuidor: TFDQuery;
    procedure fdqyDistribuidorNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDistribuidor: TdmDistribuidor;

implementation

uses UdmConexao, UdmFuncoes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDistribuidor.fdqyDistribuidorNewRecord(DataSet: TDataSet);
var
  nroLivre : Integer;
begin
   try
       nroLivre := dmFuncoes.NumeroLivre(1, 'DISTRIBUIDOR');
       if nroLivre > 0
          then begin
             fdqyDistribuidor.FieldByName('DISTRIBUIDOR_ID').AsInteger := nroLivre;
             fdqyDistribuidor.FieldByName('D_CNPJ').EditMask           := '99.999.999/9999-99;0;_';
          end
          else begin
            Beep;
            ShowMessage('Atenção! Erro ao gerar ID do Distribuidor');
            Abort;
          end;
   except
     fdqyDistribuidor.Cancel;
     raise;
   end;
end;

end.
