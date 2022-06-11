object frmDistribuidorAltera: TfrmDistribuidorAltera
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecione o Distribuidor para alterar'
  ClientHeight = 177
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnAlterar: TSpeedButton
    Left = 293
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Alterar'
    ImageIndex = 4
    Images = frmPrincipal.ImageList
    OnClick = btnAlterarClick
  end
  object btnFechar: TSpeedButton
    Left = 374
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Fechar'
    ImageIndex = 1
    Images = frmPrincipal.ImageList
    OnClick = btnFecharClick
  end
  object grdDistribuidor: TDBGrid
    Left = 0
    Top = 0
    Width = 464
    Height = 120
    Align = alTop
    DataSource = DM.dtsDistribuidor
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end
