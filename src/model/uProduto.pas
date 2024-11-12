unit uProduto;

interface

uses
  System.SysUtils;

type
  TProduto = class
  private
    FID: Integer;
    FNome: string;
    FPrecoVenda: currency;
  public
    constructor Create(ID: Integer; Nome: string; PrecoVenda: currency);
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property PrecoVenda: currency read FPrecoVenda write FPrecoVenda;
  end;

implementation

constructor TProduto.Create(ID: Integer; Nome: string; PrecoVenda: currency);
begin
  FID := ID;
  FNome := Nome;
  FPrecoVenda := PrecoVenda;
end;

end.

