inherited FrmCadDistribuidor: TFrmCadDistribuidor
  Caption = 'Cadastro de Distribuidor'
  OnClose = FormClose
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
      object lblId: TLabel
        Left = 24
        Top = 34
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblName: TLabel
        Left = 24
        Top = 96
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object lblPrice: TLabel
        Left = 24
        Top = 156
        Width = 25
        Height = 13
        Caption = 'CNPJ'
      end
      object edtId: TEdit
        Left = 24
        Top = 53
        Width = 120
        Height = 21
        Color = clInfoBk
        Enabled = False
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TEdit
        Left = 24
        Top = 117
        Width = 296
        Height = 21
        MaxLength = 255
        TabOrder = 1
      end
      object edtCNPJ: TMaskEdit
        Left = 24
        Top = 174
        Width = 119
        Height = 21
        EditMask = '00.000.000/0000-00;0;_'
        MaxLength = 18
        TabOrder = 2
        Text = ''
      end
    end
  end
end
