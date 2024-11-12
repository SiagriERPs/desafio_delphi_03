object FCadastroNovoProdutor: TFCadastroNovoProdutor
  Left = 0
  Top = 0
  Caption = 'FCadastroNovoProdutor'
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
      Top = 136
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblCNPJ: TLabel
      Left = 120
      Top = 203
      Width = 27
      Height = 15
      Caption = 'CNPJ'
    end
    object edtNome: TEdit
      Left = 159
      Top = 133
      Width = 225
      Height = 23
      MaxLength = 50
      TabOrder = 0
    end
    object edtCNPJ: TEdit
      Left = 153
      Top = 200
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
