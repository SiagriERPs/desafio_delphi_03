unit uProdutorAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmProdutorAltera = class(TForm)
    grdProdutor: TDBGrid;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uProdutorCadastro;

procedure TfrmProdutorAltera.btnAlterarClick(Sender: TObject);
var
  lfrmProdutorCadastro: TfrmProdutorCadastro;
begin
  lfrmProdutorCadastro := TfrmProdutorCadastro.Create(Application);

  try
    lfrmProdutorCadastro.Codigo := DM.qryProdutor.FieldByName('Codigo').AsInteger;
    lfrmProdutorCadastro.Nome := DM.qryProdutor.FieldByName('nome').AsString;
    lfrmProdutorCadastro.CPFCNPJ := DM.qryProdutor.FieldByName('cpfcnpj').AsString;
    lfrmProdutorCadastro.ShowModal;
    DM.qryProdutor.DisableControls;
  finally
    FreeAndNil(lfrmProdutorCadastro);
    DM.qryProdutor.Close;
    DM.qryProdutor.Open;
    DM.qryProdutor.EnableControls;
  end;
end;

procedure TfrmProdutorAltera.btnFecharClick(Sender: TObject);
begin
  DM.qryProdutor.Close;
  Close;
end;

procedure TfrmProdutorAltera.FormShow(Sender: TObject);
begin
  DM.qryProdutor.Open;
end;

end.
