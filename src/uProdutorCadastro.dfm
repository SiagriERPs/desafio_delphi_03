object frmProdutorCadastro: TfrmProdutorCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Produtor'
  ClientHeight = 279
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblNome: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object lblCPFCNPJ: TLabel
    Left = 280
    Top = 8
    Width = 48
    Height = 13
    Caption = 'CPF/CNPJ'
  end
  object edtCPFCNPJ: TEdit
    Left = 280
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtNome: TEdit
    Left = 8
    Top = 27
    Width = 264
    Height = 21
    TabOrder = 0
  end
  object btnOk: TBitBtn
    Left = 245
    Top = 250
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancelar: TBitBtn
    Left = 326
    Top = 250
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 57
    Width = 393
    Height = 187
    Caption = ' Limites de cr'#233'dito '
    TabOrder = 4
    object DBGrid1: TDBGrid
      Left = 9
      Top = 24
      Width = 373
      Height = 120
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object btnAdiciona: TBitBtn
      Left = 227
      Top = 154
      Width = 75
      Height = 25
      Caption = '+'
      Default = True
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAdicionaClick
    end
    object btnRetira: TBitBtn
      Left = 308
      Top = 154
      Width = 75
      Height = 25
      Cancel = True
      Caption = '-'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnRetiraClick
    end
  end
  object cdsLimiteCredito: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 176
    object cdsLimiteCreditoditribuidor: TIntegerField
      FieldName = 'distribuidor'
      Visible = False
    end
    object cdsLimiteCreditonomedistribuidor: TStringField
      DisplayLabel = 'Distribuidor'
      FieldName = 'nomedistribuidor'
      Size = 60
    end
    object cdsLimiteCreditovalor: TFloatField
      FieldName = 'valor'
      DisplayFormat = '#,##0.00'
      currency = True
    end
  end
  object dtsLimiteCredito: TDataSource
    DataSet = cdsLimiteCredito
    Left = 200
    Top = 144
  end
end
