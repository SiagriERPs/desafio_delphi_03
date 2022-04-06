object frmSplash: TfrmSplash
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmSplash'
  ClientHeight = 60
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Progressor: TProgressBar
    Left = 0
    Top = 50
    Width = 556
    Height = 10
    Align = alBottom
    Max = 20
    Smooth = True
    TabOrder = 0
    ExplicitTop = 182
    ExplicitWidth = 420
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 556
    Height = 50
    Align = alClient
    Color = 5585446
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Facebook Letter Faces'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 2
    ExplicitWidth = 414
    ExplicitHeight = 47
    object Label2: TLabel
      Left = 281
      Top = 11
      Width = 117
      Height = 19
      Caption = 'Carregando.....  [ ]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Corbel'
      Font.Style = []
      ParentFont = False
    end
  end
end
