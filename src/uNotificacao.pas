unit uNotificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, JvExControls,
  JvGradientHeaderPanel, dxGDIPlusClasses, Vcl.StdCtrls;

type
  TfrmNotificacao = class(TForm)
    Shape1: TShape;
    pnlFundo: TPanel;
    Label1: TLabel;
    imgInfo: TImage;
    lblTitulo: TLabel;
    lblMsg: TLabel;
    imgQuestion: TImage;
    pnlBotton: TPanel;
    pnlTopo: TPanel;
    pnlAcessar: TPanel;
    btnSim: TSpeedButton;
    pnlCancelar: TPanel;
    btnNao: TSpeedButton;
    pnlRisco: TPanel;
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    pResult: Boolean;
  end;

var
  frmNotificacao: TfrmNotificacao;

implementation

{$R *.dfm}


procedure TfrmNotificacao.btnNaoClick(Sender: TObject);
begin
  pResult := False;
  Close;
end;

procedure TfrmNotificacao.btnSimClick(Sender: TObject);
begin
  pResult := True;
  Close;
end;

procedure TfrmNotificacao.FormCreate(Sender: TObject);
begin
  lblMsg.Caption := string.Empty;
  pnlTopo.Caption := string.Empty;
  pnlBotton.Caption := string.Empty;
  pnlRisco.Caption := string.Empty;
end;

procedure TfrmNotificacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if pnlCancelar.Visible then
      btnNao.Click
    else
      btnSim.Click
  end
  else if Key = VK_RETURN then
    btnSim.Click
end;

end.
