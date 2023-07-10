unit ManutencaoNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  NegociacaoController, StatusController, Negociacao, Status,
  System.Generics.Collections;

type
  TFManutencaoNegociacao = class(TForm)
    pnl_principal: TPanel;
    lbl_form: TLabel;
    btnAlterar: TButton;
    btnSair: TButton;
    cbxNegociacao: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    cbxStatus: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxNegociacaoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    FController: TNegociacaoController;
    FStatusController: TStatusController;
    procedure CarregaNegociacao;
    procedure CarregaStatus;
    procedure LimpaCampos;
  public
    { Public declarations }
  end;

var
  FManutencaoNegociacao: TFManutencaoNegociacao;

implementation

{$R *.dfm}

{ TFManutencaoNegociacao }

procedure TFManutencaoNegociacao.btnAlterarClick(Sender: TObject);
var
  Negociacao: TNegociacao;
  Status: TStatus;
begin
  if (Edit1.Text = '') or (cbxStatus.ItemIndex = -1) then
  begin
    ShowMessage('Deve ser selecionado uma negociação e um status para ser alterado.');
    Abort;
  end;

  Negociacao := TNegociacao(cbxNegociacao.Items.Objects[cbxNegociacao.ItemIndex]);
  Status     := TStatus(cbxStatus.Items.Objects[cbxStatus.ItemIndex]);
  FController.AtualizarStatus(Negociacao.ID, Status.ID);

  if cbxStatus.ItemIndex = 1 then
    FController.AtualizaDataAprovacao(Negociacao.ID, DateToStr(Now))
  else if cbxStatus.ItemIndex = 2 then
    FController.AtualizaDataConclusao(Negociacao.ID, DateToStr(Now))
  else
    FController.AtualizaDataCancelamento(Negociacao.ID, DateToStr(Now));

  ShowMessage('Status de negociacao ' + IntToStr(Negociacao.ID) + ' foi alterado com sucesso.');
  LimpaCampos;
end;

procedure TFManutencaoNegociacao.btnSairClick(Sender: TObject);
begin
  LimpaCampos;
  Close;
end;

procedure TFManutencaoNegociacao.CarregaNegociacao;
var
  Negociacoes: TObjectList<TNegociacao>;
  Negociacao:   TNegociacao;
begin
  cbxNegociacao.Clear;

  Negociacoes := FController.MostrarTodos;
  for Negociacao in Negociacoes do
  begin
    cbxNegociacao.Items.AddObject(IntToStr(Negociacao.ID), TObject(Negociacao));
  end;
end;

procedure TFManutencaoNegociacao.CarregaStatus;
var
  TodosStatus: TObjectList<TStatus>;
  Status:   TStatus;
begin
  cbxStatus.Clear;

  TodosStatus := FStatusController.MostrarTodos;
  for Status in TodosStatus do
  begin
    cbxStatus.Items.AddObject(Status.Status, TObject(Status));
  end;
end;

procedure TFManutencaoNegociacao.cbxNegociacaoChange(Sender: TObject);
var
  Negociacao: TNegociacao;
begin
  Negociacao := TNegociacao(cbxNegociacao.Items.Objects[cbxNegociacao.ItemIndex]);
  Edit1.Text := FStatusController.BuscarEspecifico(Negociacao.IdStatus);
end;

procedure TFManutencaoNegociacao.FormCreate(Sender: TObject);
begin
  FController       := TNegociacaoController.Create;
  FStatusController := TStatusController.Create;
end;

procedure TFManutencaoNegociacao.FormDestroy(Sender: TObject);
begin
  FController.Free;
  FStatusController.Free;
end;

procedure TFManutencaoNegociacao.FormShow(Sender: TObject);
begin
  CarregaNegociacao;
  CarregaStatus;
end;

procedure TFManutencaoNegociacao.LimpaCampos;
begin
  Edit1.Clear;
  cbxNegociacao.ItemIndex := -1;
  cbxStatus.ItemIndex     := -1;
end;

end.
