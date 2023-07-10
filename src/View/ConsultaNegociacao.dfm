object FConsultaNegociacao: TFConsultaNegociacao
  Left = 0
  Top = 0
  Caption = 'Consulta Negocia'#231#227'o'
  ClientHeight = 422
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pnl_principal: TPanel
    Left = 0
    Top = 0
    Width = 511
    Height = 422
    Hint = 
      'N'#227'o foi desenvolvido, pois no Delphi 11 Community Edition n'#227'o te' +
      'm componentes gr'#225'tis de relat'#243'rios.'
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 507
    ExplicitHeight = 421
    object lbl_form: TLabel
      Left = 202
      Top = 32
      Width = 76
      Height = 28
      Caption = 'Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnVisualizar: TButton
      Left = 160
      Top = 376
      Width = 115
      Height = 25
      Hint = 
        'N'#227'o foi desenvolvido, pois no Delphi 11 Community Edition n'#227'o te' +
        'm componentes gr'#225'tis de relat'#243'rios.'
      Caption = 'Visualizar Relat'#243'rio'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object StringGrid1: TStringGrid
      Left = 0
      Top = 208
      Width = 511
      Height = 129
      ColCount = 6
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect, goFixedRowDefAlign]
      TabOrder = 4
    end
    object btnSair: TButton
      Left = 281
      Top = 376
      Width = 76
      Height = 25
      Caption = 'Sair'
      TabOrder = 3
      OnClick = btnSairClick
    end
    object RadioGroup1: TRadioGroup
      Left = 140
      Top = 90
      Width = 185
      Height = 47
      Caption = 'Filtrar por: '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Produtor'
        'Distribuidor')
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object cbxProdDist: TComboBox
      Left = 140
      Top = 160
      Width = 185
      Height = 23
      TabOrder = 1
      OnClick = cbxProdDistClick
    end
  end
end
