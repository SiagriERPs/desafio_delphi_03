unit uFrmCadBasico;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  uEnumerado,
  uBiblioteca,
  Vcl.ComCtrls;

type
  TFrmCadBasico = class(TFrmBasico)
    pnButtons: TPanel;
    spbInserir: TSpeedButton;
    spbAlterar: TSpeedButton;
    spbExcluir: TSpeedButton;
    spbCancelar: TSpeedButton;
    spbSair: TSpeedButton;
    spbPesquisar: TSpeedButton;
    spbGravar: TSpeedButton;
    pgcMain: TPageControl;
    tbMain: TTabSheet;
    procedure spbInserirClick(Sender: TObject);
    procedure spbAlterarClick(Sender: TObject);
    procedure spbExcluirClick(Sender: TObject);
    procedure spbCancelarClick(Sender: TObject);
    procedure spbGravarClick(Sender: TObject);
    procedure spbPesquisarClick(Sender: TObject);
    procedure spbSairClick(Sender: TObject);
  private

  public
  protected
    procedure Inserir; virtual;
    procedure Alterar; virtual;
    procedure Excluir; virtual;
    procedure Cancelar; virtual;
    procedure Pesquisar; virtual;
    procedure Gravar; virtual;

    procedure Modo(pModo: TControlButtons); virtual;
  end;

var
  FrmCadBasico: TFrmCadBasico;

implementation

{$R *.dfm}

{ TFrmCadBasico }

procedure TFrmCadBasico.Alterar;
begin

end;

procedure TFrmCadBasico.Cancelar;
begin

end;

procedure TFrmCadBasico.Excluir;
begin

end;

procedure TFrmCadBasico.Gravar;
begin

end;

procedure TFrmCadBasico.Inserir;
begin

end;

procedure TFrmCadBasico.Modo(pModo: TControlButtons);
begin
  if pModo = uEnumerado.statusInitial then
  begin
    spbInserir.Enabled   := True;
    spbAlterar.Enabled   := False;
    spbExcluir.Enabled   := False;
    spbCancelar.Enabled  := False;
    spbGravar.Enabled    := False;
    spbPesquisar.Enabled := True;
    spbSair.Enabled      := True;
    tbMain.Enabled       := False;
  end
  else
  if pModo = uEnumerado.statusInclude then
  begin
    spbInserir.Enabled   := False;
    spbAlterar.Enabled   := False;
    spbExcluir.Enabled   := False;
    spbCancelar.Enabled  := True;
    spbGravar.Enabled    := True;
    spbPesquisar.Enabled := False;
    spbSair.Enabled      := False;
    tbMain.Enabled       := True;
  end
  else
  if pModo = uEnumerado.statusSearch then
  begin
    spbInserir.Enabled   := False;
    spbAlterar.Enabled   := True;
    spbExcluir.Enabled   := True;
    spbCancelar.Enabled  := True;
    spbGravar.Enabled    := False;
    spbPesquisar.Enabled := False;
    spbSair.Enabled      := False;
    tbMain.Enabled       := False;
  end;
end;

procedure TFrmCadBasico.Pesquisar;
begin

end;

procedure TFrmCadBasico.spbAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TFrmCadBasico.spbCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TFrmCadBasico.spbExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFrmCadBasico.spbGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFrmCadBasico.spbInserirClick(Sender: TObject);
begin
  Inserir;
end;

procedure TFrmCadBasico.spbPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TFrmCadBasico.spbSairClick(Sender: TObject);
begin
  Close;
end;

end.
