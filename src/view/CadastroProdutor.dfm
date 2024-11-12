object FCadastroProdutor: TFCadastroProdutor
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 501
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object pnTopo: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 121
    Align = alTop
    TabOrder = 0
    object lblNome: TLabel
      Left = 16
      Top = 32
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblCPFCNPJ: TLabel
      Left = 16
      Top = 72
      Width = 53
      Height = 15
      Caption = 'CPF/CNPJ'
    end
    object btnPesquisar: TBitBtn
      Left = 672
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = btnPesquisarClick
    end
    object edtNome: TEdit
      Left = 79
      Top = 29
      Width = 346
      Height = 23
      TabOrder = 1
    end
    object edtCPFCNPJ: TEdit
      Left = 79
      Top = 66
      Width = 346
      Height = 23
      TabOrder = 2
    end
  end
  object pnGrid: TPanel
    Left = 0
    Top = 121
    Width = 761
    Height = 339
    Align = alClient
    TabOrder = 1
    object StringGrid1: TStringGrid
      Left = 1
      Top = 1
      Width = 759
      Height = 337
      Align = alClient
      ColCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect, goFixedRowDefAlign]
      TabOrder = 0
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 460
    Width = 761
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btnFechar: TBitBtn
      Left = 672
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object btnNovo: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btnNovoClick
    end
    object BitBtn3: TBitBtn
      Left = 100
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BitBtn3'
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 185
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BitBtn4'
      TabOrder = 3
    end
  end
end
