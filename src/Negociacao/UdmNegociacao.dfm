object dmNegociacao: TdmNegociacao
  OldCreateOrder = False
  Height = 388
  Width = 768
  object fdqyNegociacao: TFDQuery
    BeforePost = fdqyNegociacaoBeforePost
    OnNewRecord = fdqyNegociacaoNewRecord
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT *'
      'FROM NEGOCIACAO')
    Left = 56
    Top = 40
  end
  object dsNegociacao: TDataSource
    DataSet = fdqyNegociacao
    Left = 152
    Top = 40
  end
  object dsItens_Negociacao: TDataSource
    DataSet = fdqyItens_Negociacao
    Left = 384
    Top = 40
  end
  object fdqyItens_Negociacao: TFDQuery
    BeforePost = fdqyItens_NegociacaoBeforePost
    AfterPost = fdqyItens_NegociacaoAfterPost
    OnNewRecord = fdqyItens_NegociacaoNewRecord
    IndexFieldNames = 'NEGOCIACAO_ID'
    AggregatesActive = True
    MasterSource = dsNegociacao
    MasterFields = 'NEGOCIACAO_ID'
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    FetchOptions.AssignedValues = [evRecordCountMode, evDetailCascade]
    FetchOptions.RecordCountMode = cmFetched
    FetchOptions.DetailCascade = True
    SQL.Strings = (
      'SELECT I.NEGOCIACAO_ID, '
      '       I.PRODUTO_ID,'
      '       p.PR_NOME, '
      '       p.PR_PRECOVENDA,'
      '       I.IN_VALOR, '
      '       I.PRODUTOR_ID, '
      '       I.DISTRIBUIDOR_ID'
      
        'FROM ITENS_NEGOCIACAO I INNER JOIN PRODUTO p ON (p.PRODUTO_ID = ' +
        'I.PRODUTO_ID) '
      'ORDER BY p.PR_NOME')
    Left = 264
    Top = 40
    object fdqyItens_NegociacaoNEGOCIACAO_ID: TIntegerField
      FieldName = 'NEGOCIACAO_ID'
      Origin = 'NEGOCIACAO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyItens_NegociacaoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyItens_NegociacaoPR_NOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PR_NOME'
      Origin = 'PR_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object fdqyItens_NegociacaoPR_PRECOVENDA: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'PR_PRECOVENDA'
      Origin = 'PR_PRECOVENDA'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqyItens_NegociacaoIN_VALOR: TSingleField
      FieldName = 'IN_VALOR'
      Origin = 'IN_VALOR'
    end
    object fdqyItens_NegociacaoPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyItens_NegociacaoDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyItens_NegociacaoValor_Itens: TAggregateField
      FieldName = 'Valor_Itens'
      ProviderFlags = [pfInUpdate]
      currency = True
      DisplayName = ''
      Expression = 'SUM(IN_VALOR)'
    end
  end
  object fdqyListaCodificacao: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'Select CODIFICACAOID, CDFDESCRICAO'
      'FROM CODIFICACAO '
      'WHERE CODIFICACAOID BETWEEN :INTER01 AND :INTER02'
      'ORDER BY CDFDESCRICAO')
    Left = 56
    Top = 120
    ParamData = <
      item
        Name = 'INTER01'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'INTER02'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqyListaDistribuidor: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT d.D_NOME AS Distribuidor, '
      '       d.D_CNPJ AS CNPJ, '
      '       d.DISTRIBUIDOR_ID AS Codigo_Distribuidor , '
      '       pd.PD_LIMITECREDITO AS Limite_Credito, '
      '       pd.PD_VALOR_UTILIZADO AS Valor_Utilizado,'
      
        '       (pd.PD_LIMITECREDITO - pd.PD_VALOR_UTILIZADO) AS Valor_Cr' +
        'edito'
      
        'FROM PROD_DISTRIBUIDOR pd INNER JOIN PRODUTOR p ON  (p.PRODUTOR_' +
        'ID  = pd.PRODUTOR_ID) '
      
        '                          INNER JOIN DISTRIBUIDOR d ON (pd.DISTR' +
        'IBUIDOR_ID = d.DISTRIBUIDOR_ID)'
      'WHERE '
      '       pd.PRODUTOR_ID  = :PRODUTOR_ID')
    Left = 288
    Top = 120
    ParamData = <
      item
        Name = 'PRODUTOR_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqyListaDistribuidorDISTRIBUIDOR: TStringField
      FieldName = 'DISTRIBUIDOR'
      Origin = 'DISTRIBUIDOR'
      Size = 100
    end
    object fdqyListaDistribuidorCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object fdqyListaDistribuidorCODIGO_DISTRIBUIDOR: TIntegerField
      FieldName = 'CODIGO_DISTRIBUIDOR'
      Origin = 'CODIGO_DISTRIBUIDOR'
      Required = True
    end
    object fdqyListaDistribuidorLIMITE_CREDITO: TSingleField
      FieldName = 'LIMITE_CREDITO'
      Origin = 'LIMITE_CREDITO'
      currency = True
    end
    object fdqyListaDistribuidorVALOR_UTILIZADO: TSingleField
      FieldName = 'VALOR_UTILIZADO'
      Origin = 'VALOR_UTILIZADO'
      currency = True
    end
    object fdqyListaDistribuidorVALOR_CREDITO: TFloatField
      FieldName = 'VALOR_CREDITO'
      Origin = 'VALOR_CREDITO'
      currency = True
    end
  end
  object fdqyListaProdutor: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT PRODUTOR_ID, '
      '             P_NOME'
      'FROM PRODUTOR'
      'WHERE P_STATUS = 1'
      'ORDER BY P_NOME')
    Left = 176
    Top = 120
  end
  object fdqyListaProduto: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT PRODUTO_ID, '
      '             PR_NOME, '
      '             PR_PRECOVENDA'
      'FROM PRODUTO'
      'ORDER BY '
      '     PR_NOME')
    Left = 48
    Top = 192
    object fdqyListaProdutoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyListaProdutoPR_NOME: TStringField
      FieldName = 'PR_NOME'
      Origin = 'PR_NOME'
      Size = 100
    end
    object fdqyListaProdutoPR_PRECOVENDA: TSingleField
      FieldName = 'PR_PRECOVENDA'
      Origin = 'PR_PRECOVENDA'
      currency = True
    end
  end
  object fdqyAtualizaNegociacao: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT NEGOCIACAO_ID, '
      '       DISTRIBUIDOR_ID,'
      '       PRODUTOR_ID, '
      '       N_STATUS, '
      '       N_DATA_APROVACAO, '
      '       N_DATA_CANCELAMENTO, '
      '       N_DATA_CONCLUSAO'
      'FROM '
      '      NEGOCIACAO '
      'WHERE '
      '      NEGOCIACAO_ID =:NEGOCIACAOID    ')
    Left = 160
    Top = 192
    ParamData = <
      item
        Name = 'NEGOCIACAOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqyAtualiza_Credito_Liberado: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      
        'UPDATE PROD_DISTRIBUIDOR SET PD_VALOR_UTILIZADO = (PD_VALOR_UTIL' +
        'IZADO + :VALOR) WHERE PROD_DISTRIB_ID =:PROD_DISTRIB_ID')
    Left = 304
    Top = 192
    ParamData = <
      item
        Name = 'VALOR'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PROD_DISTRIB_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object ppReport: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'ListaContratos'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 210000
    PrinterSetup.mmPaperWidth = 297000
    PrinterSetup.PaperSize = 9
    Template.FileName = 
      'L:\Entrevistas - Testes - Emprego\SiagriERPs\desafio_delphi_03\d' +
      'esafio_delphi_03\src\Relat'#243'rios\Rel_ListaNegociacao.rtm'
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPercentage
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    Left = 56
    Top = 272
    Version = '21.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 22754
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        Border.mmPadding = 0
        Caption = 'Contratos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4763
        mmLeft = 3704
        mmTop = 2381
        mmWidth = 26458
        BandType = 0
        LayerName = Foreground
      end
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable1'
        Border.mmPadding = 0
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 169334
        mmTop = 3440
        mmWidth = 26194
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        Border.mmPadding = 0
        Caption = 'Nro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3968
        mmLeft = 5027
        mmTop = 17992
        mmWidth = 9525
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label3'
        Border.mmPadding = 0
        Caption = 'Data Cadastro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3968
        mmLeft = 22225
        mmTop = 17992
        mmWidth = 21431
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label4'
        Border.mmPadding = 0
        Caption = 'Produtor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 46038
        mmTop = 17463
        mmWidth = 13229
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label5'
        Border.mmPadding = 0
        Caption = 'Distribuidor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 83344
        mmTop = 17463
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label6'
        Border.mmPadding = 0
        Caption = 'Valor Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 130175
        mmTop = 17198
        mmWidth = 24606
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label7'
        Border.mmPadding = 0
        Caption = 'Situa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 157957
        mmTop = 17463
        mmWidth = 13229
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label9'
        Border.mmPadding = 0
        Caption = 'Data Conclus'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 216959
        mmTop = 17463
        mmWidth = 23548
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label10'
        Border.mmPadding = 0
        Caption = 'Data Aprova'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 184944
        mmTop = 17463
        mmWidth = 23813
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label11'
        Border.mmPadding = 0
        Caption = 'Data Cancelamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 246328
        mmTop = 17463
        mmWidth = 29369
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        Border.mmPadding = 0
        DataField = 'NEGOCIACAO_ID'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 5027
        mmTop = 1058
        mmWidth = 13758
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        Border.mmPadding = 0
        DataField = 'DATACAD'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 22225
        mmTop = 794
        mmWidth = 21431
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'P_NOME'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 45773
        mmTop = 794
        mmWidth = 34660
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'D_NOME'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 83079
        mmTop = 265
        mmWidth = 37571
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        Border.mmPadding = 0
        DataField = 'N_VALORTOTAL'
        DataPipeline = ppDBPipeline
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 124090
        mmTop = 265
        mmWidth = 30692
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText6'
        Border.mmPadding = 0
        DataField = 'SITUACAO'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 157957
        mmTop = 529
        mmWidth = 24871
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText7'
        Border.mmPadding = 0
        DataField = 'N_DATA_APROVACAO'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 185473
        mmTop = 265
        mmWidth = 23283
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'N_DATA_APROVACAO'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 216959
        mmTop = 265
        mmWidth = 23283
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'N_DATA_APROVACAO'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 246328
        mmTop = 794
        mmWidth = 23283
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable2'
        Border.mmPadding = 0
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3969
        mmLeft = 241830
        mmTop = 6085
        mmWidth = 20108
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppDBCalc1: TppDBCalc
        DesignLayer = ppDesignLayer1
        UserName = 'DBCalc1'
        Border.mmPadding = 0
        DataField = 'N_VALORTOTAL'
        DataPipeline = ppDBPipeline
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4498
        mmLeft = 120121
        mmTop = 7144
        mmWidth = 34660
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label8'
        Border.mmPadding = 0
        Caption = 'TOTAL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 96838
        mmTop = 7673
        mmWidth = 19844
        BandType = 7
        LayerName = Foreground
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDBPipeline: TppDBPipeline
    DataSource = dsRelatorio
    AutoCreateFields = False
    UserName = 'DBPipeline'
    Left = 144
    Top = 272
    object ppDBPipelineppField1: TppField
      FieldAlias = 'SITUACAO'
      FieldName = 'SITUACAO'
      FieldLength = 9
      DisplayWidth = 9
      Position = 0
    end
    object ppDBPipelineppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'NEGOCIACAO_ID'
      FieldName = 'NEGOCIACAO_ID'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object ppDBPipelineppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'PRODUTOR_ID'
      FieldName = 'PRODUTOR_ID'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object ppDBPipelineppField4: TppField
      FieldAlias = 'P_NOME'
      FieldName = 'P_NOME'
      FieldLength = 100
      DisplayWidth = 100
      Position = 3
    end
    object ppDBPipelineppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'DISTRIBUIDOR_ID'
      FieldName = 'DISTRIBUIDOR_ID'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 4
    end
    object ppDBPipelineppField6: TppField
      FieldAlias = 'D_NOME'
      FieldName = 'D_NOME'
      FieldLength = 100
      DisplayWidth = 100
      Position = 5
    end
    object ppDBPipelineppField7: TppField
      FieldAlias = 'N_VALORTOTAL'
      FieldName = 'N_VALORTOTAL'
      FieldLength = 0
      DataType = dtSingle
      DisplayWidth = 10
      Position = 6
    end
    object ppDBPipelineppField8: TppField
      FieldAlias = 'N_DATA_APROVACAO'
      FieldName = 'N_DATA_APROVACAO'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 7
    end
    object ppDBPipelineppField9: TppField
      FieldAlias = 'N_DATA_CONCLUSAO'
      FieldName = 'N_DATA_CONCLUSAO'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 8
    end
    object ppDBPipelineppField10: TppField
      FieldAlias = 'N_DATA_CANCELAMENTO'
      FieldName = 'N_DATA_CANCELAMENTO'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 9
    end
    object ppDBPipelineppField11: TppField
      FieldAlias = 'DATAHORACAD'
      FieldName = 'DATAHORACAD'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 34
      Position = 10
    end
  end
  object dsRelatorio: TDataSource
    DataSet = fdqyRelatorio
    Left = 232
    Top = 272
  end
  object fdqyRelatorio: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT '
      '     (CASE WHEN n.N_STATUS = 2 THEN '#39'PENDENTE'#39
      '           WHEN n.N_STATUS = 3 THEN '#39'APROVADA'#39
      '           WHEN n.N_STATUS = 4 THEN '#39'CONCLU'#205'DA'#39
      '           WHEN n.N_STATUS = 5 THEN '#39'CANCELADA'#39
      '     END) AS SITUACAO, '
      '     n.NEGOCIACAO_ID, '
      '     n.PRODUTOR_ID, '
      '     p.P_NOME, '
      '     n.DISTRIBUIDOR_ID, '
      '     d.D_NOME, '
      '     n.N_VALORTOTAL, '
      '     n.N_DATA_APROVACAO, '
      '     n.N_DATA_CONCLUSAO, '
      '     n.N_DATA_CANCELAMENTO, '
      '     n.DATACAD'
      '     '
      
        ' FROM NEGOCIACAO n INNER JOIN PRODUTOR p ON (p.PRODUTOR_ID = n.P' +
        'RODUTOR_ID)'
      
        '                   INNER JOIN DISTRIBUIDOR d ON (d.DISTRIBUIDOR_' +
        'ID = n.DISTRIBUIDOR_ID)')
    Left = 320
    Top = 270
  end
end
