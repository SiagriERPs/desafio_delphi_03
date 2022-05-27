object frmLimiteCreditoCadastro: TfrmLimiteCreditoCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Limite de Cr'#233'dito'
  ClientHeight = 147
  ClientWidth = 409
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
  object Label5: TLabel
    Left = 8
    Top = 56
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 54
    Height = 13
    Caption = 'Distribuidor'
  end
  object cboDistribuidor: TDBLookupComboBox
    Left = 8
    Top = 27
    Width = 393
    Height = 21
    KeyField = 'CODIGO'
    ListField = 'NOME'
    ListSource = DataModule1.dtsDistribuidor
    TabOrder = 0
  end
  object btnOk: TBitBtn
    Left = 247
    Top = 117
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancelar: TBitBtn
    Left = 327
    Top = 117
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object edtValor: TMaskEdit
    Left = 8
    Top = 75
    Width = 113
    Height = 21
    Alignment = taRightJustify
    TabOrder = 3
    Text = ''
  end
end
