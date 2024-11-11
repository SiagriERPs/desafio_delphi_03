unit uFrmPesquisaBasico;

interface

uses
  uFrmBasico,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFrmPesquisaBasico = class(TFrmBasico)
    pnlFilter: TPanel;
    lblFilter: TLabel;
    spbPesquisa: TSpeedButton;
    edtNome: TEdit;
    procedure spbPesquisaClick(Sender: TObject);
  private

  public

  protected
    procedure Pesquisa; virtual;
  end;

var
  FrmPesquisaBasico: TFrmPesquisaBasico;

implementation

{$R *.dfm}

procedure TFrmPesquisaBasico.Pesquisa;
begin

end;

procedure TFrmPesquisaBasico.spbPesquisaClick(Sender: TObject);
begin
  Pesquisa;
end;

end.
