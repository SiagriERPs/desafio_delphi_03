object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Controle de Negocia'#231#227'o'
  ClientHeight = 422
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnl_principal: TPanel
    Left = 0
    Top = 0
    Width = 511
    Height = 422
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 507
    ExplicitHeight = 421
    object lbl_form: TLabel
      Left = 130
      Top = 48
      Width = 212
      Height = 28
      Caption = 'Controle de Negocia'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblNegociacao: TLabel
      Left = 224
      Top = 115
      Width = 63
      Height = 15
      Caption = 'Negocia'#231#227'o'
    end
    object lblProdutor: TLabel
      Left = 224
      Top = 189
      Width = 47
      Height = 15
      Caption = 'Produtor'
    end
    object lblDistribuidor: TLabel
      Left = 224
      Top = 262
      Width = 62
      Height = 15
      Caption = 'Distribuidor'
    end
    object Label4: TLabel
      Left = 224
      Top = 337
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object btnCadNegociacao: TButton
      Left = 32
      Top = 136
      Width = 137
      Height = 25
      Caption = 'Cadastro Negocia'#231#227'o'
      TabOrder = 0
      OnClick = btnCadNegociacaoClick
    end
    object btnCadProdutor: TButton
      Left = 184
      Top = 210
      Width = 137
      Height = 25
      Caption = 'Cadastro Produtor'
      TabOrder = 3
      OnClick = btnCadProdutorClick
    end
    object btnCadProduto: TButton
      Left = 184
      Top = 358
      Width = 137
      Height = 25
      Caption = 'Cadastro Produto'
      TabOrder = 5
      OnClick = btnCadProdutoClick
    end
    object btnCadDistribuidor: TButton
      Left = 184
      Top = 283
      Width = 137
      Height = 25
      Caption = 'Cadastro Distribuidor'
      TabOrder = 4
      OnClick = btnCadDistribuidorClick
    end
    object btnManutencaoNeg: TButton
      Left = 184
      Top = 136
      Width = 137
      Height = 25
      Caption = 'Manuten'#231#227'o'
      TabOrder = 1
      OnClick = btnManutencaoNegClick
    end
    object btnConsultaNeg: TButton
      Left = 336
      Top = 136
      Width = 137
      Height = 25
      Caption = 'Consulta'
      TabOrder = 2
      OnClick = btnConsultaNegClick
    end
  end
end
