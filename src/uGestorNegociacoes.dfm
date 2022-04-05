inherited frmGestorNegociacoes: TfrmGestorNegociacoes
  Caption = 'Aliare - Gestor de Negocia'#231#245'es'
  ClientHeight = 519
  ClientWidth = 967
  OnCreate = FormCreate
  ExplicitWidth = 967
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTopo: TPanel
    Width = 967
    ExplicitWidth = 967
    inherited btnMinimizar: TSpeedButton
      Left = 907
      ExplicitLeft = 907
    end
    inherited btnFechar: TSpeedButton
      Left = 937
      ExplicitLeft = 937
    end
  end
  inherited pnlBotton: TPanel
    Top = 504
    Width = 967
    ExplicitTop = 504
    ExplicitWidth = 967
  end
  object pnlComandos: TPanel
    Left = 0
    Top = 468
    Width = 967
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnAprovar: TButton
      Left = 10
      Top = 4
      Width = 100
      Height = 28
      Caption = 'Aprovar'
      ImageIndex = 8
      ImageMargins.Left = 10
      Images = DM.ImageList1
      TabOrder = 0
      OnClick = btnAprovarClick
    end
    object btnConcluir: TButton
      Left = 120
      Top = 4
      Width = 100
      Height = 28
      Caption = 'Concluir'
      ImageIndex = 11
      ImageMargins.Left = 10
      Images = DM.ImageList1
      TabOrder = 1
      OnClick = btnConcluirClick
    end
    object btnCancelar: TButton
      Left = 230
      Top = 4
      Width = 100
      Height = 28
      Caption = 'Cancelar'
      ImageIndex = 1
      ImageMargins.Left = 10
      Images = DM.ImageList1
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnImprimir: TButton
      Left = 336
      Top = 4
      Width = 100
      Height = 28
      Caption = 'Imprimir'
      ImageIndex = 10
      ImageMargins.Left = 10
      Images = DM.ImageList1
      TabOrder = 3
      OnClick = btnImprimirClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 137
    Width = 967
    Height = 331
    Align = alClient
    DataSource = dsrNegociacoes
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
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
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Width = 320
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
        Width = 97
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
        Width = 100
        Visible = True
      end>
  end
  object pnlFiltros: TPanel
    Left = 0
    Top = 30
    Width = 967
    Height = 107
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    VerticalAlignment = taAlignBottom
    object Label1: TLabel
      Left = 18
      Top = 5
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 96
      Top = 5
      Width = 79
      Height = 13
      Caption = 'Nome Produtor'
    end
    object Label3: TLabel
      Left = 18
      Top = 49
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label4: TLabel
      Left = 96
      Top = 49
      Width = 95
      Height = 13
      Caption = 'Nome Distribuidor'
    end
    object Label5: TLabel
      Left = 493
      Top = 20
      Width = 32
      Height = 13
      Caption = 'Status'
    end
    object Label6: TLabel
      Left = 438
      Top = 68
      Width = 87
      Height = 13
      Caption = 'Data Negocia'#231#227'o'
    end
    object Label7: TLabel
      Left = 685
      Top = 68
      Width = 16
      Height = 13
      Caption = 'at'#233
    end
    object cbbStatus: TComboBox
      Left = 537
      Top = 17
      Width = 145
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 1
      TabOrder = 4
      Text = 'Pendentes'
      OnClick = cbbStatusClick
      Items.Strings = (
        'Todas'
        'Pendentes'
        'Aprovadas'
        'Concluidas'
        'Canceladas')
    end
    object edtCodProdutor: TEdit
      Tag = 1
      Left = 16
      Top = 18
      Width = 74
      Height = 21
      Alignment = taCenter
      TabOrder = 0
      OnEnter = edtCodProdutorEnter
      OnExit = edtCodProdutorExit
    end
    object edtNomeProdutor: TEdit
      Left = 96
      Top = 18
      Width = 336
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 1
    end
    object edtCodDistribuidor: TEdit
      Tag = 1
      Left = 16
      Top = 64
      Width = 74
      Height = 21
      Alignment = taCenter
      TabOrder = 2
      OnEnter = edtCodDistribuidorEnter
      OnExit = edtCodDistribuidorExit
    end
    object edtNomeDistribuidor: TEdit
      Left = 96
      Top = 64
      Width = 336
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 3
    end
    object btnFiltrar: TButton
      Left = 876
      Top = 17
      Width = 91
      Height = 43
      Caption = 'Filtrar'
      ImageAlignment = iaTop
      ImageIndex = 10
      ImageMargins.Top = 5
      Images = DM.ImageList1
      TabOrder = 6
      OnClick = btnFiltrarClick
    end
    object dtCadastroIni: TDateTimePicker
      Left = 537
      Top = 64
      Width = 145
      Height = 21
      Date = 44654.000000000000000000
      Time = 0.923318402776203600
      Checked = False
      DoubleBuffered = True
      ParseInput = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 5
    end
    object dtCadastroFim: TDateTimePicker
      Left = 703
      Top = 64
      Width = 145
      Height = 21
      Date = 44654.000000000000000000
      Time = 0.923318402776203600
      Checked = False
      DoubleBuffered = True
      ParseInput = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 7
    end
  end
  object dsrNegociacoes: TDataSource
    DataSet = FDQNegociacoes
    OnDataChange = dsrNegociacoesDataChange
    Left = 408
    Top = 224
  end
  object FDQNegociacoes: TFDQuery
    OnCalcFields = FDQNegociacoesCalcFields
    Connection = DM.con
    SQL.Strings = (
      'select'
      '*'
      'from NEGOCIACOES'
      'WHERE DATA_CADASTRO BETWEEN :DATAINI AND :DATAFIM')
    Left = 408
    Top = 272
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
    object FDQNegociacoesID: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQNegociacoesSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
      OnGetText = FDQNegociacoesSTATUSGetText
      FixedChar = True
      Size = 3
    end
    object FDQNegociacoesDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 120
    end
    object FDQNegociacoesID_PRODUTOR: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'd. Produtor'
      FieldName = 'ID_PRODUTOR'
      Origin = 'ID_PRODUTOR'
      Required = True
    end
    object FDQNegociacoesCL_PRODUTOR: TStringField
      DisplayLabel = 'Produtor'
      FieldKind = fkCalculated
      FieldName = 'CL_PRODUTOR'
      Size = 120
      Calculated = True
    end
    object FDQNegociacoesID_DISTRIBUIDOR: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'd. Distribuidor'
      FieldName = 'ID_DISTRIBUIDOR'
      Origin = 'ID_DISTRIBUIDOR'
      Required = True
    end
    object FDQNegociacoesCL_DISTRIBUIDOR: TStringField
      DisplayLabel = 'Distribuidor'
      FieldKind = fkCalculated
      FieldName = 'CL_DISTRIBUIDOR'
      Size = 120
      Calculated = True
    end
    object FDQNegociacoesVALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 7
    end
    object FDQNegociacoesDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
      Required = True
    end
    object FDQNegociacoesDATA_APROVACAO: TDateField
      FieldName = 'DATA_APROVACAO'
      Origin = 'DATA_APROVACAO'
    end
    object FDQNegociacoesDATA_CONCLUSAO: TDateField
      FieldName = 'DATA_CONCLUSAO'
      Origin = 'DATA_CONCLUSAO'
    end
    object FDQNegociacoesDATA_CANCELAMENTO: TDateField
      FieldName = 'DATA_CANCELAMENTO'
      Origin = 'DATA_CANCELAMENTO'
    end
  end
  object frx: TfrxReport
    Version = '6.7.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44629.836401828700000000
    ReportOptions.LastChange = 44654.983098194450000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   if <Line> mod 2 = 0 then'
      '    MCor.Color:= $00EAEAEA'
      '  else'
      '    MCor.Color:= clNone;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnStartReport = 'frxOnStartReport'
    Left = 712
    Top = 264
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe uI'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      VGuides.Strings = (
        '672,75634'
        '377,953'
        '83,14966')
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 113.385900000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        Child = frx.Child1
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Width = 457.323130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Gerado em [Date] as [Time]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Top = 30.236240000000000000
          Width = 1084.725110000000000000
          Height = 41.574830000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Negocia'#231#245'es')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Top = 83.149660000000000000
          Width = 1084.725110000000000000
          Height = 30.236240000000000000
          AllowHTMLTags = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Filtros]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 899.528140000000100000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'g. [Page#] de [TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Top = 253.228510000000000000
        Width = 1084.725110000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 275.905690000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object mCor: TfrxMemoView
          Align = baClient
          AllowVectorExport = True
          Width = 1084.725110000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          ParentFont = False
        end
        object frxDBDataset1PROD_CODIGO: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 1.779530000000000000
          Width = 81.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[FormatFloat('#39'000000'#39',<frxDBDataset1."ID">)]')
          ParentFont = False
        end
        object frxDBDataset1PROD_DESCRICAO: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 83.149660000000000000
          Width = 294.803340000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            
              '[FormatFloat('#39'000'#39',<frxDBDataset1."ID_PRODUTOR">)] - [frxDBDatas' +
              'et1."CL_PRODUTOR"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo56: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 377.953000000000000000
          Width = 294.803340000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            
              '[FormatFloat('#39'000'#39',<frxDBDataset1."ID_DISTRIBUIDOR">)] - [frxDBD' +
              'ataset1."CL_DISTRIBUIDOR"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo57: TfrxMemoView
          AllowVectorExport = True
          Left = 990.236860000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALOR"]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          AllowVectorExport = True
          Left = 672.756340000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = 'mm.dd.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."DATA_CADASTRO"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          AllowVectorExport = True
          Left = 752.126470000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'DATA_APROVACAO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = 'mm.dd.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."DATA_APROVACAO"]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          AllowVectorExport = True
          Left = 831.496600000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'DATA_CONCLUSAO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = 'mm.dd.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."DATA_CONCLUSAO"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          AllowVectorExport = True
          Left = 910.866730000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'DATA_CANCELAMENTO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = 'mm.dd.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."DATA_CANCELAMENTO"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 313.700990000000000000
        Width = 1084.725110000000000000
        object Memo16: TfrxMemoView
          Align = baClient
          AllowVectorExport = True
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
          AllowHTMLTags = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Total de Produtos Listados: <b>[COUNT(MasterData1)]</b>')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 396.850650000000000000
        Width = 1084.725110000000000000
        object Memo13: TfrxMemoView
          Align = baClient
          AllowVectorExport = True
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Aliare'#174)
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 918.425790000000100000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe uI'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'g. [Page#] de [TotalPages#]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 37.795275590000000000
        Top = 154.960730000000000000
        Width = 1084.725110000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 1.779530000000000000
          Top = 11.220470000000000000
          Width = 81.370130000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'digo'
            'Contrato')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Top = 11.220470000000010000
          Width = 294.803340000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Produtor Rural')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 377.953000000000000000
          Top = 11.220470000000010000
          Width = 294.803340000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Distribuidor')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          AllowVectorExport = True
          Left = 672.756340000000000000
          Top = 11.338590000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data'
            'Cadastro')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          AllowVectorExport = True
          Left = 752.126470000000000000
          Top = 11.338590000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data'
            'Aprova'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          AllowVectorExport = True
          Left = 831.496600000000000000
          Top = 11.338590000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data'
            'Conclus'#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          AllowVectorExport = True
          Left = 910.866730000000000000
          Top = 11.338590000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data'
            'Cancelamento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          AllowVectorExport = True
          Left = 990.236860000000000000
          Top = 11.338590000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe uI'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor'
            'Contrato')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'STATUS=STATUS'
      'DESCRICAO=DESCRICAO'
      'ID_PRODUTOR=ID_PRODUTOR'
      'CL_PRODUTOR=CL_PRODUTOR'
      'ID_DISTRIBUIDOR=ID_DISTRIBUIDOR'
      'CL_DISTRIBUIDOR=CL_DISTRIBUIDOR'
      'VALOR=VALOR'
      'DATA_CADASTRO=DATA_CADASTRO'
      'DATA_APROVACAO=DATA_APROVACAO'
      'DATA_CONCLUSAO=DATA_CONCLUSAO'
      'DATA_CANCELAMENTO=DATA_CANCELAMENTO')
    DataSet = FDQNegociacoes
    BCDToCurrency = False
    Left = 712
    Top = 208
  end
  object frxDOCXExport1: TfrxDOCXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PictureType = gpPNG
    Left = 824
    Top = 336
  end
  object frxXLSXExport1: TfrxXLSXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ChunkSize = 0
    OpenAfterExport = False
    PictureType = gpPNG
    Left = 824
    Top = 278
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 824
    Top = 208
  end
end
