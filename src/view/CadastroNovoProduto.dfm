object FCadastroNovoProduto: TFCadastroNovoProduto
  Left = 0
  Top = 0
  Caption = 'FCadastroNovoProduto'
  ClientHeight = 441
  ClientWidth = 624
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
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    object lblNome: TLabel
      Left = 120
      Top = 130
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblPrecoVenda: TLabel
      Left = 120
      Top = 187
      Width = 81
      Height = 15
      Caption = 'Pre'#231'o de Venda'
    end
    object edtNome: TEdit
      Left = 120
      Top = 151
      Width = 225
      Height = 23
      MaxLength = 50
      TabOrder = 0
    end
    object edtPrecoVenda: TEdit
      Left = 120
      Top = 210
      Width = 225
      Height = 23
      MaxLength = 18
      TabOrder = 1
    end
    object btnSalvar: TBitBtn
      Left = 120
      Top = 400
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 2
      OnClick = btnSalvarClick
    end
    object btnLimpar: TBitBtn
      Left = 224
      Top = 400
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = btnLimparClick
    end
    object btnFechar: TBitBtn
      Left = 536
      Top = 400
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 4
      OnClick = btnFecharClick
    end
  end
end
