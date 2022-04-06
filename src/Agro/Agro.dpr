program Agro;

uses
  Vcl.Forms,
  Windows,
  SysUtils,
  Dialogs,
  View.frmHome in 'View.frmHome.pas' {frmHome},
  View.frmProdutos in 'View.frmProdutos.pas' {frmProdutos},
  UDM in 'UDM.pas' {DM: TDataModule},
  View.frmSplash in 'View.frmSplash.pas' {frmSplash},
  UBD in 'UBD.pas',
  View.frmProdutores in 'View.frmProdutores.pas' {frmProdutores},
  View.frmDistribuidores in 'View.frmDistribuidores.pas' {frmDistribuidores},
  View.frmContratos in 'View.frmContratos.pas' {frmContratos},
  View.frmContratosReport in 'View.frmContratosReport.pas' {frmContratosReport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Agro';
  Application.MainFormOnTaskbar := True;
  try
      with TfrmSplash.Create(nil) do
          try
              Show;
              Update;
              Progressor.Max:=10;

              Application.Initialize;

              Progressor.Position:=1;
              sleep(200);
              Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmHome, frmHome);
  Progressor.Position:=7;
              sleep(200);

          finally
          Free;
      end;
      Application.Run;
  Except
       Application.Free;
  end;
end.
