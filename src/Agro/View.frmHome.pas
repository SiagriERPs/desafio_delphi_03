unit View.frmHome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, UDM, UBD;

type
  TfrmHome = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    mMenu: TMainMenu;
    miCadastros: TMenuItem;
    miDistribuidores: TMenuItem;
    miProdutor: TMenuItem;
    N1: TMenuItem;
    miProdutos: TMenuItem;
    miComercial: TMenuItem;
    miContratos: TMenuItem;
    miSair: TMenuItem;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    lblTitulo: TLabel;
    Panel9: TPanel;
    lblMenuDistribuidores: TLabel;
    lblMenuProdutores: TLabel;
    lblMenuProdutos: TLabel;
    lblMenuCointratos: TLabel;
    Label1: TLabel;
    procedure miSairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure miProdutosClick(Sender: TObject);
    procedure miProdutorClick(Sender: TObject);
    procedure miDistribuidoresClick(Sender: TObject);
    procedure miContratosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.dfm}

uses View.frmProdutos, View.frmProdutores, View.frmDistribuidores,
  View.frmContratos;

procedure TfrmHome.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If ( Chr(Key) = #27) Then
   begin
      Close
   end;
end;

procedure TfrmHome.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
    begin
        Key := #0;
        Perform(Wm_NextDlgCtl,0,0);
    end;
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
    if DM.conexao.Connected = False then
    begin
          if not Conectar = True then
          begin
              Application.Terminate
          end else begin

          end;
    end;
end;

procedure TfrmHome.miContratosClick(Sender: TObject);
begin
    Application.CreateForm(TfrmContratos, frmContratos);
    frmContratos.ShowModal;
end;

procedure TfrmHome.miDistribuidoresClick(Sender: TObject);
begin
    Application.CreateForm(TfrmDistribuidores, frmDistribuidores);
    frmDistribuidores.ShowModal;
end;

procedure TfrmHome.miProdutorClick(Sender: TObject);
begin
    Application.CreateForm(TfrmProdutores, frmProdutores);
    frmProdutores.ShowModal;
end;

procedure TfrmHome.miProdutosClick(Sender: TObject);
begin
    Application.CreateForm(TfrmProdutos, frmProdutos);
    frmProdutos.ShowModal;
end;

procedure TfrmHome.miSairClick(Sender: TObject);
begin
    Close;
end;

end.
