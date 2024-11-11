unit uFrmRelatorioNegociacao;

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
  Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt;

type
  TFrmRelatorioNegociacao = class(TForm)
    QuickRep1: TQuickRep;
  private

  public

  end;

var
  FrmRelatorioNegociacao: TFrmRelatorioNegociacao;

implementation

{$R *.dfm}

end.
