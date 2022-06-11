unit uNegociacaoAlteraConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.OleAuto;

type
  TfrmNegociacaoAlteraConsulta = class(TForm)
    grdDistribuidor: TDBGrid;
    RadioGroup1: TRadioGroup;
    edtConsulta: TEdit;
    ImageList: TImageList;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
    btnRelatório: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroup1Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnRelatórioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNegociacaoAlteraConsulta: TfrmNegociacaoAlteraConsulta;

implementation

{$R *.dfm}

uses uDM, uNegociacaoCadatro, uPrincipal;

procedure TfrmNegociacaoAlteraConsulta.btnAlterarClick(Sender: TObject);
var
  lfrmNegociacaoCadastro: TfrmNegociacaoCadastro;
begin
  if DM.qryConsultaNegociacao.IsEmpty then
    Abort;

  lfrmNegociacaoCadastro := TfrmNegociacaoCadastro.Create(Application);

  try
    lfrmNegociacaoCadastro.CodigoNegociacao := DM.qryConsultaNegociacao.FieldByName('Codigo').AsInteger;
    lfrmNegociacaoCadastro.CodigoProdutor := DM.qryConsultaNegociacao.FieldByName('Produtor').AsInteger;
    lfrmNegociacaoCadastro.CodigoDistribuidor := DM.qryConsultaNegociacao.FieldByName('Distribuidor').AsInteger;
    lfrmNegociacaoCadastro.Total := DM.qryConsultaNegociacao.FieldByName('valor').AsString;
    lfrmNegociacaoCadastro.DataNegociacao := DM.qryConsultaNegociacao.FieldByName('Data').AsString;
    lfrmNegociacaoCadastro.StatusNegociacao := DM.qryConsultaNegociacao.FieldByName('Status').AsInteger;
    lfrmNegociacaoCadastro.ShowModal;
    DM.qryConsultaNegociacao.DisableControls;
  finally
    FreeAndNil(lfrmNegociacaoCadastro);
    DM.qryConsultaNegociacao.Close;
    DM.qryConsultaNegociacao.Open;
    DM.qryConsultaNegociacao.EnableControls;
  end;
end;

procedure TfrmNegociacaoAlteraConsulta.btnFecharClick(Sender: TObject);
begin
  DM.qryConsultaNegociacao.Close;
  Close;
end;

procedure TfrmNegociacaoAlteraConsulta.edtConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if RadioGroup1.ItemIndex = 0 then
    DM.qryConsultaNegociacao.IndexName := 'IDXPRODUTOR'
  else
    DM.qryConsultaNegociacao.IndexName := 'IDXDISTRIBUIDOR';

  DM.qryConsultaNegociacao.FindNearest([edtConsulta.Text]);
end;

procedure TfrmNegociacaoAlteraConsulta.FormShow(Sender: TObject);
begin
  DM.qryConsultaNegociacao.Open;
end;

procedure TfrmNegociacaoAlteraConsulta.RadioGroup1Click(Sender: TObject);
begin
  edtConsulta.Clear;
end;

procedure TfrmNegociacaoAlteraConsulta.btnRelatórioClick(Sender: TObject);
var Planilha : Variant;
begin
  Try
    Planilha := CreateOleObject('Excel.Application');//Criando a Planilha
    Planilha.WorkBooks.Add(1);
    Planilha.Caption := 'Consulta de Negociações';// + Caption;  //Título que aparece no canto esquerdo superior da tela
    Planilha.Visible := True;

    //Determinando a largura das células
    Planilha.Cells[1,2].ColumnWidth := 15;//Negociação
    Planilha.Cells[1,3].ColumnWidth := 22;//Produtor
    Planilha.Cells[1,4].ColumnWidth := 22;//Distribuidor
    Planilha.Cells[1,5].ColumnWidth := 15;//Data
    Planilha.Cells[1,6].ColumnWidth := 22;//Valor
    Planilha.Cells[1,7].ColumnWidth := 15;//Status

    //Título da Planilha
    Planilha.Cells[1,3].Font.Bold := True;    //Negrito
    Planilha.Cells[1,3].HorizontalAlignment := 3;//Centralizando a célula
    Planilha.Cells[1,3] := 'Consulta de Negociações';
    Planilha.Range['B1:E1'].Mergecells := True;    //Mesclando células

    //Empresa e Ano
    Planilha.Range['B3:G3'].Font.Bold := True; //Negrito
    Planilha.Cells[3,2] := 'Nº Negociação:';
    Planilha.Cells[3,3] := 'Produtor:';
    Planilha.Cells[3,4] := 'Distribuidor:';
    Planilha.Cells[3,5] := 'Data:';
    Planilha.Cells[3,6] := 'Valor:';
    Planilha.Cells[3,7] := 'Status:';

    DM.qryConsultaNegociacao.First;

    while not DM.qryConsultaNegociacao.Eof do
    begin
      Planilha.Cells[3 + DM.qryConsultaNegociacao.RecNo, 2] := DM.qryConsultaNegociacao.FieldByName('Codigo').AsString;
      Planilha.Cells[3 + DM.qryConsultaNegociacao.RecNo, 3] := DM.qryConsultaNegociacao.FieldByName('NomeProdutor').AsString;
      Planilha.Cells[3 + DM.qryConsultaNegociacao.RecNo, 4] := DM.qryConsultaNegociacao.FieldByName('NomeDistribuidor').AsString;
      Planilha.Cells[3 + DM.qryConsultaNegociacao.RecNo, 5] := DM.qryConsultaNegociacao.FieldByName('Data').AsString;
      Planilha.Cells[3 + DM.qryConsultaNegociacao.RecNo, 6] := FormatFloat('###,###,##0.00', DM.qryConsultaNegociacao.FieldByName('Valor').AsFloat);
      Planilha.Cells[3 + DM.qryConsultaNegociacao.RecNo, 7] := DM.qryConsultaNegociacao.FieldByName('NomeStatus').AsString;

      DM.qryConsultaNegociacao.Next;
    end;
  Except
    Messagedlg('Não foi possivel gerar o arquivo de exportação. Verifique se existe o Microsoft Excel instalado.',mtWarning,[mbOk],0);
  end;
end;

end.
