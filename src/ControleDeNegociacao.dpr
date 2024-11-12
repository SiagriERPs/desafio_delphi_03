program ControleDeNegociacao;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Principal in 'view\Principal.pas' {FPrincipal},
  CadastroProdutor in 'view\CadastroProdutor.pas' {FCadastroProdutor},
  CadastroNovoDistribuidor in 'view\CadastroNovoDistribuidor.pas' {FCadastroNovoDistribuidor},
  uDistribuidor in 'model\uDistribuidor.pas',
  DistribuidorDAO in 'DAO\DistribuidorDAO.pas',
  DistribuidorController in 'controller\DistribuidorController.pas',
  CadastroDistribuidor in 'view\CadastroDistribuidor.pas' {FCadastroDistribuidor},
  uDmConexao in 'DAO\uDmConexao.pas' {DMConexao: TDataModule},
  uProdutor in 'model\uProdutor.pas',
  ProdutorDAO in 'DAO\ProdutorDAO.pas',
  ProdutorController in 'controller\ProdutorController.pas',
  CadastroNovoProdutor in 'view\CadastroNovoProdutor.pas' {FCadastroNovoProdutor},
  CadastroNovoProduto in 'view\CadastroNovoProduto.pas' {FCadastroNovoProduto},
  uProduto in 'model\uProduto.pas',
  ProdutoDAO in 'DAO\ProdutoDAO.pas',
  ProdutoController in 'controller\ProdutoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFCadastroProdutor, FCadastroProdutor);
  Application.CreateForm(TFCadastroNovoDistribuidor, FCadastroNovoDistribuidor);
  Application.CreateForm(TFCadastroDistribuidor, FCadastroDistribuidor);
  Application.CreateForm(TFCadastroNovoProdutor, FCadastroNovoProdutor);
  Application.CreateForm(TFCadastroNovoProduto, FCadastroNovoProduto);
  Application.Run;
end.
