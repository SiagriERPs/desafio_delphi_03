object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 322
  Width = 535
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Controle de Negociacao\desafio_delphi_03\data\NEGOCI' +
        'ACAO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 24
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 256
    Top = 144
  end
  object qryProdutor: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from produtor')
    Left = 80
    Top = 88
    object qryProdutorCODIGO: TSmallintField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryProdutorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryProdutorCPFCNPJ: TStringField
      FieldName = 'CPFCNPJ'
      Origin = 'CPFCNPJ'
    end
  end
  object qryProduto: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from produto')
    Left = 72
    Top = 200
    object qryProdutoCODIGO: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryProdutoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryProdutoVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
    end
  end
  object qryDistribuidor: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from distribuidor')
    Left = 80
    Top = 144
    object qryDistribuidorCODIGO: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
    object qryDistribuidorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryDistribuidorCPFCNPJ: TStringField
      FieldName = 'CPFCNPJ'
      Origin = 'CPFCNPJ'
    end
  end
  object qryNegociacao: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from negociacao')
    Left = 88
    Top = 248
    object qryNegociacaoCODIGO: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryNegociacaoPRODUTOR: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'PRODUTOR'
      Origin = 'PRODUTOR'
    end
    object qryNegociacaoDISTRIBUIDOR: TSmallintField
      FieldName = 'DISTRIBUIDOR'
      Origin = 'DISTRIBUIDOR'
    end
    object qryNegociacaoVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
    end
    object qryNegociacaoDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qryNegociacaoSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
  end
  object qryNegociacaoDetalhe: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * '
      'from negociacao_detalhe'
      'where negociacao = :pNegociacao')
    Left = 248
    Top = 16
    ParamData = <
      item
        Name = 'PNEGOCIACAO'
        ParamType = ptInput
      end>
    object qryNegociacaoDetalheCODIGO: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryNegociacaoDetalheNEGOCIACAO: TSmallintField
      FieldName = 'NEGOCIACAO'
      Origin = 'NEGOCIACAO'
    end
    object qryNegociacaoDetalhePRODUTO: TSmallintField
      FieldName = 'PRODUTO'
      Origin = 'PRODUTO'
    end
  end
  object dtsProdutor: TDataSource
    DataSet = qryProdutor
    Left = 168
    Top = 104
  end
  object dtsProduto: TDataSource
    DataSet = qryProduto
    Left = 152
    Top = 200
  end
  object dtsDistribuidor: TDataSource
    DataSet = qryDistribuidor
    Left = 160
    Top = 152
  end
  object dtsNegociacao: TDataSource
    DataSet = qryNegociacao
    Left = 168
    Top = 248
  end
  object qryConsultaProduto: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from produto'
      '')
    Left = 376
    Top = 112
    object qryConsultaProdutoCODIGO: TSmallintField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaProdutoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryConsultaProdutoVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      currency = True
    end
  end
  object dtsConsultaProduto: TDataSource
    DataSet = qryConsultaProduto
    Left = 384
    Top = 176
  end
  object qryConsultaNegociacao: TFDQuery
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'IDXPRODUTOR'
        Fields = 'NOMEPRODUTOR'
        FilterOptions = [ekPartial]
      end
      item
        Active = True
        Name = 'IDXDISTRIBUIDOR'
        Fields = 'NOMEDISTRIBUIDOR'
        FilterOptions = [ekPartial]
      end>
    IndexName = 'IDXPRODUTOR'
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      
        'select n.codigo, p.codigo as Produtor, p.nome as NomeProdutor, d' +
        '.codigo as Distribuidor, d.nome as NomeDistribuidor, '
      '  case '
      '    when n.status = 0 then '#39'Pendente'#39
      '    when n.status = 1 then '#39'Aprovada'#39
      '    when n.status = 2 then '#39'Concluir'#39
      '    when n.status = 3 then '#39'Cancelada'#39
      '  end as NomeStatus,'
      '  n.status,'
      '  n.data,'
      '  n.valor'
      'from negociacao n'
      'inner join produtor p on (p.codigo = n.produtor)'
      'inner join distribuidor d on (d.codigo = n.distribuidor)')
    Left = 264
    Top = 200
    object qryConsultaNegociacaoCODIGO: TSmallintField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object qryConsultaNegociacaoPRODUTOR: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTOR'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
    object qryConsultaNegociacaoNOMEPRODUTOR: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produtor'
      DisplayWidth = 40
      FieldName = 'NOMEPRODUTOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryConsultaNegociacaoDISTRIBUIDOR: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'DISTRIBUIDOR'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
    object qryConsultaNegociacaoNOMEDISTRIBUIDOR: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Distribuidor'
      DisplayWidth = 40
      FieldName = 'NOMEDISTRIBUIDOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryConsultaNegociacaoSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Visible = False
    end
    object qryConsultaNegociacaoDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qryConsultaNegociacaoVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      currency = True
    end
    object qryConsultaNegociacaoNOMESTATUS: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Status'
      FieldName = 'NOMESTATUS'
      Origin = 'NOMESTATUS'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 9
    end
  end
  object dtsConsultaNegociacao: TDataSource
    DataSet = qryConsultaNegociacao
    Left = 336
    Top = 248
  end
  object qryCredito: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from credito')
    Left = 280
    Top = 72
    object qryCreditoCODIGO: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object qryCreditoPRODUTOR: TSmallintField
      FieldName = 'PRODUTOR'
      Origin = 'PRODUTOR'
      Visible = False
    end
    object qryCreditoDISTRIBUIDOR: TSmallintField
      FieldName = 'DISTRIBUIDOR'
      Origin = 'DISTRIBUIDOR'
      Visible = False
    end
    object qryCreditoNOMEDISTRIBUIDOR: TStringField
      DisplayLabel = 'Distribuidor'
      DisplayWidth = 40
      FieldName = 'NOMEDISTRIBUIDOR'
      Origin = 'NOMEDISTRIBUIDOR'
      Size = 60
    end
    object qryCreditoVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      DisplayFormat = '#,##0.00'
      currency = True
    end
  end
  object dtsCredito: TDataSource
    DataSet = qryCredito
    Left = 368
    Top = 72
  end
  object qryConsultaCredito: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select sum(coalesce(valor,0)) as valor'
      'from credito'
      'where produtor = :pProdutor'
      'and distribuidor = :pDistribuidor')
    Left = 424
    Top = 32
    ParamData = <
      item
        Name = 'PPRODUTOR'
        DataType = ftSmallint
        ParamType = ptInput
      end
      item
        Name = 'PDISTRIBUIDOR'
        DataType = ftSmallint
        ParamType = ptInput
      end>
    object qryConsultaCreditoVALOR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      currency = True
    end
  end
  object qryConsultaCreditoUsado: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select sum(COALESCE(valor,0)) as valor'
      'from negociacao'
      'where produtor = :pProdutor'
      'and distribuidor = :pDistribuidor')
    Left = 448
    Top = 176
    ParamData = <
      item
        Name = 'PPRODUTOR'
        DataType = ftSmallint
        ParamType = ptInput
      end
      item
        Name = 'PDISTRIBUIDOR'
        DataType = ftSmallint
        ParamType = ptInput
      end>
    object FloatField1: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      currency = True
    end
  end
end
