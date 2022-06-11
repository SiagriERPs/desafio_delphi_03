object frmProdutoCadastro: TfrmProdutoCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Produto'
  ClientHeight = 108
  ClientWidth = 412
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
    Width = 28
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object btnGravar: TSpeedButton
    Left = 240
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Gravar'
    ImageIndex = 0
    Images = frmPrincipal.ImageList
    OnClick = btnOkClick
  end
  object btnCancelar: TSpeedButton
    Left = 326
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ImageIndex = 1
    Images = frmPrincipal.ImageList
    OnClick = btnCancelarClick
  end
  object edtNome: TEdit
    Left = 8
    Top = 27
    Width = 264
    Height = 21
    TabOrder = 0
  end
  object edtPreco: TNumberBox
    Left = 280
    Top = 27
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Mode = nbmCurrency
    TabOrder = 1
  end
end
