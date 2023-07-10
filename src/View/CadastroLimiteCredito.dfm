object FCadastroLimiteCredito: TFCadastroLimiteCredito
  Left = 0
  Top = 0
  Caption = 'Cadastro Limite de Cr'#233'dito'
  ClientHeight = 316
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
    Height = 316
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 507
    ExplicitHeight = 315
    object lbl_form: TLabel
      Left = 122
      Top = 32
      Width = 264
      Height = 28
      Caption = 'Manuten'#231#227'o Limite de Cr'#233'dito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblLimiteCredito: TLabel
      Left = 122
      Top = 186
      Width = 91
      Height = 15
      Caption = 'Limite de Cr'#233'dito'
    end
    object Label1: TLabel
      Left = 122
      Top = 148
      Width = 62
      Height = 15
      Caption = 'Distribuidor'
    end
    object lblProdutor: TLabel
      Left = 122
      Top = 106
      Width = 47
      Height = 15
      Caption = 'Produtor'
    end
    object btnSalvar: TButton
      Left = 187
      Top = 256
      Width = 76
      Height = 24
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 269
      Top = 256
      Width = 76
      Height = 24
      Caption = 'Sair'
      TabOrder = 5
      OnClick = btnCancelarClick
    end
    object edtLimiteCredito: TEdit
      Left = 122
      Top = 202
      Width = 105
      Height = 23
      TabOrder = 3
      OnExit = edtLimiteCreditoExit
    end
    object cbxDistribuidor: TComboBox
      Left = 122
      Top = 162
      Width = 283
      Height = 23
      TabOrder = 2
      OnClick = cbxDistribuidorClick
    end
    object edtProdutor: TEdit
      Left = 183
      Top = 123
      Width = 221
      Height = 23
      Enabled = False
      TabOrder = 1
    end
    object edtIdProdutor: TEdit
      Left = 122
      Top = 123
      Width = 56
      Height = 23
      Enabled = False
      TabOrder = 0
    end
  end
end
