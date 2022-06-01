unit frmPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fmBasico, DB, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  ComCtrls, Vcl.DBCtrls;

type
  TfmPesquisa = class(TfmAnyForm)
    pcPesquisa: TPageControl;
    tbsLocaliza: TTabSheet;
    dbgPesquisa: TDBGrid;
    bbPesquisar: TBitBtn;
    bbVisualizar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure bbPesquisarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    TipoAcesso : Integer;
  public
    { Public declarations }
    Sucesso : Boolean;
    published
      property Acesso : Integer read TipoAcesso write TipoAcesso Default 0;
  end;

var
  fmPesquisa: TfmPesquisa;

implementation

{$R *.dfm}

procedure TfmPesquisa.FormCreate(Sender: TObject);
begin
  inherited;
  Sucesso := False;
end;

procedure TfmPesquisa.dbgPesquisaDblClick(Sender: TObject);
begin
  inherited;
  if Sucesso
    then bbFecharClick(sender);
end;

procedure TfmPesquisa.bbPesquisarClick(Sender: TObject);
begin
  inherited;
  Sucesso := not DataSource.DataSet.IsEmpty;
  if not Sucesso then begin
    ShowMessage('Não foi encontrado nenhum registro que satisfaça sua pesquisa.');
    Abort;
  end;
end;

procedure TfmPesquisa.FormActivate(Sender: TObject);
begin
  inherited;
  pcPesquisa.ActivePageIndex := 0;
  Sucesso := not DataSource.DataSet.IsEmpty;
end;

end.
