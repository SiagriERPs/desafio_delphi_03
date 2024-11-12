object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Controle de Negocia'#231#245'es'
  ClientHeight = 539
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 775
    Height = 539
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 80
      Top = 16
      Width = 621
      Height = 71
      Align = alCustom
      Alignment = taCenter
      Caption = 'Controle de Negocia'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -53
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnDistribuidor: TBitBtn
      Left = 272
      Top = 168
      Width = 217
      Height = 113
      Caption = 'Cadastro Distribuidor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnDistribuidorClick
    end
    object btnProduto: TBitBtn
      Left = 520
      Top = 168
      Width = 217
      Height = 113
      Caption = 'Cadastro Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnProdutoClick
    end
    object btnProdutor: TBitBtn
      Left = 32
      Top = 168
      Width = 217
      Height = 113
      Caption = 'Cadastro Produtor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnProdutorClick
    end
    object btnNegociacao: TBitBtn
      Left = 248
      Top = 376
      Width = 257
      Height = 113
      Caption = 'Manuten'#231#227'o Negocia'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
end
