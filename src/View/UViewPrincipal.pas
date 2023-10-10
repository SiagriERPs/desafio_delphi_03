unit UViewPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls;

type
  TFrmPrincipal = class(TForm)
    PnlMenu: TPanel;
    ImgMenuLogo: TImage;
    BtnMenuNegociacao: TButton;
    BtnMenuProdutos: TButton;
    BtnMenuDistribuidor: TButton;
    BtnMenuProdutor: TButton;
    BtnMenuFechar: TButton;
    PgPrincipal: TPageControl;
    TabHome: TTabSheet;
    TabProdutor: TTabSheet;
    TabDistribuidor: TTabSheet;
    TabProdutos: TTabSheet;
    TabNegociacao: TTabSheet;
    BtnMenuHome: TButton;
    PgProdutor: TPageControl;
    TabProdutorListagem: TTabSheet;
    TabProdutorCadastro: TTabSheet;
    PnlHeadProdutor: TPanel;
    lblHeadProdutor: TLabel;
    BtnHeadProdutor: TButton;
    GridCadProdutor: TDBGrid;
    MemProdutor: TFDMemTable;
    DsProdutor: TDataSource;
    PnlProdutorBtns: TPanel;
    BtnProdutorSalvar: TButton;
    EdtProdutorID: TEdit;
    MemProdutorID: TIntegerField;
    MemProdutorNOME: TStringField;
    MemProdutorCPF_CNPJ: TStringField;
    MemProdutoreditar: TIntegerField;
    MemProdutorexcluir: TIntegerField;
    pnlHeadDistribuidor: TPanel;
    lblHeadDistribuidor: TLabel;
    BtnHeadDistribuidor: TButton;
    PgDistribuidor: TPageControl;
    TabDistribuidorListagem: TTabSheet;
    GridCadDistribuidor: TDBGrid;
    TabDistribuidorCadastro: TTabSheet;
    LblDistribuidorNome: TLabel;
    LblDistribuidorCNPJ: TLabel;
    EdtDistribuidorNome: TEdit;
    EdtDistribuidorCNPJ: TEdit;
    OnlDistribuidorBtns: TPanel;
    BtnDistribuidorSalvar: TButton;
    EdtDistribuidorID: TEdit;
    MemDistribuidor: TFDMemTable;
    MemDistribuidorID: TIntegerField;
    MemDistribuidorNOME: TStringField;
    MemDistribuidorCNPJ: TStringField;
    MemDistribuidorEditar: TIntegerField;
    MemDistribuidorExcluir: TIntegerField;
    DsDistribuidor: TDataSource;
    PnlProdutorDados: TPanel;
    LblProdutorNome: TLabel;
    EdtProdutorNome: TEdit;
    LblProdutorCPFCNPJ: TLabel;
    EdtProdutorCPFCNPJ: TEdit;
    PnlProdutorVinculacao: TPanel;
    PnlProdutorVinculacaoDados: TPanel;
    pnlProdutorVinculacaoHead: TPanel;
    lblProdutorVinculacaoHead: TLabel;
    GridProdutorVinculacao: TDBGrid;
    lblProdutorVinculacaoDistribuidor: TLabel;
    lblProdutorVinculacaoLimite: TLabel;
    EdtProdutorVinculacaoLimite: TEdit;
    btnProdutorVinculacaoSalvar: TButton;
    MemVinculacaoComercial: TFDMemTable;
    IntegerField6: TIntegerField;
    DsVinculacaoComercial: TDataSource;
    MemVinculacaoComercialFk_Distribuidor: TIntegerField;
    MemVinculacaoComercialFk_Produtor: TIntegerField;
    MemVinculacaoComercialDistribuidor: TStringField;
    cbProdutorVinculacaoDistribuidor: TComboBox;
    MemVinculacaoComerciallimite_credito: TCurrencyField;
    MemVinculacaoComercialID: TIntegerField;
    TabHeadProdutos: TPanel;
    lblHeadProdutos: TLabel;
    BtnHeadProdutos: TButton;
    PgProdutos: TPageControl;
    TabProdutosListagem: TTabSheet;
    GridCadProdutos: TDBGrid;
    TabProdutosCadastro: TTabSheet;
    LblProdutosDescricao: TLabel;
    lblProdutosPreco: TLabel;
    EdtProdutosDESCRICAO: TEdit;
    EdtProdutosPRECO: TEdit;
    PnlProdutosBtns: TPanel;
    BtnProdutoSalvar: TButton;
    EdtProdutosID: TEdit;
    Image1: TImage;
    MemProdutos: TFDMemTable;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    DsProdutos: TDataSource;
    MemProdutosDESCRICAO: TStringField;
    MemProdutosPRECO_VENDA: TCurrencyField;
    MemProdutosID: TIntegerField;
    pnlHeadNegociacao: TPanel;
    lblHeadNegociacao: TLabel;
    BtnHeadNegociacao: TButton;
    pgNegociacao: TPageControl;
    TabNegociacaoListagem: TTabSheet;
    GridNegociacao: TDBGrid;
    TabNegociacaoCadastro: TTabSheet;
    PnlNegociacaoBtns: TPanel;
    BtnNegociacaoSalvar: TButton;
    EdtNegociacaoId: TEdit;
    MemNegociacao: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField4: TIntegerField;
    MemNegociacaoID: TIntegerField;
    DsNegociacao: TDataSource;
    PnlNegociacaoDados: TPanel;
    Label2: TLabel;
    CBNegociacaoProdutor: TComboBox;
    Label3: TLabel;
    CbNegociacaoDistribuidor: TComboBox;
    CbNegociacaoStatus: TComboBox;
    Label4: TLabel;
    Label1: TLabel;
    EdtNegociacaoValor: TEdit;
    Panel1: TPanel;
    Label5: TLabel;
    CbNegociacaoProduto: TComboBox;
    Label6: TLabel;
    EdtNegociacaoProdutoQtd: TEdit;
    Label7: TLabel;
    EdtNegociacaoProdutoTotais: TEdit;
    BtnNegociacaoProdutoInserir: TButton;
    GridNegociacaoProduto: TDBGrid;
    MemNegociacaoItens: TFDMemTable;
    DsNegociacaoItens: TDataSource;
    MemNegociacaoItensID: TIntegerField;
    MemNegociacaoItensDESCRICAO: TStringField;
    MemNegociacaoItensVALOR_UN: TCurrencyField;
    MemNegociacaoItensQTD: TFloatField;
    MemNegociacaoItensVALOR_TOTAL: TCurrencyField;
    MemNegociacaoItensFK_PRODUTO: TIntegerField;
    MemNegociacaoItensexcluir: TIntegerField;
    MemNegociacaoFK_VINCULACAO_COMERCIAL: TIntegerField;
    MemNegociacaoVALOR: TCurrencyField;
    MemNegociacaoSTATUS: TStringField;
    MemNegociacaoProdutor: TStringField;
    MemNegociacaoDistribuidor: TStringField;
    MemNegociacaoItensFK_NEGOCIACAO: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure BtnMenuHomeClick(Sender: TObject);
    procedure BtnMenuProdutorClick(Sender: TObject);
    procedure BtnMenuDistribuidorClick(Sender: TObject);
    procedure BtnMenuProdutosClick(Sender: TObject);
    procedure BtnMenuNegociacaoClick(Sender: TObject);
    procedure BtnMenuFecharClick(Sender: TObject);
    procedure BtnHeadProdutorClick(Sender: TObject);
    procedure GridCadProdutorDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BtnProdutorSalvarClick(Sender: TObject);
    procedure EdtProdutorCPFCNPJExit(Sender: TObject);
    procedure BtnProdutorVoltarClick(Sender: TObject);
    procedure GridCadProdutorCellClick(Column: TColumn);
    procedure BtnHeadDistribuidorClick(Sender: TObject);
    procedure GridCadDistribuidorDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BtnDistribuidorSalvarClick(Sender: TObject);
    procedure EdtDistribuidorCNPJExit(Sender: TObject);
    procedure GridCadDistribuidorCellClick(Column: TColumn);
    procedure EdtProdutorVinculacaoLimiteKeyPress(Sender: TObject;
      var Key: Char);
    procedure cbProdutorVinculacaoDistribuidorChange(Sender: TObject);
    procedure btnProdutorVinculacaoSalvarClick(Sender: TObject);
    procedure GridProdutorVinculacaoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure GridProdutorVinculacaoCellClick(Column: TColumn);
    procedure BtnHeadProdutosClick(Sender: TObject);
    procedure GridCadProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridCadProdutosCellClick(Column: TColumn);
    procedure BtnProdutoSalvarClick(Sender: TObject);
    procedure BtnHeadNegociacaoClick(Sender: TObject);
    procedure CbNegociacaoProdutoChange(Sender: TObject);
    procedure EdtNegociacaoProdutoQtdChange(Sender: TObject);
    procedure BtnNegociacaoProdutoInserirClick(Sender: TObject);
    procedure GridNegociacaoProdutoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure GridNegociacaoProdutoCellClick(Column: TColumn);
    procedure GridNegociacaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BtnNegociacaoSalvarClick(Sender: TObject);
    procedure CBNegociacaoProdutorChange(Sender: TObject);
    procedure CbNegociacaoDistribuidorChange(Sender: TObject);
    procedure GridNegociacaoCellClick(Column: TColumn);
  private
    { Private declarations }
    procedure navigate(rota: integer); // 0 - home, 1 - produtor, 2 - distribuidor, 3 - produtos, 4 - negociacao, 5 - fechar
    procedure ResetPages;
    procedure goHome;
    procedure goProdutor;
      procedure navigateProdutor;
      procedure popularProdutor;
      procedure popularProdutorVinculacaoComercial;
    procedure goDistribuidor;
      procedure navigateDistribuidor;
      procedure popularDistribuidor;
    procedure goProdutos;
      procedure navigateProdutos;
      procedure popularProdutos;
    procedure goNegociacao;
      procedure navigateNegociacao;
      procedure popularNegociacao;
      procedure popularNegociacaoItens;
    procedure goFechar;

    function salvarProdutor           : Boolean;
    function salvarProdutorVinculacao : Boolean;
    procedure editarProdutor;
    procedure excluirProdutor;
    procedure excluirVinculacao;

    function SalvarDistribuidor       : Boolean;
    procedure editarDistribuidor;
    procedure excluirDistribuidor;

    function  salvarProduto           : Boolean;
    procedure editarProduto;
    procedure excluirProduto;

    procedure selecionaProduto;
    procedure inserirProduto(fk_Produto: Integer; Descricao: String; Valor_Un: Currency; Qtd: Double; Valor_Total: Currency );
    function getLimiteCredito: Double;
    procedure calculaNegociacaoTotal;
    procedure excluirNegociacaoProduto;
    procedure editarNegociacao;
    procedure excluirNegociacao;

    function SalvarNegociacao: Boolean;

    function formatarCPFCNPJ(CPFCNPJ: String): String;

    function validarProdutor: Boolean;
    function validarProdutorVinculacao: Boolean;
    function validarDistribuidor: Boolean;
    function validarProduto: Boolean;
    function validarNegociacao: Boolean;
    function getVinculacao: integer;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses UControllerConexao, UControllerProdutor, UEnumerador, UControllerCPFCNPJ,
  UControllerDistribuidor, UControllerVinculacaoComercial, UControllerProdutos,
  UControllerNegociacao, UControllerNegociacaoItens;

procedure TFrmPrincipal.BtnDistribuidorSalvarClick(Sender: TObject);
begin
  if SalvarDistribuidor then
    navigateDistribuidor;
end;

procedure TFrmPrincipal.BtnHeadDistribuidorClick(Sender: TObject);
begin
  navigateDistribuidor;
end;

procedure TFrmPrincipal.BtnHeadNegociacaoClick(Sender: TObject);
begin
  EdtNegociacaoId.Text := '';
  navigateNegociacao;
end;

procedure TFrmPrincipal.BtnHeadProdutorClick(Sender: TObject);
begin
  navigateProdutor;
end;

procedure TFrmPrincipal.BtnHeadProdutosClick(Sender: TObject);
begin
  navigateProdutos;
end;

procedure TFrmPrincipal.BtnMenuDistribuidorClick(Sender: TObject);
begin
  navigate(2);
end;

procedure TFrmPrincipal.BtnMenuFecharClick(Sender: TObject);
begin
  navigate(5);
end;

procedure TFrmPrincipal.BtnMenuHomeClick(Sender: TObject);
begin
  navigate(0);
end;

procedure TFrmPrincipal.BtnMenuNegociacaoClick(Sender: TObject);
begin
  navigate(4);
end;

procedure TFrmPrincipal.BtnMenuProdutorClick(Sender: TObject);
begin
  navigate(1);
end;

procedure TFrmPrincipal.BtnMenuProdutosClick(Sender: TObject);
begin
    navigate(3);
end;

procedure TFrmPrincipal.BtnNegociacaoProdutoInserirClick(Sender: TObject);
begin
  if SalvarNegociacao then
  inserirProduto(MemProdutosID.Value,
                 MemProdutosDESCRICAO.Value,
                 MemProdutosPRECO_VENDA.Value,
                 StrToFloat(EdtNegociacaoProdutoQtd.Text),
                 StrToFloat(EdtNegociacaoProdutoQtd.Text) * MemProdutosPRECO_VENDA.Value);
end;

procedure TFrmPrincipal.BtnNegociacaoSalvarClick(Sender: TObject);
begin
  if SalvarNegociacao then
    navigateNegociacao;
end;

procedure TFrmPrincipal.BtnProdutorSalvarClick(Sender: TObject);
begin
  if SalvarProdutor then
    navigateProdutor;
end;

procedure TFrmPrincipal.btnProdutorVinculacaoSalvarClick(Sender: TObject);
begin
  salvarProdutorVinculacao;
end;

procedure TFrmPrincipal.BtnProdutorVoltarClick(Sender: TObject);
begin
  navigateProdutor
end;

procedure TFrmPrincipal.BtnProdutoSalvarClick(Sender: TObject);
begin
  if SalvarProduto then
    navigateProdutos;
end;

procedure TFrmPrincipal.calculaNegociacaoTotal;
var Total: Double;
begin
  MemNegociacaoItens.First;
  Total := 0;
  while not MemNegociacaoItens.Eof do
  begin
    Total := Total + MemNegociacaoItensVALOR_TOTAL.Value;
    MemNegociacaoItens.Next;
  end;

  EdtNegociacaoValor.Text := FloatToStr(Total);

end;

procedure TFrmPrincipal.CbNegociacaoDistribuidorChange(Sender: TObject);
begin
  MemDistribuidor.Locate('NOME', CbNegociacaoDistribuidor.Text, []);
end;

procedure TFrmPrincipal.CbNegociacaoProdutoChange(Sender: TObject);
begin
  selecionaProduto;
end;

procedure TFrmPrincipal.CBNegociacaoProdutorChange(Sender: TObject);
begin
    MemProdutor.Locate('NOME', CBNegociacaoProdutor.Text, []);
end;

procedure TFrmPrincipal.cbProdutorVinculacaoDistribuidorChange(Sender: TObject);
begin
  MemDistribuidor.Locate('NOME', cbProdutorVinculacaoDistribuidor.Text, []);
end;

procedure TFrmPrincipal.editarDistribuidor;
begin
   EdtDistribuidorID.Text      := MemDistribuidor.FieldByName('ID').Text;
   EdtDistribuidorNome.Text    := MemDistribuidor.FieldByName('NOME').Text;
   EdtDistribuidorCNPJ.Text := MemDistribuidor.FieldByName('CNPJ').Text;
   navigateDistribuidor;
end;

procedure TFrmPrincipal.editarNegociacao;
begin

  CBNegociacaoProdutor.clear;
  CBNegociacaoProdutor.items.add(MemNegociacaoProdutor.Text);
  CBNegociacaoProdutor.ItemIndex := 0;
  CBNegociacaoProdutor.enabled     := false;

  CbNegociacaoDistribuidor.Clear;
  CbNegociacaoDistribuidor.items.add(MemNegociacaoDistribuidor.Text);
  CbNegociacaoDistribuidor.ItemIndex := 0;
  CbNegociacaoDistribuidor.Enabled := false;

  CbNegociacaoStatus.Enabled       := True;
  EdtNegociacaoId.Text             := MemNegociacaoID.text;
  EdtNegociacaoValor.Text          := MemNegociacaoVALOR.Text;

  navigateNegociacao;
end;

procedure TFrmPrincipal.editarProduto;
begin
   EdtProdutosID.Text           := MemProdutos.FieldByName('ID').Text;
   EdtProdutosDESCRICAO.Text    := MemProdutos.FieldByName('DESCRICAO').Text;
   EdtProdutosPRECO.Text        := MemProdutos.FieldByName('PRECO_VENDA').Text;
   navigateProdutos;
end;

procedure TFrmPrincipal.editarProdutor;
begin
   EdtProdutorID.Text      := MemProdutor.FieldByName('ID').Text;
   EdtProdutorNome.Text    := MemProdutor.FieldByName('NOME').Text;
   EdtProdutorCPFCNPJ.Text := MemProdutor.FieldByName('CPF_CNPJ').Text;
   navigateProdutor;
end;

procedure TFrmPrincipal.EdtDistribuidorCNPJExit(Sender: TObject);
begin
  if Length(EdtDistribuidorCNPJ.Text) >= 14 then
  begin
    EdtDistribuidorCNPJ.Text := formatarCPFCNPJ(EdtDistribuidorCNPJ.Text);
  end
  else
  begin
    Showmessage('CNPJ inválido');
    EdtDistribuidorCNPJ.Text := '';
    EdtDistribuidorCNPJ.SetFocus;
  end;
end;

procedure TFrmPrincipal.EdtNegociacaoProdutoQtdChange(Sender: TObject);
begin
  if EdtNegociacaoProdutoQtd.text = '' then
    EdtNegociacaoProdutoQtd.text := '1';
  selecionaProduto;
end;

procedure TFrmPrincipal.EdtProdutorCPFCNPJExit(Sender: TObject);
begin
  EdtProdutorCPFCNPJ.Text := formatarCPFCNPJ(EdtProdutorCPFCNPJ.Text);
end;

procedure TFrmPrincipal.EdtProdutorVinculacaoLimiteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key in ['0'..'9', ','] = false) then
      key := #0;
end;

procedure TFrmPrincipal.excluirDistribuidor;
var
  ControllerDistribuidor: TControllerDistribuidor;
begin
  If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      ControllerDistribuidor := TControllerDistribuidor.Create;
      try
        ControllerDistribuidor.ModelDistribuidor.enuTipo := UEnumerador.tipoExclusao;
        ControllerDistribuidor.ModelDistribuidor.ID      := MemDistribuidor.FieldByName('ID').value;

        if ControllerDistribuidor.persistir then
        begin
          ShowMessage('Distribuidor Excluído com sucesso!');
        end
        else
        begin
          ShowMessage('Ocorreu um erro ao excluir o Distribuidor!');
        end;

        popularDistribuidor;

      finally
        FreeAndNil(ControllerDistribuidor);
      end;
    end;
end;

procedure TFrmPrincipal.excluirNegociacao;
var
  ControllerNegociacao: TControllerNegociacao;
begin
  If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      ControllerNegociacao := TControllerNegociacao.Create;
      try
        ControllerNegociacao.ModelNegociacao.enuTipo := UEnumerador.tipoExclusao;
        ControllerNegociacao.ModelNegociacao.ID      := MemNegociacao.FieldByName('ID').value;

        if ControllerNegociacao.persistir then
        begin
          ShowMessage('Negociação Excluída com sucesso!');
        end
        else
        begin
          ShowMessage('Ocorreu um erro ao excluir a negociação!');
        end;

        popularNegociacao;

      finally
        FreeAndNil(ControllerNegociacao);
      end;
    end;
end;
procedure TFrmPrincipal.excluirNegociacaoProduto;
var
  ControllerNegociacaoItens: TControllerNegociacaoItens;
begin
  If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      ControllerNegociacaoItens := TControllerNegociacaoItens.Create;
      try
        ControllerNegociacaoItens.ModelNegociacaoItens.enuTipo := UEnumerador.tipoExclusao;
        ControllerNegociacaoItens.ModelNegociacaoItens.ID      := MemNegociacaoItensId.Value;

        if ControllernegociacaoItens.persistir then
        begin
          ShowMessage('Item excluído com sucesso!');
        end
        else
        begin
          ShowMessage('Ocorreu um erro ao excluir o Item!');
        end;

        popularNegociacaoItens;

      finally
        FreeAndNil(ControllernegociacaoItens);
      end;
    end;
end;

procedure TFrmPrincipal.excluirProduto;
var
  ControllerProdutos: TControllerProdutos;
begin
  If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      ControllerProdutos := TControllerProdutos.Create;
      try
        ControllerProdutos.ModelProdutos.enuTipo := UEnumerador.tipoExclusao;
        ControllerProdutos.ModelProdutos.ID      := MemProdutos.FieldByName('ID').value;

        if ControllerProdutos.persistir then
        begin
          ShowMessage('Produto Excluído com sucesso!');
        end
        else
        begin
          ShowMessage('Ocorreu um erro ao excluir o produto!');
        end;

        popularProdutos;

      finally
        FreeAndNil(ControllerProdutos);
      end;
    end;
end;

procedure TFrmPrincipal.excluirProdutor;
var
  ControllerProdutor: TControllerProdutor;
begin
  If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      ControllerProdutor := TControllerProdutor.Create;
      try
        ControllerProdutor.ModelProdutor.enuTipo := UEnumerador.tipoExclusao;
        ControllerProdutor.ModelProdutor.ID      := MemProdutor.FieldByName('ID').value;

        if ControllerProdutor.persistir then
        begin
          ShowMessage('Produtor Excluído com sucesso!');
        end
        else
        begin
          ShowMessage('Ocorreu um erro ao excluir o produtor!');
        end;

        popularProdutor;

      finally
        FreeAndNil(ControllerProdutor);
      end;
    end;
end;

procedure TFrmPrincipal.excluirVinculacao;
var
  ControllerVinculacaoComercial: TControllerVinculacaoComercial;
begin
  If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      ControllerVinculacaoComercial := TControllerVinculacaoComercial.Create;
      try
        ControllerVinculacaoComercial.ModelVinculacaoComercial.enuTipo := UEnumerador.tipoExclusao;
        ControllerVinculacaoComercial.ModelVinculacaoComercial.ID     :=
        MemVinculacaoComercial.FieldByName('ID').value;

        if ControllerVinculacaoComercial.persistir then
        begin
          ShowMessage('Vinculação Excluído com sucesso!');
        end
        else
        begin
          ShowMessage('Ocorreu um erro ao excluir a Vinculação!');
        end;

        popularProdutorVinculacaoComercial;

      finally
        FreeAndNil(ControllerVinculacaoComercial);
      end;
    end;
end;

function TFrmPrincipal.formatarCPFCNPJ(CPFCNPJ: String): String;
var
  ControllerCPFCNPJ: TControllerCPFCNPJ;
begin
  Result := '';
  ControllerCPFCNPJ := TControllerCPFCNPJ.Create;
    try
      ControllerCPFCNPJ.ModelCPFCNPJ.CPF_CNPJ := CPFCNPJ;
      if ControllerCPFCNPJ.formatar = 'INVALIDO' then
      begin
        Showmessage('CPF/CNPJ inválido');
      end
      else
        Result := ControllerCPFCNPJ.formatar;
    finally
      FreeAndNil(ControllerCPFCNPJ);
    end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  TabHome.TabVisible                    := false;
  TabProdutor.TabVisible                := false;
  TabProdutorListagem.TabVisible        := false;
  TabProdutorCadastro.TabVisible        := false;
  TabDistribuidor.TabVisible            := false;
  TabDistribuidorListagem.TabVisible    := false;
  TabDistribuidorCadastro.TabVisible    := false;
  TabProdutos.TabVisible                := false;
  TabProdutosListagem.TabVisible        := false;
  TabProdutosCadastro.TabVisible        := false;
  TabNegociacao.TabVisible              := false;
  TabNegociacaoListagem.TabVisible      := false;
  TabNegociacaoCadastro.TabVisible      := false;

  navigate(0);

  TControllerConexao.getInstance().daoConexao.getConexao.Connected := true;
end;

function TFrmPrincipal.getLimiteCredito: Double;
var
  ControllerVinculacaoComercial: TControllerVinculacaoComercial;
  qVinculacaoComercial: TFDQuery;
begin

  Result := 0;

  qVinculacaoComercial := TFDQuery.Create(nil);
  ControllerVinculacaoComercial := TControllerVinculacaoComercial.Create;
  try
    ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_PRODUTOR     := MemProdutorID.Value;
    ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_DISTRIBUIDOR := MemDistribuidorID.Value;
    qVinculacaoComercial := ControllerVinculacaoComercial.selecionar;
    try
      qVinculacaoComercial.FetchAll;
      MemVinculacaoComercial.close;
      MemVinculacaoComercial.Data := qVinculacaoComercial.Data;
      if MemVinculacaoComercial.RecordCount > 0 then
      begin
        ControllerVinculacaoComercial.ModelVinculacaoComercial.ID := MemVinculacaoComercialID.Value;
        Result := ControllerVinculacaoComercial.getLimiteCredito;
      end;
    finally
      qVinculacaoComercial.close;
      FreeAndNil(qVinculacaoComercial);
    end;
  finally
    FreeAndNil(ControllerVinculacaoComercial);
  end;
end;

function TFrmPrincipal.getVinculacao: integer;
var
  ControllerVinculacaoComercial: TControllerVinculacaoComercial;
  qVinculacaoComercial: TFDQuery;
begin

  Result := 0;

  qVinculacaoComercial := TFDQuery.Create(nil);
  ControllerVinculacaoComercial := TControllerVinculacaoComercial.Create;
  try
    ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_PRODUTOR     := MemProdutorID.Value;
    ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_DISTRIBUIDOR := MemDistribuidorID.Value;
    qVinculacaoComercial := ControllerVinculacaoComercial.selecionar;
    try
      qVinculacaoComercial.FetchAll;
      MemVinculacaoComercial.close;
      MemVinculacaoComercial.Data := qVinculacaoComercial.Data;
      if MemVinculacaoComercial.RecordCount > 0 then
        Result := MemVinculacaoComercialID.Value;
    finally
      qVinculacaoComercial.close;
      FreeAndNil(qVinculacaoComercial);
    end;
  finally
    FreeAndNil(ControllerVinculacaoComercial);
  end;
end;

procedure TFrmPrincipal.goDistribuidor;
begin
  PgPrincipal.ActivePageIndex     := 2;
  PgDistribuidor.ActivePageIndex  := 0;
  lblHeadDistribuidor.Caption     := 'Distribuidor';
  BtnHeadDistribuidor.Caption     := 'Cadastrar';
  BtnMenuHome.Enabled             := true;
  BtnMenuNegociacao.Enabled       := true;
  BtnMenuProdutos.Enabled         := true;
  BtnMenuDistribuidor.Enabled     := false;
  BtnMenuProdutor.Enabled         := true;
  BtnMenuFechar.Enabled           := true;
  popularDistribuidor;
end;

procedure TFrmPrincipal.goFechar;
begin
  Close;
end;

procedure TFrmPrincipal.goHome;
begin
  PgPrincipal.ActivePageIndex   := 0;
  BtnMenuHome.Enabled           := false;
  BtnMenuNegociacao.Enabled     := true;
  BtnMenuProdutos.Enabled       := true;
  BtnMenuDistribuidor.Enabled   := true;
  BtnMenuProdutor.Enabled       := true;
  BtnMenuFechar.Enabled         := true;
end;

procedure TFrmPrincipal.goNegociacao;
begin
  PgPrincipal.ActivePageIndex   := 4;
  pgNegociacao.ActivePageIndex  := 0;
  lblHeadNegociacao.caption     := 'Negociação';
  BtnHeadNegociacao.caption     := 'Cadastrar';
  BtnMenuHome.Enabled           := true;
  BtnMenuNegociacao.Enabled     := false;
  BtnMenuProdutos.Enabled       := true;
  BtnMenuDistribuidor.Enabled   := true;
  BtnMenuProdutor.Enabled       := true;
  BtnMenuFechar.Enabled         := true;
  popularNegociacao;
end;

procedure TFrmPrincipal.goProdutor;
begin
  PgPrincipal.ActivePageIndex   := 1;
  PgProdutor.ActivePageIndex    := 0;
  lblHeadProdutor.Caption       := 'Produtor';
  BtnHeadProdutor.Caption       := 'Cadastrar';
  BtnMenuHome.Enabled           := true;
  BtnMenuNegociacao.Enabled     := true;
  BtnMenuProdutos.Enabled       := true;
  BtnMenuDistribuidor.Enabled   := true;
  BtnMenuProdutor.Enabled       := false;
  BtnMenuFechar.Enabled         := true;
  popularProdutor;
end;

procedure TFrmPrincipal.goProdutos;
begin
  PgPrincipal.ActivePageIndex   := 3;
  PgProdutos.ActivePageIndex    := 0;
  lblHeadProdutos.Caption       := 'Produto';
  BtnHeadProdutos.Caption       := 'Cadastrar';
  BtnMenuHome.Enabled           := true;
  BtnMenuNegociacao.Enabled     := true;
  BtnMenuProdutos.Enabled       := false;
  BtnMenuDistribuidor.Enabled   := true;
  BtnMenuProdutor.Enabled       := true;
  BtnMenuFechar.Enabled         := true;
  popularProdutos;
end;

procedure TFrmPrincipal.GridCadDistribuidorCellClick(Column: TColumn);
begin
  if GridCadDistribuidor.SelectedField.FieldName = 'editar' then
  begin
    editarDistribuidor;
  end
  else
  if GridCadDistribuidor.SelectedField.FieldName = 'excluir' then
  begin
    excluirDistribuidor;
  end;
end;

procedure TFrmPrincipal.GridCadDistribuidorDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt: string;
begin
  if MemDistribuidor.RecordCount > 0 then
  begin
    if Column.FieldName = 'editar' then
    begin
      GridCadDistribuidor.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Editar';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridCadDistribuidor.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridCadDistribuidor.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;

    if Column.FieldName = 'excluir' then
    begin
      GridCadDistribuidor.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Excluir';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridCadDistribuidor.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridCadDistribuidor.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.GridCadProdutorCellClick(Column: TColumn);
begin
  if GridCadProdutor.SelectedField.FieldName = 'editar' then
  begin
    editarProdutor;
  end
  else
  if GridCadProdutor.SelectedField.FieldName = 'excluir' then
  begin
    excluirProdutor;
  end;
end;

procedure TFrmPrincipal.GridCadProdutorDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt: string;
begin
  if MemProdutor.RecordCount > 0 then
  begin
    if Column.FieldName = 'editar' then
    begin
      GridCadProdutor.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Editar';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridCadProdutor.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridCadProdutor.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;

    if Column.FieldName = 'excluir' then
    begin
      GridCadProdutor.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Excluir';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridCadProdutor.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridCadProdutor.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.GridCadProdutosCellClick(Column: TColumn);
begin
  if GridCadProdutos.SelectedField.FieldName = 'editar' then
  begin
    editarProduto;
  end
  else
  if GridCadProdutos.SelectedField.FieldName = 'excluir' then
  begin
    excluirProduto;
  end;
end;

procedure TFrmPrincipal.GridCadProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt: string;
begin
  if MemProdutos.RecordCount > 0 then
  begin
    if Column.FieldName = 'editar' then
    begin
      GridCadProdutos.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Editar';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridCadProdutos.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridCadProdutos.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;

    if Column.FieldName = 'excluir' then
    begin
      GridCadProdutos.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Excluir';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridCadProdutos.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridCadProdutos.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.GridNegociacaoCellClick(Column: TColumn);
begin
  if GridNegociacao.SelectedField.FieldName = 'editar' then
  begin
    editarNegociacao;
  end
  else
  if GridNegociacao.SelectedField.FieldName = 'excluir' then
  begin
    excluirNegociacao;
  end;
end;

procedure TFrmPrincipal.GridNegociacaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt: string;
begin
  if MemNegociacao.RecordCount > 0 then
  begin
    if Column.FieldName = 'editar' then
    begin
      GridNegociacao.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Editar';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridNegociacao.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridNegociacao.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;

    if Column.FieldName = 'excluir' then
    begin
      GridNegociacao.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Excluir';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridNegociacao.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridNegociacao.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.GridNegociacaoProdutoCellClick(Column: TColumn);
begin
  if GridNegociacaoProduto.SelectedField.FieldName = 'excluir' then
  begin
    excluirNegociacaoProduto;
  end;
end;

procedure TFrmPrincipal.GridNegociacaoProdutoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt: string;
begin
  if MemNegociacaoItens.RecordCount > 0 then
  begin
  if Column.FieldName = 'excluir' then
    begin
      GridNegociacaoProduto.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Excluir';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridNegociacaoProduto.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridNegociacaoProduto.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.GridProdutorVinculacaoCellClick(Column: TColumn);
begin
  if GridProdutorVinculacao.SelectedField.FieldName = 'excluir' then
  begin
    excluirVinculacao;
  end;
end;

procedure TFrmPrincipal.GridProdutorVinculacaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
  BUTTON: Integer;
  R: TRect;
  SCapt: string;
begin
  if MemVinculacaoComercial.RecordCount > 0 then
  begin
  if Column.FieldName = 'excluir' then
    begin
      GridProdutorVinculacao.Canvas.FillRect(Rect);
      BUTTON := 0;
      R := Rect;
      SCapt := 'Excluir';
      InflateRect(R, -2, -2); // Diminue o tamanho do Botão
      DrawFrameControl(GridProdutorVinculacao.Canvas.Handle, R, BUTTON,
        BUTTON or BUTTON);
      with GridProdutorVinculacao.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Color := clBtnText;
        TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2,
          (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.inserirProduto(fk_Produto: Integer; Descricao: String;
  Valor_Un: Currency; Qtd: Double; Valor_Total: Currency);
var ControllerNegociacaoItens : TControllerNegociacaoItens;
begin

   if Valor_Total > getLimiteCredito then
  begin
    Showmessage('Limite de crédito indisponível para a operação. Limite disponível: ' + FloatToStr(getLimiteCredito));
    Exit;
  end;

   ControllerNegociacaoItens := TControllerNegociacaoItens.Create;
   try
    ControllerNegociacaoItens.ModelNegociacaoItens.enuTipo        := UEnumerador.tipoInclusao;
    ControllerNegociacaoItens.ModelNegociacaoItens.FK_NEGOCIACAO  := StrToInt(EdtNegociacaoID.Text);
    ControllerNegociacaoItens.ModelNegociacaoItens.FK_PRODUTO     := MemProdutosID.Value;
    ControllerNegociacaoItens.ModelNegociacaoItens.VALOR_UN       := MemProdutosPRECO_VENDA.Value;
    ControllerNegociacaoItens.ModelNegociacaoItens.QTD            := StrToInt(EdtNegociacaoProdutoQtd.Text);
    ControllerNegociacaoItens.ModelNegociacaoItens.VALOR_TOTAL    := StrToInt(EdtNegociacaoProdutoQtd.Text) * MemProdutosPRECO_VENDA.Value;
    ControllerNegociacaoItens.ModelNegociacaoItens.persistir;
    popularNegociacaoItens;
   finally
    FreeAndNil(ControllerNegociacaoItens);
   end;

end;

procedure TFrmPrincipal.navigate(rota: integer); // 0 - home, 1 - produtor, 2 - distribuidor, 3 - produtos, 4 - negociacao, 5 - fechar
begin

  ResetPages;

  case rota of
    0:
      goHome;
    1:
      goProdutor;
    2:
      goDistribuidor;
    3:
      goProdutos;
    4:
      goNegociacao;
    5:
      goFechar;
  end;
end;

procedure TFrmPrincipal.navigateDistribuidor;
begin
  if BtnHeadDistribuidor.Caption = 'Cadastrar' then
  begin
    PgDistribuidor.ActivePageIndex := 1;
    lblHeadDistribuidor.Caption    := 'Cadastro do distribuidor';
    BtnHeadDistribuidor.Caption    := 'Voltar';
    if EdtDistribuidorID.Text = '' then
    begin
      EdtDistribuidorID.Text         := '';
      EdtDistribuidorNome.Text       := '';
      EdtDistribuidorCNPJ.Text       := '';
    end;
  end
  else
  if BtnHeadDistribuidor.Caption = 'Voltar' then
  begin
    PgDistribuidor.ActivePageIndex := 0;
    lblHeadDistribuidor.Caption    := 'Distribuidor';
    BtnHeadDistribuidor.Caption    := 'Cadastrar';
    EdtDistribuidorID.Text         := '';
    EdtDistribuidorNome.Text       := '';
    EdtDistribuidorCNPJ.Text       := '';
    popularDistribuidor;
  end;
end;

procedure TFrmPrincipal.navigateNegociacao;
begin
  if BtnHeadNegociacao.Caption = 'Cadastrar' then
  begin
    PgNegociacao.ActivePageIndex := 1;
    lblHeadNegociacao.Caption    := 'Cadastro de negociação';
    BtnHeadNegociacao.Caption    := 'Voltar';
    EdtNegociacaoProdutoQtd.Text := '1';
    popularProdutos;
    popularProdutor;
    popularDistribuidor;
    selecionaProduto;
    if EdtNegociacaoId.Text = '' then
    begin
      EdtNegociacaoValor.Text := '0,00';
      CBNegociacaoProdutor.Enabled := true;
      CbNegociacaoDistribuidor.Enabled := true;
      CbNegociacaoStatus.ItemIndex := 0;
      CbNegociacaoStatus.Enabled := false;
    end
    else
      popularNegociacaoItens;
  end
  else
  if BtnHeadNegociacao.Caption = 'Voltar' then
  begin
    PgNegociacao.ActivePageIndex  := 0;
    lblHeadNegociacao.Caption     := 'Negociaçao';
    BtnHeadNegociacao.Caption     := 'Cadastrar';
    EdtNegociacaoID.Text          := '';
    MemNegociacao.EmptyDataSet;
    MemNegociacaoItens.EmptyDataSet;
    popularNegociacao;
  end;
end;

procedure TFrmPrincipal.popularDistribuidor;
var
  ControllerDistribuidor: TControllerDistribuidor;
  qDistribuidor: TFDQuery;
begin
  qDistribuidor := TFDQuery.Create(nil);
  ControllerDistribuidor := TControllerDistribuidor.Create;
  try
    qDistribuidor := ControllerDistribuidor.selecionar;
    try
      qDistribuidor.FetchAll;
      MemDistribuidor.close;
      MemDistribuidor.Data := qDistribuidor.Data;
      if PgPrincipal.ActivePageIndex = 1 then
      begin
          with cbProdutorVinculacaoDistribuidor do
          begin
            items.Clear;
            MemDistribuidor.First;
            while not MemDistribuidor.Eof do
            begin
              items.add(MemDistribuidor.fieldbyname('nome').Text);
              MemDistribuidor.Next;
            end;
            ItemIndex := 0;
            if cbProdutorVinculacaoDistribuidor.Text <> '' then
              MemDistribuidor.Locate('NOME', cbProdutorVinculacaoDistribuidor.Text, []);
          end;
      end
      else
      if PgPrincipal.ActivePageIndex = 4 then
      begin
       if EdtNegociacaoId.Text = '' then
        begin
          with CbNegociacaoDistribuidor do
          begin
            items.Clear;
            MemDistribuidor.First;
            while not MemDistribuidor.Eof do
            begin
              items.add(MemDistribuidor.fieldbyname('nome').Text);
              MemDistribuidor.Next;
            end;
            if CbNegociacaoDistribuidor.Text <> '' then
              MemDistribuidor.Locate('NOME', cbProdutorVinculacaoDistribuidor.Text, []);
          end;
        end
        else
        begin
           MemDistribuidor.Locate('NOME', CbNegociacaoDistribuidor.Text, []);
        end;
      end;
    finally
      qDistribuidor.close;
      FreeAndNil(qDistribuidor);
    end;
  finally
    FreeAndNil(ControllerDistribuidor);
  end;
end;

procedure TFrmPrincipal.popularNegociacao;
var
  ControllerNegociacao: TControllerNegociacao;
  qNegociacao: TFDQuery;
begin
  qNegociacao := TFDQuery.Create(nil);
  ControllerNegociacao := TControllerNegociacao.Create;
  try
    qNegociacao := ControllerNegociacao.selecionar;
    try
      qNegociacao.FetchAll;
      MemNegociacao.close;
      MemNegociacao.Data := qNegociacao.Data;
    finally
      qNegociacao.close;
      FreeAndNil(qNegociacao);
    end;
  finally
    FreeAndNil(ControllerNegociacao);
  end;
end;

procedure TFrmPrincipal.popularNegociacaoItens;
var
  ControllerNegociacaoItens: TControllerNegociacaoItens;
  qNegociacaoItens: TFDQuery;
begin
  qNegociacaoItens := TFDQuery.Create(nil);
  ControllerNegociacaoItens := TControllerNegociacaoItens.Create;
  try
    ControllerNegociacaoItens.ModelNegociacaoItens.FK_NEGOCIACAO := StrToInt(EdtNegociacaoID.Text);
    qNegociacaoItens := ControllerNegociacaoItens.selecionar;
    try
      qNegociacaoItens.FetchAll;
      MemNegociacaoItens.close;
      MemNegociacaoItens.Data := qNegociacaoItens.Data;
      calculaNegociacaoTotal;
    finally
      qNegociacaoItens.close;
      FreeAndNil(qNegociacaoItens);
    end;
  finally
    FreeAndNil(ControllerNegociacaoItens);
  end;
end;

procedure TFrmPrincipal.popularProdutor;
var
  ControllerProdutor: TControllerProdutor;
  qProdutor: TFDQuery;
begin
  qProdutor := TFDQuery.Create(nil);
  ControllerProdutor := TControllerProdutor.Create;
  try
    qProdutor := ControllerProdutor.selecionar;
    try
      qProdutor.FetchAll;
      MemProdutor.close;
      MemProdutor.Data := qProdutor.Data;
      if PgPrincipal.ActivePageIndex = 4 then
      begin
        if EdtNegociacaoId.Text = '' then
        begin
          with CBNegociacaoProdutor do
          begin
            items.Clear;
            MemProdutor.First;
            while not MemProdutor.Eof do
            begin
              items.add(MemProdutor.fieldbyname('nome').Text);
              MemProdutor.Next;
            end;
            if CBNegociacaoProdutor.Text <> '' then
              MemProdutor.Locate('NOME', CBNegociacaoProdutor.Text, []);
          end;
        end
        else
        begin
          MemProdutor.Locate('NOME', CBNegociacaoProdutor.Text, []);
        end;
      end;
    finally
      qProdutor.close;
      FreeAndNil(qProdutor);
    end;
  finally
    FreeAndNil(ControllerProdutoR);
  end;
end;


procedure TFrmPrincipal.popularProdutorVinculacaoComercial;
var
  ControllerVinculacaoComercial: TControllerVinculacaoComercial;
  qVinculacaoComercial: TFDQuery;
begin
  qVinculacaoComercial := TFDQuery.Create(nil);
  ControllerVinculacaoComercial := TControllerVinculacaoComercial.Create;
  try
    ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_PRODUTOR := StrtoInt(EdtProdutorID.Text);
    qVinculacaoComercial := ControllerVinculacaoComercial.selecionar;
    try
      qVinculacaoComercial.FetchAll;
      MemVinculacaoComercial.close;
      MemVinculacaoComercial.Data := qVinculacaoComercial.Data
    finally
      qVinculacaoComercial.close;
      FreeAndNil(qVinculacaoComercial);
    end;
  finally
    FreeAndNil(ControllerVinculacaoComercial);
  end;
end;

procedure TFrmPrincipal.popularProdutos;
var
  ControllerProdutos: TControllerProdutos;
  qProdutos: TFDQuery;
begin
  qProdutos := TFDQuery.Create(nil);
  ControllerProdutos := TControllerProdutos.Create;
  try
    qProdutos := ControllerProdutos.selecionar;
    try
      qProdutos.FetchAll;
      MemProdutos.close;
      MemProdutos.Data := qProdutos.Data;
      if PgPrincipal.ActivePageIndex = 4 then
      begin
        with CBNegociacaoProduto do
        begin
          items.Clear;
          MemProdutos.First;
          while not MemProdutos.Eof do
          begin
            items.add(MemProdutos.fieldbyname('DESCRICAO').Text);
            MemProdutos.Next;
          end;
          ItemIndex := 0;
          if CBNegociacaoProduto.Text <> '' then
            MemProdutos.Locate('DESCRICAO', CBNegociacaoProduto.Text, []);
        end;
      end;
    finally
      qProdutos.close;
      FreeAndNil(qProdutos);
    end;
  finally
    FreeAndNil(ControllerProdutos);
  end;
end;

procedure TFrmPrincipal.ResetPages;
begin
  if PgProdutor.ActivePageIndex = 1 then
    navigateProdutor;
  if PgDistribuidor.ActivePageIndex = 1 then
    navigateDistribuidor;
  if PgProdutos.ActivePageIndex = 1 then
    navigateProdutos;
  if pgNegociacao.ActivePageIndex = 1 then
    navigateNegociacao;
end;

function TFrmPrincipal.SalvarDistribuidor: Boolean;
var
  ControllerDistribuidor: TControllerDistribuidor;
  edicao: Boolean;
begin
  Result := True;
  edicao := False;
  if validarDistribuidor then
  begin
    ControllerDistribuidor := TControllerDistribuidor.Create;
    try
      if EdtDistribuidorID.Text = '' then
        ControllerDistribuidor.ModelDistribuidor.enuTipo := UEnumerador.tipoInclusao
      else
      begin
        ControllerDistribuidor.ModelDistribuidor.enuTipo := UEnumerador.tipoAlteracao;
        ControllerDistribuidor.ModelDistribuidor.ID      := strtoint(EdtDistribuidorID.Text);
        edicao := True;
      end;

      ControllerDistribuidor.ModelDistribuidor.NOME      := EdtDistribuidorNome.Text;
      ControllerDistribuidor.ModelDistribuidor.CNPJ      := EdtDistribuidorCNPJ.Text;

      if not edicao then
      if not ControllerDistribuidor.ModelDistribuidor.validar then
      begin
        ShowMessage('Distribuidor já cadastrado!');
        Result := false;
        exit;
      end;

      if ControllerDistribuidor.ModelDistribuidor.persistir then
      begin
        if edicao then
          ShowMessage('Distribuidor alterado com sucesso!')
        else
          ShowMessage('Distribuidor cadastrado com sucesso!');
      end;

    finally
      FreeAndNil(ControllerDistribuidor);
    end;
  end
  else
    Result := False;
end;

function TFrmPrincipal.SalvarNegociacao: Boolean;
var
  ControllerNegociacao: TControllerNegociacao;
  edicao: Boolean;
begin
  Result := True;
  edicao := False;
  if validarNegociacao then
  begin
    ControllerNegociacao := TControllerNegociacao.Create;
    try
      if EdtNegociacaoID.Text = '' then
        ControllerNegociacao.ModelNegociacao.enuTipo := UEnumerador.tipoInclusao
      else
      begin
        ControllerNegociacao.ModelNegociacao.enuTipo := UEnumerador.tipoAlteracao;
        ControllerNegociacao.ModelNegociacao.ID      := strtoint(EdtNegociacaoID.Text);
        edicao := True;
      end;

      ControllerNegociacao.ModelNegociacao.FK_VINCULACAO_COMERCIAL   := getVinculacao;
      ControllerNegociacao.ModelNegociacao.Valor                     := StrToFloat(EdtNegociacaoValor.Text);
      ControllerNegociacao.ModelNegociacao.STATUS                    := CbNegociacaoStatus.Text;

      if not edicao then
      if not ControllerNegociacao.ModelNegociacao.validar then
      begin
        ShowMessage('Negociação já cadastrada!');
        Result := false;
        exit;
      end;

      if ControllerNegociacao.ModelNegociacao.persistir then
      begin
        if edicao then
          ShowMessage('Negociação alterada com sucesso!')
        else
          begin
            ShowMessage('Negociação cadastrada com sucesso!');
            EdtNegociacaoID.Text := IntToStr(ControllerNegociacao.ModelNegociacao.buscarId);
          end;
      end;

    finally
      FreeAndNil(ControllerNegociacao);
    end;
  end
  else
    Result := False;
end;

procedure TFrmPrincipal.navigateProdutor;
begin
  if BtnHeadProdutor.Caption = 'Cadastrar' then
  begin
    PgProdutor.ActivePageIndex := 1;
    lblHeadProdutor.Caption    := 'Cadastro do produtor';
    BtnHeadProdutor.Caption    := 'Voltar';
    popularDistribuidor;
    if EdtProdutorID.Text = '' then
    begin
      EdtProdutorNome.Text       := '';
      EdtProdutorCPFCNPJ.Text    := '';
    end
    else
      popularProdutorVinculacaoComercial;
  end
  else if BtnHeadProdutor.Caption = 'Voltar' then
  begin
    PgProdutor.ActivePageIndex := 0;
    lblHeadProdutor.Caption    := 'Produtor';
    BtnHeadProdutor.Caption    := 'Cadastrar';
    EdtProdutorID.Text         := '';
    EdtProdutorNome.Text       := '';
    EdtProdutorCPFCNPJ.Text    := '';
    if EdtProdutorID.Text <> '' then
    MemVinculacaoComercial.EmptyDataSet;
    popularProdutor;
  end;
end;

procedure TFrmPrincipal.navigateProdutos;
begin
if BtnHeadProdutos.Caption = 'Cadastrar' then
  begin
    PgProdutos.ActivePageIndex := 1;
    lblHeadProdutos.Caption    := 'Cadastro do produto';
    BtnHeadProdutos.Caption    := 'Voltar';
    if EdtProdutosID.Text = '' then
    begin
      EdtProdutosDESCRICAO.Text   := '';
      EdtProdutosPRECO.Text       := '0,00';
    end;
  end
  else
  if BtnHeadProdutos.Caption = 'Voltar' then
  begin
    PgProdutos.ActivePageIndex  := 0;
    lblHeadProdutos.Caption     := 'Produtos';
    BtnHeadProdutos.Caption     := 'Cadastrar';
    EdtProdutosID.Text          := '';
      EdtProdutosDESCRICAO.Text := '';
      EdtProdutosPRECO.Text     := '0,00';
    popularProdutos;
  end;
end;

function TFrmPrincipal.salvarProduto: Boolean;
var
  ControllerProdutos: TControllerProdutos;
  edicao: Boolean;
begin
  Result := True;
  edicao := False;
  if validarProduto then
  begin
    ControllerProdutos := TControllerProdutos.Create;
    try
      if EdtProdutosID.Text = '' then
        ControllerProdutos.ModelProdutos.enuTipo := UEnumerador.tipoInclusao
      else
      begin
        ControllerProdutos.ModelProdutos.enuTipo := UEnumerador.tipoAlteracao;
        ControllerProdutos.ModelProdutos.ID      := strtoint(EdtProdutosID.Text);
        edicao := True;
      end;

      ControllerProdutos.ModelProdutos.DESCRICAO    := EdtProdutosDESCRICAO.Text;
      ControllerProdutos.ModelProdutos.PRECO_VENDA  := StrToFloat(EdtProdutosPRECO.Text);

      if not edicao then
      if not ControllerProdutos.ModelProdutos.validar then
      begin
        ShowMessage('Produto já cadastrado!');
        Result := false;
        exit;
      end;

      if ControllerProdutos.ModelProdutos.persistir then
      begin
        if edicao then
          ShowMessage('Produto alterado com sucesso!')
        else
          begin
            ShowMessage('Produto cadastrado com sucesso!');
            EdtProdutorID.Text := IntToStr(ControllerProdutos.ModelProdutos.buscarId);
          end;
      end;

    finally
      FreeAndNil(ControllerProdutos);
    end;
  end
  else
    Result := False;
end;

function TFrmPrincipal.SalvarProdutor: Boolean;
var
  ControllerProdutor: TControllerProdutor;
  edicao: Boolean;
begin
  Result := True;
  edicao := False;
  if validarProdutor then
  begin
    ControllerProdutor := TControllerProdutor.Create;
    try
      if EdtProdutorID.Text = '' then
        ControllerProdutor.ModelProdutor.enuTipo := UEnumerador.tipoInclusao
      else
      begin
        ControllerProdutor.ModelProdutor.enuTipo := UEnumerador.tipoAlteracao;
        ControllerProdutor.ModelProdutor.ID      := strtoint(EdtProdutorID.Text);
        edicao := True;
      end;

      ControllerProdutor.ModelProdutor.NOME      := EdtProdutorNome.Text;
      ControllerProdutor.ModelProdutor.CPF_CNPJ  := EdtProdutorCPFCNPJ.Text;

      if not edicao then
      if not ControllerProdutor.ModelProdutor.validar then
      begin
        ShowMessage('Produtor já cadastrado!');
        Result := false;
        exit;
      end;

      if ControllerProdutor.ModelProdutor.persistir then
      begin
        if edicao then
          ShowMessage('Produtor alterado com sucesso!')
        else
          begin
            ShowMessage('Produtor cadastrado com sucesso!');
            EdtProdutorID.Text := IntToStr(ControllerProdutor.ModelProdutor.buscarId);
          end;
      end;

    finally
      FreeAndNil(ControllerProdutor);
    end;
  end
  else
    Result := False;
end;

function TFrmPrincipal.salvarProdutorVinculacao: Boolean;
var
  ControllerVinculacaoComercial: TControllerVinculacaoComercial;
  edicao: Boolean;
begin
  Result := true;
    if SalvarProdutor then
    begin

      if not validarProdutorVinculacao then
      begin
        Result := false;
        exit;
      end;

      ControllerVinculacaoComercial := TControllerVinculacaoComercial.Create;

      try
        ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_PRODUTOR     := StrToInt(EdtProdutorID.Text);
        ControllerVinculacaoComercial.ModelVinculacaoComercial.FK_DISTRIBUIDOR := MemDistribuidorID.value;
        ControllerVinculacaoComercial.ModelVinculacaoComercial.LIMITE          := StrToFloat(EdtProdutorVinculacaoLimite.text);

        if ControllerVinculacaoComercial.ModelVinculacaoComercial.buscarId = 0 then
        ControllerVinculacaoComercial.ModelVinculacaoComercial.enuTipo := UEnumerador.tipoInclusao
        else
        begin
          ControllerVinculacaoComercial.ModelVinculacaoComercial.enuTipo := UEnumerador.tipoAlteracao;
          ControllerVinculacaoComercial.ModelVinculacaoComercial.ID      := MemVinculacaoComercialID.Value;
          edicao := True;
        end;

        if ControllerVinculacaoComercial.ModelVinculacaoComercial.persistir then
        begin
          if edicao then
            ShowMessage('Vinculação alterada com sucesso!')
          else
            begin
              ShowMessage('Vinculação cadastrada com sucesso!');
            end;
        end;
          popularProdutorVinculacaoComercial;
      finally
        FreeAndNil(ControllerVinculacaoComercial);
      end;

    end
    else
      result := false;
end;

procedure TFrmPrincipal.selecionaProduto;
var total: double;
begin
    MemProdutos.Locate('DESCRICAO', CbNegociacaoProduto.Text, []);
    total := StrToFloat(EdtNegociacaoProdutoQtd.Text) * MemProdutos.fieldbyname('PRECO_VENDA').value;
    EdtNegociacaoProdutoTotais.text := EdtNegociacaoProdutoQtd.Text +
                                      ' x R$: ' + MemProdutos.fieldbyname('PRECO_VENDA').Text +
                                      ' = R$: ' + FormatFloat('#,##0.00',total);
end;

function TFrmPrincipal.validarDistribuidor: Boolean;
begin
  Result := True;

  if EdtDistribuidorNome.Text = '' then
  begin
    Showmessage('Digite o nome do Distribuidor');
    EdtDistribuidorNome.SetFocus;
    Result := False;
    Exit;
  end;

  if EdtDistribuidorCNPJ.Text = '' then
  begin
    Showmessage('Digite o CNPJ do Distribuidor');
    EdtDistribuidorCNPJ.SetFocus;
    Result := False;
    Exit;
  end;

end;

function TFrmPrincipal.validarNegociacao: Boolean;
begin
  Result := True;

  if CBNegociacaoProdutor.Text = '' then
  begin
    Showmessage('Selecione o Produtor');
    CBNegociacaoProdutor.SetFocus;
    Result := False;
    Exit;
  end;

  if CbNegociacaoDistribuidor.Text = '' then
  begin
    Showmessage('Selecione o Produtor');
    CbNegociacaoDistribuidor.SetFocus;
    Result := False;
    Exit;
  end;

  if getVinculacao = 0 then
  begin
    Showmessage('Não existe vinculação comercial cadastrada entre o Produtor e o Distribuidor selecionados');
    CbNegociacaoDistribuidor.SetFocus;
    Result := False;
    Exit;
  end;

end;

function TFrmPrincipal.validarProduto: Boolean;
begin
  Result := True;

  if EdtProdutosDESCRICAO.Text = '' then
  begin
    Showmessage('Digite a descrição do Produto');
    EdtProdutosDESCRICAO.SetFocus;
    Result := False;
    Exit;
  end;

  if EdtProdutosPRECO.Text = '' then
  begin
    Showmessage('Digite o valor do Produto');
    EdtProdutosPRECO.SetFocus;
    Result := False;
    Exit;
  end;
end;

function TFrmPrincipal.validarProdutor: Boolean;
begin
  Result := True;

  if EdtProdutorNome.Text = '' then
  begin
    Showmessage('Digite o nome do Produtor');
    EdtProdutorNome.SetFocus;
    Result := False;
    Exit;
  end;

  if EdtProdutorCPFCNPJ.Text = '' then
  begin
    Showmessage('Digite o CPF/CNPJ do Produtor');
    EdtProdutorCPFCNPJ.SetFocus;
    Result := False;
    Exit;
  end;

end;

function TFrmPrincipal.validarProdutorVinculacao: Boolean;
begin
  Result := True;

  if cbProdutorVinculacaoDistribuidor.Text = '' then
  begin
    Showmessage('Distribuidor não selecionado.');
    cbProdutorVinculacaoDistribuidor.SetFocus;
    Result := False;
    Exit;
  end;

  if EdtProdutorVinculacaoLimite.Text = '' then
  begin
    Showmessage('Defina um limite de crédito para o produtor.');
    EdtProdutorVinculacaoLimite.SetFocus;
    Result := False;
    Exit;
  end;

end;

end.
