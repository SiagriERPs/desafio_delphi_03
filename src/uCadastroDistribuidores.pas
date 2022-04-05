unit uCadastroDistribuidores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, System.ImageList,
  Vcl.ImgList, dxGDIPlusClasses;

type
  TfrmCadDistribuidores = class(TfrmCadPadrao)
    FDQCadastro: TFDQuery;
    FDQCadastroID: TIntegerField;
    FDQCadastroNOME: TStringField;
    FDQCadastroCNPJ: TStringField;
    dbedtID: TDBEdit;
    dbedtNOME: TDBEdit;
    dbedtCNPJ: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FDQCadastroCNPJGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure dbedtCNPJKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDistribuidores: TfrmCadDistribuidores;

implementation

{$R *.dfm}


uses ConexaoDB, GETFuncoes;

procedure TfrmCadDistribuidores.dbedtCNPJKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(CharInSet(Key, ['0' .. '9', #8])) then
    Key := #0;
end;

procedure TfrmCadDistribuidores.FDQCadastroCNPJGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := FormataCPF_CNPJ(Sender.AsString);
end;

procedure TfrmCadDistribuidores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadDistribuidores := Nil;
end;

end.
