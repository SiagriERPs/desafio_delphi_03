unit UdmFuncoes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, IdMessage;

type
  TdmFuncoes = class(TDataModule)
    fdqyNumeracao: TFDQuery;
    fdqyPesquisa: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function NumeroLivre(sistemaID : Integer; NomeTabela: String): Integer;
  end;

var
  dmFuncoes: TdmFuncoes;

implementation

uses UdmConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{%CLASSGROUP 'Vcl.Dialogs.TDialog'}

{$R *.dfm}

{ TdmFuncoes }

function TdmFuncoes.NumeroLivre(sistemaID: Integer;
  NomeTabela: String): Integer;
var
  nroLivre : Integer;
begin
  with dmConexao do try
    nroLivre := 0;
    fdqyNumeracao.Params.ParamByName('NmrNometabela').AsString := nomeTabela;
    fdqyNumeracao.params.ParamByName('SistemaID').AsInteger      := sistemaid;
    fdqyNumeracao.Open;

    if not(fdqyNumeracao.IsEmpty) then begin
          nroLivre := fdqyNumeracao.FieldbyName('NmrNumerolivre').AsInteger;
         // FDConnection.Connected := True;
          fdqyNumeracao.Edit;
          fdqyNumeracao.FieldByName('NmrNumerolivre').AsInteger := fdqyNumeracao.FieldByName('NmrNumerolivre').AsInteger + 1;
          fdTransaction.StartTransaction;
          fdqyNumeracao.Post;
          FDTransaction.CommitRetaining;
          fdqyNumeracao.Close;
          Result := nroLivre;
     end;

  except
    fdqyNumeracao.CancelUpdates;
    FDTransaction.RollbackRetaining;
    fdqyNumeracao.Close;
    Result := 0;
  end;


end;

end.
