unit frmDistribuidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmBasico, Vcl.DBCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfmDistribuidor = class(TfmAnyForm)
    paDados: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBGrid1: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fdqyDistribuidorNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDistribuidor: TfmDistribuidor;

implementation

uses UdmConexao, UdmFuncoes, UdmDistribuidor ;

{$R *.dfm}

procedure TfmDistribuidor.fdqyDistribuidorNewRecord(DataSet: TDataSet);
var
  nroLivre : Integer;
begin
   inherited;
   with dmDistribuidor do try

       nroLivre := dmFuncoes.NumeroLivre(1, 'DISTRIBUIDOR');
       if nroLivre > 0
          then begin
             fdqyDistribuidor.FieldByName('DISTRIBUIDOR_ID').AsInteger := nroLivre;
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

procedure TfmDistribuidor.FormActivate(Sender: TObject);
begin
  inherited;
  dmDistribuidor.fdqyDistribuidor.Close;
  dmDistribuidor.fdqyDistribuidor.Open;

end;

procedure TfmDistribuidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataSource.DataSet.Close;
  inherited;

end;

end.
