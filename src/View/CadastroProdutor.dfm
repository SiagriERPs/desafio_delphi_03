object FCadastroProdutor: TFCadastroProdutor
  Left = 0
  Top = 0
  Caption = 'Cadastro de Produtor'
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
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 507
    ExplicitHeight = 421
    object lbl_form: TLabel
      Left = 154
      Top = 32
      Width = 162
      Height = 28
      Caption = 'Cadastro Produtor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblNome: TLabel
      Left = 194
      Top = 73
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblCNPJ: TLabel
      Left = 106
      Top = 122
      Width = 53
      Height = 15
      Caption = 'CPF/CNPJ'
    end
    object lbl_cod: TLabel
      Left = 106
      Top = 73
      Width = 25
      Height = 15
      Caption = 'C'#243'd.'
    end
    object edtNome: TEdit
      Left = 194
      Top = 89
      Width = 148
      Height = 23
      TabOrder = 1
    end
    object edtCNPJ: TMaskEdit
      Left = 221
      Top = 152
      Width = 121
      Height = 23
      EditMask = '00.000.000/0000-00'
      MaxLength = 18
      TabOrder = 3
      Text = '  .   .   /    -  '
    end
    object btnSalvar: TButton
      Left = 215
      Top = 376
      Width = 76
      Height = 25
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 133
      Top = 376
      Width = 76
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 6
      OnClick = btnCancelarClick
    end
    object StringGrid1: TStringGrid
      Left = 0
      Top = 200
      Width = 511
      Height = 137
      ColCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect, goFixedRowDefAlign]
      TabOrder = 8
      OnSelectCell = StringGrid1SelectCell
    end
    object edtCod: TEdit
      Left = 106
      Top = 89
      Width = 54
      Height = 23
      Enabled = False
      TabOrder = 0
    end
    object btnExcluir: TButton
      Left = 297
      Top = 376
      Width = 76
      Height = 25
      Caption = 'Excluir'
      TabOrder = 7
      OnClick = btnExcluirClick
    end
    object RadioGroup1: TRadioGroup
      Left = 106
      Top = 138
      Width = 109
      Height = 37
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'CPF'
        'CNPJ')
      TabOrder = 2
      OnClick = RadioGroup1Click
    end
    object btnLimiteCredito: TButton
      Left = 368
      Top = 169
      Width = 131
      Height = 25
      Caption = 'Limite de Cr'#233'dito'
      TabOrder = 4
      OnClick = btnLimiteCreditoClick
    end
  end
end
