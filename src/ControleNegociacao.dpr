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
  uDM in 'uDM.pas' {DM: TDataModule},
  uLimiteCreditoCadastro in 'uLimiteCreditoCadastro.pas' {frmLimiteCreditoCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
