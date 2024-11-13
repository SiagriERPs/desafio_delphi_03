inherited FrmPesquisaProduto: TFrmPesquisaProduto
  Caption = 'Pesquisa Produto'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFilter: TPanel
    inherited edtNome: TEdit
      OnKeyPress = edtNomeKeyPress
    end
    object rbNome: TRadioButton
      Left = 359
      Top = 11
      Width = 47
      Height = 17
      Caption = 'Nome'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbCodigo: TRadioButton
      Left = 287
      Top = 11
      Width = 59
      Height = 17
      Caption = 'C'#243'digo'
      TabOrder = 2
    end
  end
  object dbgProduto: TDBGrid
    Left = 0
    Top = 65
    Width = 560
    Height = 265
    Align = alClient
    DataSource = dsPesquisaProduto
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgProdutoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PRODUTO_ID'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 312
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECO_VENDA'
        Title.Caption = 'Pre'#231'o de Venda'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 123
        Visible = True
      end>
  end
  object qryPesquisaProduto: TFDQuery
    Connection = DM.FDConnection
    SQL.Strings = (
      'select'
      '  produto_id,'
      '  nome,'
      '  preco_venda'
      'from'
      '  tab_produto ')
    Left = 192
    Top = 160
    object qryPesquisaProdutoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaProdutoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object qryPesquisaProdutoPRECO_VENDA: TBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object dsPesquisaProduto: TDataSource
    DataSet = qryPesquisaProduto
    Left = 192
    Top = 224
  end
end
