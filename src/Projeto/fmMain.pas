unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBCtrls, ExtCtrls, Buttons, ComCtrls, Db,
  inifiles, StdCtrls, DBClient,
  OleCtrls, SHDocVw,  ToolWin, Grids, DBGrids;


type
  TfrmMain = class(TForm)
    mmPrincipal: TMainMenu;
    stbPrincipal: TStatusBar;
    paPrincipal: TPanel;
    paToolbar: TPanel;
    Materiais1: TMenuItem;
    CadastroGeral1: TMenuItem;
    CadastroProdutor: TMenuItem;
    CadastroDistribuidor: TMenuItem;
    Cadastros1: TMenuItem;
    Timer: TTimer;
    Relatrios1: TMenuItem;
    lbCCustoUsuario: TLabel;
    N35: TMenuItem;
    dsCarregaInfoDiario: TDataSource;
    Entrada1: TMenuItem;
    ListadeNegociaes1: TMenuItem;
    Atendimento1: TMenuItem;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure bbFecharClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure CadastroProdutorClick(Sender: TObject);
    procedure CadastroDistribuidorClick(Sender: TObject);
    procedure CadastroGeral1Click(Sender: TObject);
    procedure Entrada1Click(Sender: TObject);
    procedure ListadeNegociaes1Click(Sender: TObject);
    procedure Atendimento1Click(Sender: TObject);

  private
    { Private declarations }
    InformExecucao : boolean;
    Sarquivo : TStringList;
  public
    { Public declarations }
    Lockout : Integer;



  end;

var
  frmMain: TfrmMain;

implementation

uses
Funcoes,
frmProdutor,
frmDistribuidor,
frmProduto,
frmEntrada_Negociacao,
frmPesquisaNegociacao,
frmAtendimento_Negociacao;


{$R *.DFM}

procedure TfrmMain.CadastroProdutorClick(Sender: TObject);
begin
   try
     fmProdutor := TfmProdutor.create(nil);
     fmProdutor.ShowModal;
   finally
     FreeAndNil(fmProdutor);
   end;
end;

procedure TfrmMain.Entrada1Click(Sender: TObject);
begin
    try
      fmEntrada_Negociacao := TfmEntrada_Negociacao.Create(nil);
      fmEntrada_Negociacao.showModal;
    finally
      FreeAndNil(fmEntrada_Negociacao);
    end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
type
   RetornaTexto = function : PChar;
   RetornaNumero = function : Integer;
var
   dwErr : DWord;
   NumeroTag : RetornaNumero;
   PosicaoMenu : RetornaNumero;
   NomeMenu : RetornaTexto;
   NovoItem : TMenuItem;
   MenuExiste, PluginInvalido : Boolean;
   nomedll : string;
   i, j : Integer;
   ip : string;
   porta : integer;
   dataux, cctdescricao, matric, regCons : String;
   ccusto : integer;
   proxyjava : string;
begin

end;

procedure TfrmMain.ListadeNegociaes1Click(Sender: TObject);
begin
   try
     fmPesquisaNegociacao := TfmPesquisaNegociacao.Create(nil);
     fmPesquisaNegociacao.ShowModal;
  finally
     FreeAndNil(fmPesquisaNegociacao);
  end;
end;


procedure TfrmMain.CadastroDistribuidorClick(Sender: TObject);
begin
  try
     FmDistribuidor := TfmDistribuidor.Create(nil);
     FmDistribuidor.ShowModal;
  finally
     FreeAndNil(FmDistribuidor);
  end;
end;

procedure TfrmMain.CadastroGeral1Click(Sender: TObject);
begin
    try
      fmProduto := TfmProduto.Create(nil);
      fmProduto.ShowModal;
    finally
      FreeAndNil(fmProduto);
    end;
end;

procedure TfrmMain.Atendimento1Click(Sender: TObject);
begin
  try
      fmAtendimento_Negociacao := TfmAtendimento_Negociacao.Create(nil);
      fmAtendimento_Negociacao.ShowModal;
  finally
     FreeAndNil(fmAtendimento_Negociacao);
  end;
end;

procedure TfrmMain.bbFecharClick(Sender: TObject);
begin
  close;
end;





procedure TfrmMain.TimerTimer(Sender: TObject);
var
   Componente : TComponent;
begin
     if Lockout = -1 then
        Exit;
     Lockout := Lockout + 1;
     if Lockout >= 14400 then begin            //60 minutos = 3600; 14400 = 240 minutos - alterado por crisrs em 29.08.05
        Componente := Screen.ActiveForm.FindComponent('DataSource');
        if Componente = nil then
           Screen.ActiveForm.Close
        else
           if not ((Componente as TDatasource).DataSet.State in [dsEdit, dsInsert]) then
              Screen.ActiveForm.Close;
     end;
end;



end.




