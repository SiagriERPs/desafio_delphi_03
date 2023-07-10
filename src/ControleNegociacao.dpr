program ControleNegociacao;

uses
  Vcl.Forms,
  Distribuidor in 'Model\Distribuidor.pas',
  UDM in 'Conexao\UDM.pas' {DM: TDataModule},
  DistribuidorController in 'Controller\DistribuidorController.pas',
  DistribuidorDAO in 'DAO\DistribuidorDAO.pas',
  CadastroDistribuidor in 'View\CadastroDistribuidor.pas' {FCadastroDistribuidor},
  Funcoes in 'Utils\Funcoes.pas',
  Produtor in 'Model\Produtor.pas',
  ProdutorDAO in 'DAO\ProdutorDAO.pas',
  ProdutorController in 'Controller\ProdutorController.pas',
  CadastroProdutor in 'View\CadastroProdutor.pas' {FCadastroProdutor},
  Produto in 'Model\Produto.pas',
  ProdutoDAO in 'DAO\ProdutoDAO.pas',
  ProdutoController in 'Controller\ProdutoController.pas',
  CadastroProduto in 'View\CadastroProduto.pas' {FCadastroProduto},
  Status in 'Model\Status.pas',
  StatusDAO in 'DAO\StatusDAO.pas',
  StatusController in 'Controller\StatusController.pas',
  LimiteCredito in 'Model\LimiteCredito.pas',
  LimiteCreditoDAO in 'DAO\LimiteCreditoDAO.pas',
  LimiteCreditoController in 'Controller\LimiteCreditoController.pas',
  CadastroLimiteCredito in 'View\CadastroLimiteCredito.pas' {FCadastroLimiteCredito},
  Principal in 'Principal\Principal.pas' {FPrincipal},
  Negociacao in 'Model\Negociacao.pas',
  NegociacaoDAO in 'DAO\NegociacaoDAO.pas',
  NegociacaoController in 'Controller\NegociacaoController.pas',
  CadastroNegociacao in 'View\CadastroNegociacao.pas' {FCadastroNegociacao},
  NegociacaoItens in 'Model\NegociacaoItens.pas',
  NegociacaoItensDAO in 'DAO\NegociacaoItensDAO.pas',
  NegociacaoItensController in 'Controller\NegociacaoItensController.pas',
  ManutencaoNegociacao in 'View\ManutencaoNegociacao.pas' {FManutencaoNegociacao},
  ConsultaNegociacao in 'View\ConsultaNegociacao.pas' {FConsultaNegociacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFCadastroNegociacao, FCadastroNegociacao);
  Application.CreateForm(TFManutencaoNegociacao, FManutencaoNegociacao);
  Application.CreateForm(TFConsultaNegociacao, FConsultaNegociacao);
  Application.Run;
end.
