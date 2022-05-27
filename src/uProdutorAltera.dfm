object frmProdutorAltera: TfrmProdutorAltera
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecione o Produtor para alterar'
  ClientHeight = 178
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdProdutor: TDBGrid
    Left = 0
    Top = 0
    Width = 457
    Height = 120
    Align = alTop
    DataSource = DataModule1.dtsProdutor
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnAlterar: TBitBtn
    Left = 293
    Top = 145
    Width = 75
    Height = 25
    Caption = '&Alterar'
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnAlterarClick
  end
  object btnFechar: TBitBtn
    Left = 374
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Fechar'
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnFecharClick
  end
end
