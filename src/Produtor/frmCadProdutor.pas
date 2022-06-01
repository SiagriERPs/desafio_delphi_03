unit frmCadProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmEditDados, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfmCadProdutor = class(TfmDataEdit)
    dbgProdutor: TDBGrid;
    paPrincipal: TPanel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    dbeInscricaoCPF: TDBEdit;
    GroupBox1: TGroupBox;
    DBEdit2: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    dsDistribuidor: TDataSource;
    dbrgbTipoProdutor: TDBRadioGroup;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dsProdutorDistribuidor: TDataSource;
    DBEdit4: TDBEdit;
    DBNavigator: TDBNavigator;
    procedure dbrgbTipoProdutorClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadProdutor: TfmCadProdutor;

implementation

uses UdmConexao, UdmProdutor, Funcoes;

{$R *.dfm}

procedure TfmCadProdutor.dbrgbTipoProdutorClick(Sender: TObject);
begin
  inherited;
  case dbrgbTipoProdutor.ItemIndex of
    0 : DataSource.DataSet.FieldByName('InscricaoFiscal').EditMask := '999.999.999-99;0;_';
    1 : DataSource.DataSet.FieldByName('InscricaoFiscal').EditMask := '99.999.999/9999-99;0;_'
  end;

end;

procedure TfmCadProdutor.FormActivate(Sender: TObject);
begin
  inherited;
  dmProdutor.fdqyProdutor.Open;
end;

end.
