object dmProduto: TdmProduto
  OldCreateOrder = False
  Height = 262
  Width = 581
  object fdqyProduto: TFDQuery
    AfterPost = fdqyProdutoAfterPost
    OnNewRecord = fdqyProdutoNewRecord
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    SQL.Strings = (
      'SELECT * '
      'FROM PRODUTO'
      'ORDER BY PR_NOME')
    Left = 40
    Top = 16
    object fdqyProdutoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqyProdutoPR_NOME: TStringField
      FieldName = 'PR_NOME'
      Origin = 'PR_NOME'
      Size = 100
    end
    object fdqyProdutoPR_PRECOVENDA: TSingleField
      FieldName = 'PR_PRECOVENDA'
      Origin = 'PR_PRECOVENDA'
      currency = True
    end
    object fdqyProdutoPR_STATUS: TSmallintField
      FieldName = 'PR_STATUS'
      Origin = 'PR_STATUS'
    end
    object fdqyProdutoUSUARIOCAD: TIntegerField
      FieldName = 'USUARIOCAD'
      Origin = 'USUARIOCAD'
    end
    object fdqyProdutoDATAHORACAD: TSQLTimeStampField
      FieldName = 'DATAHORACAD'
      Origin = 'DATAHORACAD'
    end
    object fdqyProdutoUSUARIOALTER: TIntegerField
      FieldName = 'USUARIOALTER'
      Origin = 'USUARIOALTER'
    end
    object fdqyProdutoDATAHORAALTER: TSQLTimeStampField
      FieldName = 'DATAHORAALTER'
      Origin = 'DATAHORAALTER'
    end
  end
end
