unit uProdutorAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmProdutorAltera = class(TForm)
    grdProdutor: TDBGrid;
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutorAltera: TfrmProdutorAltera;

implementation

{$R *.dfm}

uses uDM, uProdutorCadastro;

procedure TfrmProdutorAltera.btnAlterarClick(Sender: TObject);
begin
  DataModule1.qryProdutor.Edit;

  frmProdutorCadastro.edtNome.Text := DataModule1.qryProdutor.FieldByName('nome').AsString;
  frmProdutorCadastro.edtCPFCNPJ.Text := DataModule1.qryProdutor.FieldByName('cpfcnpj').AsString;

  frmProdutorCadastro.ShowModal;
end;

procedure TfrmProdutorAltera.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutorAltera.FormShow(Sender: TObject);
begin
  if DataModule1.qryProdutor.Active = False then
    DataModule1.qryProdutor.Open;
end;

end.
