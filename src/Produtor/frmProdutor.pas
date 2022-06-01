unit frmProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmBasico, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfmProdutor = class(TfmAnyForm)
    dbgProdutor: TDBGrid;
    paPrincipal: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    dbeInscricaoCPF: TDBEdit;
    dbrgbTipoProdutor: TDBRadioGroup;
    DBEdit4: TDBEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    dlcListaDistribuidor: TDBLookupComboBox;
    DBEdit3: TDBEdit;
    dsListaDistribuidor: TDataSource;
    Label6: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label7: TLabel;
    DBNavigator_Prod_Distrib: TDBNavigator;
    procedure dbrgbTipoProdutorClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProdutor: TfmProdutor;

implementation

uses UdmProdutor, UdmConexao;

{$R *.dfm}

procedure TfmProdutor.dbrgbTipoProdutorClick(Sender: TObject);
begin
  inherited;
  case dbrgbTipoProdutor.ItemIndex of
    0 : DataSource.DataSet.FieldByName('P_InscricaoFiscal').EditMask := '999.999.999-99;0;_';
    1 : DataSource.DataSet.FieldByName('P_InscricaoFiscal').EditMask := '99.999.999/9999-99;0;_'
  end;
end;

procedure TfmProdutor.FormActivate(Sender: TObject);
begin
  inherited;
   dmProdutor.fdqyListaDistribuidor.Open;
   dmProdutor.fdqyProdutor.Open;
   dmProdutor.fdqyProd_Distribuidor.Open;

end;

end.
