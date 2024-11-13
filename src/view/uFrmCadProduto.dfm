inherited FrmCadProduto: TFrmCadProduto
  Caption = 'Cadastro de Produto'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcMain: TPageControl
    inherited tbMain: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 513
      ExplicitHeight = 422
      object lblPrecoVenda: TLabel
        Left = 24
        Top = 156
        Width = 75
        Height = 13
        Caption = 'Pre'#231'o de Venda'
      end
      object lblName: TLabel
        Left = 24
        Top = 96
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object lblId: TLabel
        Left = 24
        Top = 32
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object edtPrecoVenda: TEdit
        Left = 24
        Top = 177
        Width = 121
        Height = 21
        TabOrder = 0
        OnKeyPress = edtPrecoVendaKeyPress
      end
      object edtNome: TEdit
        Left = 24
        Top = 117
        Width = 297
        Height = 21
        MaxLength = 255
        TabOrder = 1
      end
      object edtId: TEdit
        Left = 24
        Top = 53
        Width = 121
        Height = 21
        Color = clInfoBk
        Enabled = False
        NumbersOnly = True
        TabOrder = 2
      end
    end
  end
end
