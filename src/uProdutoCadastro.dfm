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
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object edtPreco: TEdit
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
    Top = 72
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
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnCancelarClick
  end
end
