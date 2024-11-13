program DesafioAliare;

uses
  Vcl.Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {FrmPrincipal},
  uDistribuidorController in 'controller\uDistribuidorController.pas',
  uLimiteCreditoController in 'controller\uLimiteCreditoController.pas',
  uNegociacaoController in 'controller\uNegociacaoController.pas',
  uNegociacaoItemController in 'controller\uNegociacaoItemController.pas',
  uProdutoController in 'controller\uProdutoController.pas',
  uProdutorController in 'controller\uProdutorController.pas',
  uSistemaController in 'controller\uSistemaController.pas',
  uStatusController in 'controller\uStatusController.pas',
  uDistribuidorDAO in 'dao\uDistribuidorDAO.pas',
  uLimiteCreditoDAO in 'dao\uLimiteCreditoDAO.pas',
  uNegociacaoDAO in 'dao\uNegociacaoDAO.pas',
  uNegociacaoItemDAO in 'dao\uNegociacaoItemDAO.pas',
  uProdutoDAO in 'dao\uProdutoDAO.pas',
  uProdutorDAO in 'dao\uProdutorDAO.pas',
  uStatusDAO in 'dao\uStatusDAO.pas',
  uDataModule in 'datamodule\uDataModule.pas' {DM: TDataModule},
  uDistribuidorModel in 'model\uDistribuidorModel.pas',
  uEnumerado in 'model\uEnumerado.pas',
  uLimiteCreditoModel in 'model\uLimiteCreditoModel.pas',
  uNegociacaoItemModel in 'model\uNegociacaoItemModel.pas',
  uNegociacaoModel in 'model\uNegociacaoModel.pas',
  uProdutoModel in 'model\uProdutoModel.pas',
  uProdutorModel in 'model\uProdutorModel.pas',
  uStatusModel in 'model\uStatusModel.pas',
  uConexao in 'services\uConexao.pas',
  uBiblioteca in 'utils\uBiblioteca.pas',
  uFrmBasico in 'view\uFrmBasico.pas' {FrmBasico},
  uFrmCadBasico in 'view\uFrmCadBasico.pas' {FrmCadBasico},
  uFrmPesquisaBasico in 'view\uFrmPesquisaBasico.pas' {FrmPesquisaBasico},
  uFrmCadDistribuidor in 'view\uFrmCadDistribuidor.pas' {FrmCadDistribuidor},
  uFrmPesquisaDistribuidor in 'view\uFrmPesquisaDistribuidor.pas' {FrmPesquisaDistribuidor},
  uFrmCadProduto in 'view\uFrmCadProduto.pas' {FrmCadProduto},
  uFrmPesquisaProduto in 'view\uFrmPesquisaProduto.pas' {FrmPesquisaProduto},
  uFrmCadProdutor in 'view\uFrmCadProdutor.pas' {FrmCadProdutor},
  uFrmPesquisaProdutor in 'view\uFrmPesquisaProdutor.pas' {FrmPesquisaProdutor},
  uFrmLimiteCredito in 'view\uFrmLimiteCredito.pas' {FrmLimiteCredito},
  uFrmCadNegociacao in 'view\uFrmCadNegociacao.pas' {FrmCadNegociacao},
  uFrmPesquisaNegociacao in 'view\uFrmPesquisaNegociacao.pas' {FrmPesquisaNegociacao},
  uFrmManutencaoNegociacao in 'view\uFrmManutencaoNegociacao.pas' {FrmManutencaoNegociacao},
  uFrmConsultaNegociacao in 'view\uFrmConsultaNegociacao.pas' {FrmConsultaNegociacao},
  uFrmRelatorioNegociacao in 'view\uFrmRelatorioNegociacao.pas' {FrmRelatorioNegociacao},
  uFrmPesquisaProdutoNegociacao in 'view\uFrmPesquisaProdutoNegociacao.pas' {FrmPesquisaProdutoNegociacao};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmPesquisaProdutoNegociacao, FrmPesquisaProdutoNegociacao);
  Application.Run;
end.
