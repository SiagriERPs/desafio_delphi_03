unit uFrmBasico;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs;

type
  TFrmBasico = class(TForm)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;

var
  FrmBasico: TFrmBasico;

implementation

{$R *.dfm}

procedure TFrmBasico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.
