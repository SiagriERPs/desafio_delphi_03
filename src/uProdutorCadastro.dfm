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
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblNome: TLabel
    Left = 8
    Top = 8
    Width = 30
    Height = 13
    Caption = 'Nome'
  end
  object lblCPFCNPJ: TLabel
    Left = 280
    Top = 8
    Width = 47
    Height = 13
    Caption = 'CPF/CNPJ'
  end
  object btnOk: TSpeedButton
    Left = 240
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Gravar'
    ImageIndex = 0
    Images = frmPrincipal.ImageList
    OnClick = btnOkClick
  end
  object SpeedButton1: TSpeedButton
    Left = 326
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ImageIndex = 1
    Images = frmPrincipal.ImageList
    OnClick = btnCancelarClick
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 57
    Width = 393
    Height = 187
    Caption = ' Limites de cr'#233'dito '
    TabOrder = 2
    object btnAdiciona: TSpeedButton
      Left = 227
      Top = 154
      Width = 75
      Height = 25
      ImageIndex = 2
      Images = frmPrincipal.ImageList
      OnClick = btnAdicionaClick
    end
    object btnRetira: TSpeedButton
      Left = 308
      Top = 154
      Width = 75
      Height = 25
      ImageIndex = 3
      Images = frmPrincipal.ImageList
      OnClick = btnRetiraClick
    end
    object grdLimiteCredito: TDBGrid
      Left = 9
      Top = 24
      Width = 373
      Height = 120
      DataSource = dtsLimiteCredito
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object cdsLimiteCredito: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 176
    object cdsLimiteCreditoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsLimiteCreditoditribuidor: TIntegerField
      DisplayLabel = 'Distribuidor'
      FieldName = 'distribuidor'
      Visible = False
    end
    object cdsLimiteCreditonomedistribuidor: TStringField
      DisplayLabel = 'Nome do Distribuidor'
      DisplayWidth = 40
      FieldName = 'nomedistribuidor'
      Size = 60
    end
    object cdsLimiteCreditovalor: TFloatField
      DisplayLabel = 'Valor'
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
