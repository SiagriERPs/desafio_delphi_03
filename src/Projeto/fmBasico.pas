unit fmBasico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Db, ComCtrls, ToolWin, Grids, DBGrids,
  DBCtrls, Vcl.Buttons;

type
  TfmAnyForm = class(TForm)
    paTopo: TPanel;
    Label1: TLabel;
    img: TImage;
    paMeio: TPanel;
    DataSource: TDataSource;
    bbAjuda: TBitBtn;
    bbFechar: TBitBtn;
    paNave: TPanel;
    DBNavigator: TDBNavigator;
    procedure bbFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAnyForm: TfmAnyForm;

implementation

{$R *.DFM}

procedure TfmAnyForm.bbFecharClick(Sender: TObject);
begin
   Close;
end;


procedure TfmAnyForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (ActiveControl is TDBMemo) then exit;
  if (ActiveControl is TButton) then exit;
  if (ActiveControl is TDBLookupComboBox) and
     ((ActiveControl as TDBLookupComboBox).ListVisible) then exit;
  if (Key = #13) or (Key = #9) then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

end.
