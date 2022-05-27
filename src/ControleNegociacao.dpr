program ControleNegociacao;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uProdutorCadastro in 'uProdutorCadastro.pas' {frmProdutorCadastro},
  uProdutorAltera in 'uProdutorAltera.pas' {frmProdutorAltera},
  uDistribuidorCadastro in 'uDistribuidorCadastro.pas' {frmDistribuidorCadastro},
  uProdutoCadastro in 'uProdutoCadastro.pas' {frmProdutoCadastro},
  uDistribuidorAltera in 'uDistribuidorAltera.pas' {frmDistribuidorAltera},
  uProdutoAltera in 'uProdutoAltera.pas' {frmProdutoAltera},
  uNegociacaoCadatro in 'uNegociacaoCadatro.pas' {frmNegociacaoCadastro},
  uNegociacaoAlteraConsulta in 'uNegociacaoAlteraConsulta.pas' {frmNegociacaoAlteraConsulta},
  uDM in 'uDM.pas' {DataModule1: TDataModule},
  uLimiteCreditoCadastro in 'uLimiteCreditoCadastro.pas' {frmLimiteCreditoCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmProdutorCadastro, frmProdutorCadastro);
  Application.CreateForm(TfrmProdutorAltera, frmProdutorAltera);
  Application.CreateForm(TfrmDistribuidorCadastro, frmDistribuidorCadastro);
  Application.CreateForm(TfrmProdutoCadastro, frmProdutoCadastro);
  Application.CreateForm(TfrmDistribuidorAltera, frmDistribuidorAltera);
  Application.CreateForm(TfrmProdutoAltera, frmProdutoAltera);
  Application.CreateForm(TfrmNegociacaoCadastro, frmNegociacaoCadastro);
  Application.CreateForm(TfrmNegociacaoAlteraConsulta, frmNegociacaoAlteraConsulta);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmLimiteCreditoCadastro, frmLimiteCreditoCadastro);
  Application.Run;
end.
