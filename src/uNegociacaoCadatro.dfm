object frmNegociacaoCadastro: TfrmNegociacaoCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Negocia'#231#227'o'
  ClientHeight = 400
  ClientWidth = 416
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Produtor'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 54
    Height = 13
    Caption = 'Distribuidor'
  end
  object Label3: TLabel
    Left = 8
    Top = 108
    Width = 98
    Height = 13
    Caption = 'Produtos dispon'#237'veis'
  end
  object spdAdicionarUmProduto: TSpeedButton
    Left = 191
    Top = 144
    Width = 23
    Height = 22
    Caption = '>'
    OnClick = spdAdicionarUmProdutoClick
  end
  object spdAdicionarTodosProdutos: TSpeedButton
    Left = 191
    Top = 172
    Width = 23
    Height = 22
    Caption = '>>'
    OnClick = spdAdicionarTodosProdutosClick
  end
  object spdRemoveUmProduto: TSpeedButton
    Left = 191
    Top = 200
    Width = 23
    Height = 22
    Caption = '<'
    OnClick = spdRemoveUmProdutoClick
  end
  object spdRemoveTodosProdutos: TSpeedButton
    Left = 191
    Top = 228
    Width = 23
    Height = 22
    Caption = '<<'
    OnClick = spdRemoveTodosProdutosClick
  end
  object Label4: TLabel
    Left = 224
    Top = 108
    Width = 100
    Height = 13
    Caption = 'Produtos negociados'
  end
  object Label5: TLabel
    Left = 8
    Top = 262
    Width = 76
    Height = 13
    Caption = 'Total negociado'
  end
  object Label6: TLabel
    Left = 224
    Top = 262
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object Label7: TLabel
    Left = 8
    Top = 310
    Width = 85
    Height = 13
    Caption = 'Data de Cadastro'
  end
  object cboProdutor: TDBLookupComboBox
    Left = 8
    Top = 27
    Width = 393
    Height = 21
    KeyField = 'CODIGO'
    ListField = 'NOME'
    ListSource = DataModule1.dtsProdutor
    TabOrder = 0
  end
  object cboDistribuidor: TDBLookupComboBox
    Left = 8
    Top = 75
    Width = 393
    Height = 21
    KeyField = 'CODIGO'
    ListField = 'NOME'
    ListSource = DataModule1.dtsDistribuidor
    TabOrder = 1
  end
  object grdProdutosDisponiveis: TDBGrid
    Left = 8
    Top = 136
    Width = 177
    Height = 120
    DataSource = DataModule1.dtsConsultaProduto
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 145
        Visible = True
      end>
  end
  object grdProdutosNegociados: TDBGrid
    Left = 224
    Top = 136
    Width = 177
    Height = 120
    DataSource = dtsProdutosNegociados
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object edtTotal: TEdit
    Left = 8
    Top = 281
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object btnOk: TBitBtn
    Left = 245
    Top = 361
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    NumGlyphs = 2
    TabOrder = 7
    OnClick = btnOkClick
  end
  object btnCancelar: TBitBtn
    Left = 326
    Top = 361
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    NumGlyphs = 2
    TabOrder = 8
    OnClick = btnCancelarClick
  end
  object cboStatus: TComboBox
    Left = 224
    Top = 281
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 5
    Text = 'Pendente'
    Items.Strings = (
      'Pendente'
      'Aprovada'
      'Concluir'
      'Cancelada')
  end
  object edtData: TMaskEdit
    Left = 8
    Top = 329
    Width = 120
    Height = 21
    EditMask = '!99/99/0000;1; '
    MaxLength = 10
    TabOrder = 6
    Text = '  /  /    '
  end
  object cdsProdutosNegociados: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 304
    object cdsProdutosNegociadosProduto: TIntegerField
      FieldName = 'Produto'
      Visible = False
    end
    object cdsProdutosNegociadosNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object cdsProdutosNegociadosNegociacao: TIntegerField
      FieldName = 'Negociacao'
      Visible = False
    end
  end
  object dtsProdutosNegociados: TDataSource
    DataSet = cdsProdutosNegociados
    Left = 280
    Top = 320
  end
end
