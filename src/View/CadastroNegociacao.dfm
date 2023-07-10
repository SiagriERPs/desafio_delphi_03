object FCadastroNegociacao: TFCadastroNegociacao
  Left = 0
  Top = 0
  Caption = 'Cadastro de Negocia'#231#227'o'
  ClientHeight = 506
  ClientWidth = 515
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
    Width = 515
    Height = 506
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 511
    ExplicitHeight = 505
    object lbl_form: TLabel
      Left = 138
      Top = 9
      Width = 214
      Height = 28
      Caption = 'Cadastro de Negocia'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 353
      Top = 430
      Width = 27
      Height = 15
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQtd: TLabel
      Left = 411
      Top = 221
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lblProdutor: TLabel
      Left = 23
      Top = 173
      Width = 47
      Height = 15
      Caption = 'Produtor'
    end
    object lblDistribuidor: TLabel
      Left = 280
      Top = 173
      Width = 62
      Height = 15
      Caption = 'Distribuidor'
    end
    object lblProduto: TLabel
      Left = 23
      Top = 221
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object lblPreco: TLabel
      Left = 255
      Top = 221
      Width = 30
      Height = 15
      Caption = 'Pre'#231'o'
    end
    object edtPreco: TEdit
      Left = 255
      Top = 240
      Width = 105
      Height = 23
      Enabled = False
      TabOrder = 3
    end
    object btnSalvar: TButton
      Left = 159
      Top = 477
      Width = 76
      Height = 25
      Caption = 'Salvar'
      TabOrder = 9
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 323
      Top = 477
      Width = 76
      Height = 25
      Caption = 'Sair'
      TabOrder = 12
      OnClick = btnCancelarClick
    end
    object StringGrid1: TStringGrid
      Left = 0
      Top = 302
      Width = 511
      Height = 121
      ColCount = 4
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect, goFixedRowDefAlign]
      TabOrder = 8
    end
    object edtQtd: TEdit
      Left = 411
      Top = 240
      Width = 84
      Height = 23
      Enabled = False
      TabOrder = 4
    end
    object btnExcluir: TButton
      Left = 241
      Top = 477
      Width = 76
      Height = 25
      Caption = 'Excluir'
      TabOrder = 10
      OnClick = btnExcluirClick
    end
    object edtTotal: TEdit
      Left = 389
      Top = 426
      Width = 105
      Height = 23
      Enabled = False
      TabOrder = 7
    end
    object cbxProdutor: TComboBox
      Left = 23
      Top = 192
      Width = 193
      Height = 23
      TabOrder = 0
    end
    object cbxDistribuidor: TComboBox
      Left = 280
      Top = 192
      Width = 193
      Height = 23
      TabOrder = 1
    end
    object cbxProduto: TComboBox
      Left = 23
      Top = 240
      Width = 193
      Height = 23
      TabOrder = 2
      OnClick = cbxProdutoClick
    end
    object btnAdd: TButton
      Left = 368
      Top = 279
      Width = 141
      Height = 21
      Caption = 'Adicionar item'
      TabOrder = 5
      OnClick = btnAddClick
    end
    object btnRemover: TButton
      Left = 2
      Top = 424
      Width = 141
      Height = 21
      Caption = 'Remover item'
      TabOrder = 6
      OnClick = btnRemoverClick
    end
    object GroupBox1: TGroupBox
      Left = 21
      Top = 62
      Width = 474
      Height = 105
      TabOrder = 11
      object lblNegociacao: TLabel
        Left = 68
        Top = 37
        Width = 63
        Height = 15
        Caption = 'Negociacao'
      end
      object Label2: TLabel
        Left = 3
        Top = 3
        Width = 428
        Height = 13
        Caption = 
          '*Selecione uma negocia'#231#227'o existente ou clique em nova negocia'#231#227'o' +
          ' para cadastrar.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object cbxNegociacao: TComboBox
        Left = 68
        Top = 58
        Width = 212
        Height = 23
        TabOrder = 0
        OnClick = cbxNegociacaoClick
      end
      object btnNovo: TButton
        Left = 327
        Top = 56
        Width = 114
        Height = 25
        Caption = 'Nova Negocia'#231#227'o'
        TabOrder = 1
        OnClick = btnNovoClick
      end
    end
  end
end
