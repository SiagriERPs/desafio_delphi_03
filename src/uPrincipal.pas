{******************************************************************************
 * Controle de Negociação 2.0
 * Novidades da versão:
 * - Forms passaram a ser dinâmicos
 * - Variáveis locais com o nome padronizado iniciando pela letra "l"
 * - Parâmetros com o nome padronizado iniciando pela letra "p"
 * - Variáveis globais mantidas na seção private iniciando pela letra "F"
 * - Utilização de propriedades e conceito de encapsulamento
 * - Reutilização de código
 * - Nome das rotinas usando verbo no infinitivo
 * - Nome das rotinas de forma clara com obojetivo de dispensar comentários
 * - Substituição de operações globais por rotinas
 * - Acrescentado imagem aos botões
 * - Criado/melhorado rotinas de validação dos dados
 * - Adicionado a exportação para Excel os dados das negociações
 ******************************************************************************}
unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Produtor1: TMenuItem;
    Cadastro1: TMenuItem;
    Alterao1: TMenuItem;
    Distribuidor1: TMenuItem;
    Cadastro2: TMenuItem;
    Alterao2: TMenuItem;
    Produto1: TMenuItem;
    Produto2: TMenuItem;
    Alterao3: TMenuItem;
    Negociao1: TMenuItem;
    Negociao2: TMenuItem;
    Alterao5: TMenuItem;
    Image: TImage;
    ImageList: TImageList;
    Sair1: TMenuItem;
    procedure Cadastro1Click(Sender: TObject);
    procedure Alterao1Click(Sender: TObject);
    procedure Cadastro2Click(Sender: TObject);
    procedure Alterao2Click(Sender: TObject);
    procedure Produto2Click(Sender: TObject);
    procedure Alterao3Click(Sender: TObject);
    procedure Negociao2Click(Sender: TObject);
    procedure Alterao5Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uProdutorCadastro, uProdutorAltera, uNegociacaoAlteraConsulta,
  uDistribuidorCadastro, uDistribuidorAltera, uNegociacaoCadatro,
  uProdutoCadastro, uProdutoAltera, uDM;

procedure TfrmPrincipal.Alterao1Click(Sender: TObject);
var
  lfrmProdutorAltera: TfrmProdutorAltera;
begin
  lfrmProdutorAltera := TfrmProdutorAltera.Create(Application);

  try
    lfrmProdutorAltera.ShowModal;
  finally
    FreeAndNil(lfrmProdutorAltera);
  end;
end;

procedure TfrmPrincipal.Alterao2Click(Sender: TObject);
var
  lfrmDistribuidorAltera: TfrmDistribuidorAltera;
begin
  lfrmDistribuidorAltera := TfrmDistribuidorAltera.Create(Application);

  try
    lfrmDistribuidorAltera.ShowModal;
  finally
    FreeAndNil(lfrmDistribuidorAltera);
  end;
end;

procedure TfrmPrincipal.Alterao3Click(Sender: TObject);
var
  lfrmProdutoAltera: TfrmProdutoAltera;
begin
  lfrmProdutoAltera := TfrmProdutoAltera.Create(Application);

  try
    lfrmProdutoAltera.ShowModal;
  finally
    FreeAndNil(lfrmProdutoAltera);
  end;
end;

procedure TfrmPrincipal.Alterao5Click(Sender: TObject);
var
  lfrmNegociacaoAlteraConsulta: TfrmNegociacaoAlteraConsulta;
begin
  lfrmNegociacaoAlteraConsulta := TfrmNegociacaoAlteraConsulta.Create(Application);

  try
    lfrmNegociacaoAlteraConsulta.ShowModal;
  finally
    FreeAndNil(lfrmNegociacaoAlteraConsulta);
  end;
end;

procedure TfrmPrincipal.Cadastro1Click(Sender: TObject);
var
  lfrmProdutorCadastro: TfrmProdutorCadastro;
begin
  lfrmProdutorCadastro := TfrmProdutorCadastro.Create(Application);

  try
    lfrmProdutorCadastro.Codigo := 0;
    lfrmProdutorCadastro.ShowModal;
  finally
    FreeAndNil(lfrmProdutorCadastro);
  end;
end;

procedure TfrmPrincipal.Cadastro2Click(Sender: TObject);
var
  lfrmDistribuidorCadastro: TfrmDistribuidorCadastro;
begin
  lfrmDistribuidorCadastro := TfrmDistribuidorCadastro.Create(Application);

  try
    lfrmDistribuidorCadastro.Codigo := 0;
    lfrmDistribuidorCadastro.ShowModal;
  finally
    FreeAndNil(lfrmDistribuidorCadastro);
  end;
end;

procedure TfrmPrincipal.Negociao2Click(Sender: TObject);
var
  lfrmNegociacaoCadastro: TfrmNegociacaoCadastro;
begin
  lfrmNegociacaoCadastro := TfrmNegociacaoCadastro.Create(Application);

  try
    lfrmNegociacaoCadastro.CodigoNegociacao := 0;
    lfrmNegociacaoCadastro.ShowModal;
  finally
    FreeAndNil(lfrmNegociacaoCadastro);
  end;
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
var
  lfrmProdutoCadastro: TfrmProdutoCadastro;
begin
  lfrmProdutoCadastro := TfrmProdutoCadastro.Create(Application);

  try
    lfrmProdutoCadastro.Codigo := 0;
    lfrmProdutoCadastro.ShowModal;
  finally
    FreeAndNil(lfrmProdutoCadastro);
  end;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
