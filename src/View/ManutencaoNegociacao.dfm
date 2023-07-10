object FManutencaoNegociacao: TFManutencaoNegociacao
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Negocia'#231#227'o'
  ClientHeight = 332
  ClientWidth = 510
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
    Width = 510
    Height = 332
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 506
    ExplicitHeight = 331
    object lbl_form: TLabel
      Left = 182
      Top = 32
      Width = 109
      Height = 28
      Caption = 'Manuten'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 168
      Top = 112
      Width = 63
      Height = 15
      Caption = 'Negociacao'
    end
    object Label2: TLabel
      Left = 168
      Top = 157
      Width = 63
      Height = 15
      Caption = 'Status Atual'
    end
    object Label3: TLabel
      Left = 168
      Top = 213
      Width = 99
      Height = 15
      Caption = 'Alterar Status para:'
    end
    object btnAlterar: TButton
      Left = 162
      Top = 280
      Width = 76
      Height = 25
      Caption = 'Alterar'
      TabOrder = 3
      OnClick = btnAlterarClick
    end
    object btnSair: TButton
      Left = 244
      Top = 280
      Width = 76
      Height = 25
      Caption = 'Sair'
      TabOrder = 4
      OnClick = btnSairClick
    end
    object cbxNegociacao: TComboBox
      Left = 168
      Top = 128
      Width = 145
      Height = 23
      TabOrder = 0
      OnChange = cbxNegociacaoChange
    end
    object Edit1: TEdit
      Left = 168
      Top = 176
      Width = 145
      Height = 23
      Enabled = False
      TabOrder = 1
    end
    object cbxStatus: TComboBox
      Left = 168
      Top = 228
      Width = 145
      Height = 23
      TabOrder = 2
    end
  end
end
