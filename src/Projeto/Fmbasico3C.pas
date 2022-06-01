unit Fmbasico3C;

interface

uses
  Windows, Db, StdCtrls, Buttons, Graphics, Controls, ExtCtrls, Classes,Forms,
  dbclient,dbctrls,ComCtrls, Messages;

type
  TFrmbasico3C = class(TForm)
    paTopo: TPanel;
    Label1: TLabel;
    img: TImage;
    paMeio: TPanel;
    DataSource: TDataSource;
    bbFechar: TBitBtn;
    bbAjuda: TBitBtn;
    bbImprimir: TBitBtn;
    procedure bbFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    UltimoComponente: Integer;

  public
    { Public declarations }
    procedure ClasseparaCds( var Cds : TClientDataSet; CamposCds : array of string;
                                               ValorClasse : array of Variant;criaBd:boolean );
    published
  end;

var
  Frmbasico3C: TFrmbasico3C;
  FormatoDataMaquinaAnterior, FormatoDataMaquina : string;

implementation

{$R *.DFM}

procedure TFrmbasico3C.ClasseparaCds( var Cds : TClientDataSet; CamposCds : array of string;
                                               ValorClasse : array of Variant; criaBd:boolean );
var
  i : integer;
  nome : string;
begin
  with Cds do
  begin
    if CriaBd then
    begin
      close;
      createDataset;
      open;
    end;
    Cds.Insert;
    for i := Low(CamposCds) to High(CamposCds) do
    begin
      Nome := CamposCds[i];
      Cds.fieldbyname(Nome).Value := ValorClasse[i];
    end;
    Cds.Post;
  end;
end;

procedure TFrmbasico3C.bbFecharClick(Sender: TObject);
begin
     Close;
end;

procedure TFrmbasico3C.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (ActiveControl is TDBMemo) then exit;
  if (ActiveControl is TCustomRichEdit) then exit;
  if (ActiveControl is TButton) then exit;
  if (ActiveControl is TDBLookupComboBox) and
     ((ActiveControl as TDBLookupComboBox).ListVisible) then exit;
  if (Key = #13) or (Key = #9) then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFrmbasico3C.FormCreate(Sender: TObject);
var
  cor : TColor;
begin
   cor := TColor($D4D754);
   patopo.Color := cor;
   //54D7D4  $96982a
end;


end.
