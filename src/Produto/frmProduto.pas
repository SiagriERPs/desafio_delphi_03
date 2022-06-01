unit frmProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmBasico, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask;

type
  TfmProduto = class(TfmAnyForm)
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProduto: TfmProduto;

implementation

uses UdmConexao, UdmProduto;

{$R *.dfm}

procedure TfmProduto.FormActivate(Sender: TObject);
begin
  inherited;
  dmProduto.fdqyProduto.Close;
  dmProduto.fdqyProduto.Open;
end;

end.
