unit uCadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, dxGDIPlusClasses;

type
  TfrmCadProdutos = class(TfrmCadPadrao)
    FDQCadastro: TFDQuery;
    FDQCadastroID: TIntegerField;
    FDQCadastroDESCRICAO: TStringField;
    FDQCadastroPRECO_VENDA: TFMTBCDField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbedtID: TDBEdit;
    dbedtDESCRICAO: TDBEdit;
    dbedtPRECO_VENDA: TDBEdit;
    procedure dbedtPRECO_VENDAKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProdutos: TfrmCadProdutos;

implementation

{$R *.dfm}


uses GETFuncoes, ConexaoDB;

procedure TfrmCadProdutos.dbedtPRECO_VENDAKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) and (Key <> FormatSettings.DecimalSeparator) then
    Key := #0;
end;

procedure TfrmCadProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProdutos := nil;
end;

end.
