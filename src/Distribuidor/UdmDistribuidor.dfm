object dmDistribuidor: TdmDistribuidor
  OldCreateOrder = False
  Height = 268
  Width = 429
  object fdqyDistribuidor: TFDQuery
    OnNewRecord = fdqyDistribuidorNewRecord
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.UpdateTableName = 'DISTRIBUIDOR'
    UpdateOptions.KeyFields = 'DISTRIBUIDOR_ID'
    SQL.Strings = (
      'SELECT *'
      'FROM DISTRIBUIDOR'
      'ORDER BY D_NOME ')
    Left = 93
    Top = 8
  end
end
