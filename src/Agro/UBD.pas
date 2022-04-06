unit UBD;

interface
uses
   SysUtils,Forms, UDM;

  function CriaBanco: boolean;
  function DiretorioSistema: TFileName;
  function Conectar: boolean;
implementation

//se der tempo implentar a criacao da base
function CriaBanco: boolean;
begin
    CriaBanco := True;
end;

function DiretorioSistema: TFileName;
begin
  DiretorioSistema := ExtractFilePath(Application.ExeName);
end;

function Conectar: boolean;
begin
  try
    Conectar := False;
    DM.CarregaBase;
    if not DM.conexao.Connected then
    begin
      DM.Free;
    end
    else
    begin
      Conectar := True;
    end;
  except
    Conectar := False;
  end;
end;

end.
