object dmProdutor: TdmProdutor
  OldCreateOrder = False
  Height = 376
  Width = 633
  object fdqyProdutor: TFDQuery
    BeforePost = fdqyProdutorBeforePost
    OnNewRecord = fdqyProdutorNewRecord
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT *'
      'FROM PRODUTOR'
      ''
      '')
    Left = 48
    Top = 24
    object fdqyProdutorPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyProdutorP_NOME: TStringField
      FieldName = 'P_NOME'
      Origin = 'P_NOME'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object fdqyProdutorP_STATUS: TSmallintField
      FieldName = 'P_STATUS'
      Origin = 'P_STATUS'
      ProviderFlags = [pfInUpdate]
    end
    object fdqyProdutorUSUARIO_CAD: TIntegerField
      FieldName = 'USUARIO_CAD'
      Origin = 'USUARIO_CAD'
      ProviderFlags = [pfInUpdate]
    end
    object fdqyProdutorDATAHORA_CAD: TSQLTimeStampField
      FieldName = 'DATAHORA_CAD'
      Origin = 'DATAHORA_CAD'
      ProviderFlags = [pfInUpdate]
    end
    object fdqyProdutorUSUARIO_ALTER: TIntegerField
      FieldName = 'USUARIO_ALTER'
      Origin = 'USUARIO_ALTER'
      ProviderFlags = [pfInUpdate]
    end
    object fdqyProdutorDATAHORA_ALTER: TSQLTimeStampField
      FieldName = 'DATAHORA_ALTER'
      Origin = 'DATAHORA_ALTER'
      ProviderFlags = [pfInUpdate]
    end
    object fdqyProdutorP_TIPO: TStringField
      FieldName = 'P_TIPO'
      Origin = 'P_TIPO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object fdqyProdutorP_INSCRICAOFISCAL: TStringField
      FieldName = 'P_INSCRICAOFISCAL'
      Origin = 'P_INSCRICAOFISCAL'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
  end
  object fdqyProd_Distribuidor: TFDQuery
    AfterPost = fdqyProd_DistribuidorAfterPost
    OnNewRecord = fdqyProd_DistribuidorNewRecord
    IndexFieldNames = 'PRODUTOR_ID'
    MasterSource = dsProdutor
    MasterFields = 'PRODUTOR_ID'
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    FetchOptions.AssignedValues = [evDetailCascade]
    FetchOptions.DetailCascade = True
    SQL.Strings = (
      'SELECT PD.*, '
      '       D.D_NOME, '
      '       D.D_CNPJ '
      'FROM '
      
        '  PROD_DISTRIBUIDOR PD INNER JOIN DISTRIBUIDOR D ON (D.DISTRIBUI' +
        'DOR_ID = PD.DISTRIBUIDOR_ID)'
      'ORDER BY D.D_NOME'
      '')
    Left = 416
    Top = 24
    object fdqyProd_DistribuidorPROD_DISTRIB_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PROD_DISTRIB_ID'
      Origin = 'PROD_DISTRIB_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyProd_DistribuidorPRODUTOR_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object fdqyProd_DistribuidorDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyProd_DistribuidorPD_LIMITECREDITO: TSingleField
      FieldName = 'PD_LIMITECREDITO'
      Origin = 'PD_LIMITECREDITO'
    end
    object fdqyProd_DistribuidorPD_STATUS: TSmallintField
      FieldName = 'PD_STATUS'
      Origin = 'PD_STATUS'
    end
    object fdqyProd_DistribuidorUSUARIOCAD: TIntegerField
      FieldName = 'USUARIOCAD'
      Origin = 'USUARIOCAD'
    end
    object fdqyProd_DistribuidorDATAHORACAD: TSQLTimeStampField
      FieldName = 'DATAHORACAD'
      Origin = 'DATAHORACAD'
    end
    object fdqyProd_DistribuidorUSUARIOALTER: TIntegerField
      FieldName = 'USUARIOALTER'
      Origin = 'USUARIOALTER'
    end
    object fdqyProd_DistribuidorDATAHORAALTER: TSQLTimeStampField
      FieldName = 'DATAHORAALTER'
      Origin = 'DATAHORAALTER'
    end
    object fdqyProd_DistribuidorD_NOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'D_NOME'
      Origin = 'D_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object fdqyProd_DistribuidorD_CNPJ: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'D_CNPJ'
      Origin = 'D_CNPJ'
      ProviderFlags = []
      ReadOnly = True
      Size = 14
    end
  end
  object ds_Prod_Distribuidor: TDataSource
    DataSet = fdqyProd_Distribuidor
    Left = 296
    Top = 24
  end
  object dsProdutor: TDataSource
    DataSet = fdqyProdutor
    Left = 144
    Top = 24
  end
  object fdqyListaDistribuidor: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT DISTRIBUIDOR_ID, '
      '             D_NOME, '
      '             D_CNPJ,'
      '             D_STATUS'
      'FROM DISTRIBUIDOR '
      'ORDER BY D_NOME')
    Left = 56
    Top = 96
  end
end
