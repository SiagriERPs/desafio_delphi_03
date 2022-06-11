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
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 56
    Width = 26
    Height = 13
    Caption = 'Valor'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 62
    Height = 13
    Caption = 'Distribuidor'
  end
  object btnOk: TSpeedButton
    Left = 240
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Gravar'
    ImageIndex = 0
    Images = frmPrincipal.ImageList
    OnClick = btnOkClick
  end
  object SpeedButton1: TSpeedButton
    Left = 326
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ImageIndex = 1
    Images = frmPrincipal.ImageList
    OnClick = btnCancelarClick
  end
  object cboDistribuidor: TDBLookupComboBox
    Left = 8
    Top = 27
    Width = 393
    Height = 21
    KeyField = 'CODIGO'
    ListField = 'NOME'
    ListSource = DM.dtsDistribuidor
    TabOrder = 0
  end
  object edtValor: TNumberBox
    Left = 8
    Top = 75
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Mode = nbmCurrency
    TabOrder = 1
  end
end
