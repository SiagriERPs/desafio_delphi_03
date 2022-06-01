program Controle_Negociação;

uses
  Vcl.Forms,
  fmMain in 'fmMain.pas' {frmMain},
  fmBasico in 'fmBasico.pas' {fmAnyForm},
  fmEditDados in 'fmEditDados.pas' {fmDataEdit},
  frmPesquisa in 'frmPesquisa.pas' {fmPesquisa},
  UdmConexao in 'UdmConexao.pas' {dmConexao: TDataModule},
  UdmProdutor in '..\Produtor\UdmProdutor.pas' {dmProdutor: TDataModule},
  frmProdutor in '..\Produtor\frmProdutor.pas' {fmProdutor},
  frmDistribuidor in '..\Distribuidor\frmDistribuidor.pas' {fmDistribuidor},
  UdmDistribuidor in '..\Distribuidor\UdmDistribuidor.pas' {dmDistribuidor: TDataModule},
  frmProduto in '..\Produto\frmProduto.pas' {fmProduto},
  UdmProduto in '..\Produto\UdmProduto.pas' {dmProduto: TDataModule},
  UdmFuncoes in 'UdmFuncoes.pas' {dmFuncoes: TDataModule},
  UdmNegociacao in '..\Negociacao\UdmNegociacao.pas' {dmNegociacao: TDataModule},
  frmEntrada_Negociacao in '..\Negociacao\frmEntrada_Negociacao.pas' {fmEntrada_Negociacao},
  Fmbasico3C in 'Fmbasico3C.pas' {Frmbasico3C},
  frmAtendimento_Negociacao in '..\Negociacao\frmAtendimento_Negociacao.pas' {fmAtendimento_Negociacao},
  frmPesquisaNegociacao in '..\Relatórios\frmPesquisaNegociacao.pas' {fmPesquisaNegociacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmFuncoes, dmFuncoes);
  Application.CreateForm(TdmDistribuidor, dmDistribuidor);
  Application.CreateForm(TdmProdutor, dmProdutor);
  Application.CreateForm(TdmProduto, dmProduto);
  Application.CreateForm(TdmNegociacao, dmNegociacao);
  Application.Run;
end.
