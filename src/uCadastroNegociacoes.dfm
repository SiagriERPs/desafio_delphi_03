inherited frmCadNegociacoes: TfrmCadNegociacoes
  Caption = 'Aliare - Cadastro de Contrato de Negocia'#231#245'es'
  ClientWidth = 1100
  ExplicitWidth = 1100
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTopo: TPanel
    Width = 1100
    ExplicitWidth = 1100
    inherited btnMinimizar: TSpeedButton
      Left = 1040
      ExplicitLeft = 1040
    end
    inherited btnFechar: TSpeedButton
      Left = 1070
      ExplicitLeft = 1070
    end
  end
  inherited pnlBotton: TPanel
    Width = 1100
    ExplicitWidth = 1100
  end
  inherited pnlComandos: TPanel
    Left = 992
    ExplicitLeft = 992
    inherited btnAlterar: TButton
      ExplicitLeft = 3
      ExplicitTop = 48
    end
    inherited btnExcluir: TButton
      ExplicitLeft = 3
      ExplicitTop = 94
    end
    inherited btnGravar: TButton
      ExplicitLeft = 3
      ExplicitTop = 140
    end
    inherited btnVoltar: TButton
      ExplicitLeft = 3
      ExplicitTop = 232
    end
  end
  inherited pgGeral: TPageControl
    Width = 992
    ExplicitWidth = 992
    inherited tbShtGrid: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 984
      ExplicitHeight = 398
      inherited Grid1: TDBGrid
        Width = 984
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATUS'
            Title.Alignment = taCenter
            Title.Caption = 'Status'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Alignment = taCenter
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_PRODUTOR'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CL_PRODUTOR'
            Title.Alignment = taCenter
            Width = 230
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_DISTRIBUIDOR'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CL_DISTRIBUIDOR'
            Title.Alignment = taCenter
            Width = 230
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Alignment = taRightJustify
            Width = 85
            Visible = True
          end>
      end
    end
    inherited tbshtCadastro: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 984
      ExplicitHeight = 398
      object Label1: TLabel
        Left = 8
        Top = 12
        Width = 38
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel
        Left = 79
        Top = 12
        Width = 49
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label3: TLabel
        Left = 8
        Top = 60
        Width = 46
        Height = 13
        Caption = 'Produtor'
      end
      object Label7: TLabel
        Left = 8
        Top = 109
        Width = 62
        Height = 13
        Caption = 'Distribuidor'
      end
      object Label6: TLabel
        Left = 559
        Top = 12
        Width = 26
        Height = 13
        Caption = 'Valor'
      end
      object dbedtID: TDBEdit
        Left = 8
        Top = 31
        Width = 65
        Height = 21
        TabStop = False
        Color = clInfoBk
        DataField = 'ID'
        DataSource = dsrCadastro
        ReadOnly = True
        TabOrder = 0
      end
      object dbedtDESCRICAO: TDBEdit
        Left = 79
        Top = 29
        Width = 430
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DESCRICAO'
        DataSource = dsrCadastro
        TabOrder = 1
      end
      object dbedtID_PRODUTOR: TDBEdit
        Tag = 1
        Left = 8
        Top = 79
        Width = 65
        Height = 21
        DataField = 'ID_PRODUTOR'
        DataSource = dsrCadastro
        TabOrder = 3
        OnEnter = dbedtID_PRODUTOREnter
        OnExit = dbedtID_PRODUTORExit
        OnKeyDown = dbedtID_PRODUTORKeyDown
        OnKeyPress = dbedtID_PRODUTORKeyPress
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 155
        Width = 984
        Height = 54
        Align = alBottom
        Caption = 
          '                                                                ' +
          '                        Produto(s)'
        TabOrder = 7
        object Label4: TLabel
          Left = 10
          Top = 10
          Width = 38
          Height = 13
          Caption = 'C'#243'digo'
        end
        object Label5: TLabel
          Left = 88
          Top = 10
          Width = 75
          Height = 13
          Caption = 'Nome Produto'
        end
        object btnIncluirProdutos: TButton
          Left = 515
          Top = 26
          Width = 70
          Height = 23
          Caption = 'Incluir'
          ImageIndex = 8
          ImageMargins.Left = 10
          Images = DM.ImageList1
          TabOrder = 2
          OnClick = btnIncluirProdutosClick
        end
        object edtCodProduto: TEdit
          Tag = 1
          Left = 8
          Top = 27
          Width = 74
          Height = 21
          Alignment = taCenter
          TabOrder = 0
          OnEnter = edtCodProdutoEnter
          OnExit = edtCodProdutoExit
          OnKeyDown = edtCodProdutoKeyDown
          OnKeyPress = edtCodProdutoKeyPress
        end
        object edtNomeProduto: TEdit
          Left = 88
          Top = 27
          Width = 421
          Height = 21
          TabStop = False
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 1
        end
      end
      object DBGridProdutos: TDBGrid
        Left = 0
        Top = 209
        Width = 984
        Height = 174
        Align = alBottom
        DataSource = dsrProdutos
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 8
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDrawColumnCell = DBGridProdutosDrawColumnCell
        OnKeyDown = DBGridProdutosKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_PRODUTO'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CL_PRODUTO'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Alignment = taRightJustify
            Width = 100
            Visible = True
          end>
      end
      object dbedtCL_PRODUTOR: TDBEdit
        Left = 79
        Top = 78
        Width = 506
        Height = 21
        TabStop = False
        Color = clInfoBk
        DataField = 'CL_PRODUTOR'
        DataSource = dsrCadastro
        ReadOnly = True
        TabOrder = 4
      end
      object dbedtID_DISTRIBUIDOR: TDBEdit
        Tag = 1
        Left = 8
        Top = 128
        Width = 65
        Height = 21
        DataField = 'ID_DISTRIBUIDOR'
        DataSource = dsrCadastro
        TabOrder = 5
        OnEnter = dbedtID_DISTRIBUIDOREnter
        OnExit = dbedtID_DISTRIBUIDORExit
        OnKeyDown = dbedtID_DISTRIBUIDORKeyDown
        OnKeyPress = dbedtID_DISTRIBUIDORKeyPress
      end
      object dbedtCL_DISTRIBUIDOR: TDBEdit
        Left = 79
        Top = 128
        Width = 506
        Height = 21
        TabStop = False
        Color = clInfoBk
        DataField = 'CL_DISTRIBUIDOR'
        DataSource = dsrCadastro
        ReadOnly = True
        TabOrder = 6
      end
      object pnlInfoDelete: TPanel
        Left = 0
        Top = 383
        Width = 984
        Height = 15
        Align = alBottom
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = ' [Del] - Excluir Produto Selecionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
      end
      object dbedtVALOR: TDBEdit
        Left = 515
        Top = 29
        Width = 70
        Height = 21
        TabStop = False
        Color = clInfoBk
        DataField = 'VALOR'
        DataSource = dsrCadastro
        ReadOnly = True
        TabOrder = 2
        OnEnter = dbedtID_DISTRIBUIDOREnter
        OnExit = dbedtID_DISTRIBUIDORExit
        OnKeyDown = dbedtID_DISTRIBUIDORKeyDown
        OnKeyPress = dbedtID_DISTRIBUIDORKeyPress
      end
    end
  end
  inherited dsrCadastro: TDataSource
    DataSet = FDQCadastro
    Left = 651
    Top = 320
  end
  object FDQCadastro: TFDQuery
    AfterOpen = FDQCadastroAfterOpen
    OnCalcFields = FDQCadastroCalcFields
    OnNewRecord = FDQCadastroNewRecord
    IndexFieldNames = 'ID'
    Connection = DM.con
    SQL.Strings = (
      'select'
      '*'
      'from NEGOCIACOES')
    Left = 651
    Top = 366
    object FDQCadastroID: TIntegerField
      Alignment = taCenter
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQCadastroSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
      OnGetText = FDQCadastroSTATUSGetText
      FixedChar = True
      Size = 3
    end
    object FDQCadastroDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 120
    end
    object FDQCadastroID_PRODUTOR: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'd. Produtor'
      FieldName = 'ID_PRODUTOR'
      Origin = 'ID_PRODUTOR'
      Required = True
    end
    object FDQCadastroID_DISTRIBUIDOR: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'd. Distribuidor'
      FieldName = 'ID_DISTRIBUIDOR'
      Origin = 'ID_DISTRIBUIDOR'
      Required = True
    end
    object FDQCadastroVALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 7
    end
    object FDQCadastroCL_PRODUTOR: TStringField
      DisplayLabel = 'Produtor'
      FieldKind = fkCalculated
      FieldName = 'CL_PRODUTOR'
      Size = 120
      Calculated = True
    end
    object FDQCadastroCL_DISTRIBUIDOR: TStringField
      DisplayLabel = 'Distribuidor'
      FieldKind = fkCalculated
      FieldName = 'CL_DISTRIBUIDOR'
      Size = 120
      Calculated = True
    end
    object FDQCadastroDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
      Required = True
    end
  end
  object FDQProdutos: TFDQuery
    OnCalcFields = FDQProdutosCalcFields
    IndexFieldNames = 'ID_NEGOCIACAO'
    MasterSource = dsrCadastro
    MasterFields = 'ID'
    Connection = DM.con
    SQL.Strings = (
      'select'
      '*'
      'from NEGOCIACOES_ITENS'
      'where id_negociacao = :id')
    Left = 124
    Top = 358
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQProdutosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQProdutosID_NEGOCIACAO: TIntegerField
      FieldName = 'ID_NEGOCIACAO'
      Origin = 'ID_NEGOCIACAO'
      Required = True
    end
    object FDQProdutosID_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
      Required = True
    end
    object FDQProdutosCL_PRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldKind = fkCalculated
      FieldName = 'CL_PRODUTO'
      Size = 80
      Calculated = True
    end
    object FDQProdutosVALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
  end
  object dsrProdutos: TDataSource
    DataSet = FDQProdutos
    Left = 60
    Top = 334
  end
end
