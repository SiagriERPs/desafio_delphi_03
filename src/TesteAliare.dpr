program TesteAliare;

uses
  Vcl.Forms,
  UViewPrincipal in 'View\UViewPrincipal.pas' {FrmPrincipal},
  UDAOConexao in 'DAO\UDAOConexao.pas',
  UControllerConexao in 'Controller\UControllerConexao.pas',
  UControllerProdutor in 'Controller\UControllerProdutor.pas',
  UModelProdutor in 'Model\UModelProdutor.pas',
  UEnumerador in 'Model\UEnumerador.pas',
  UDAOProdutor in 'DAO\UDAOProdutor.pas',
  UModelCPFCNPJ in 'Model\UModelCPFCNPJ.pas',
  UControllerCPFCNPJ in 'Controller\UControllerCPFCNPJ.pas',
  UDAODistribuidor in 'DAO\UDAODistribuidor.pas',
  UModelDistribuidor in 'Model\UModelDistribuidor.pas',
  UControllerDistribuidor in 'Controller\UControllerDistribuidor.pas',
  UDAOVinculacaoComercial in 'DAO\UDAOVinculacaoComercial.pas',
  UModelVinculacaoComercial in 'Model\UModelVinculacaoComercial.pas',
  UControllerVinculacaoComercial in 'Controller\UControllerVinculacaoComercial.pas',
  UControllerProdutos in 'Controller\UControllerProdutos.pas',
  UModelProdutos in 'Model\UModelProdutos.pas',
  UDAOProdutos in 'DAO\UDAOProdutos.pas',
  UDAONegociacao in 'DAO\UDAONegociacao.pas',
  UModelNegociacao in 'Model\UModelNegociacao.pas',
  UControllerNegociacao in 'Controller\UControllerNegociacao.pas',
  UDAONegociacaoItens in 'DAO\UDAONegociacaoItens.pas',
  UModelNegociacaoItens in 'Model\UModelNegociacaoItens.pas',
  UControllerNegociacaoItens in 'Controller\UControllerNegociacaoItens.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
