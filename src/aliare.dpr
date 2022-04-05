program aliare;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  ConexaoDB in 'ConexaoDB.pas' {DM: TDataModule},
  Classe.Mensagem in 'Utils\Classe.Mensagem.pas',
  uNotificacao in 'uNotificacao.pas' {frmNotificacao},
  uCadastroProdutores in 'uCadastroProdutores.pas' {frmCadProdutores},
  GETFuncoes in 'GETFuncoes.pas',
  uCadastroDistribuidores in 'uCadastroDistribuidores.pas' {frmCadDistribuidores},
  uCadastroProdutos in 'uCadastroProdutos.pas' {frmCadProdutos},
  Classe.Negociacoes.Interfaces in 'Classes\Classe.Negociacoes.Interfaces.pas',
  Classe.Negociacoes.Negociacao in 'Classes\Classe.Negociacoes.Negociacao.pas',
  Classe.Negociacoes.Aprovar in 'Classes\Classe.Negociacoes.Aprovar.pas',
  Classe.Negociacoes.LimiteCredito in 'Classes\Classe.Negociacoes.LimiteCredito.pas',
  Classe.Negociacoes.Cancelar in 'Classes\Classe.Negociacoes.Cancelar.pas',
  Classe.Negociacoes.Concluir in 'Classes\Classe.Negociacoes.Concluir.pas',
  uCadastroPadrao in 'uCadastroPadrao.pas' {frmCadPadrao},
  uCadastroNegociacoes in 'uCadastroNegociacoes.pas' {frmCadNegociacoes},
  uFormBase in 'uFormBase.pas' {frmBase},
  uGestorNegociacoes in 'uGestorNegociacoes.pas' {frmGestorNegociacoes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
