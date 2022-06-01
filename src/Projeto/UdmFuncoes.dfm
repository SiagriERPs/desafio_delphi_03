object dmFuncoes: TdmFuncoes
  OldCreateOrder = False
  Height = 206
  Width = 648
  object fdqyNumeracao: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    UpdateOptions.KeyFields = 'NMRNOMETABELA;SISTEMAID'
    SQL.Strings = (
      'SELECT *'
      'FROM NUMERACAO '
      'WHERE SISTEMAID =:SISTEMAID AND '
      '      NMRNOMETABELA =:NMRNOMETABELA')
    Left = 56
    Top = 32
    ParamData = <
      item
        Name = 'SISTEMAID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NMRNOMETABELA'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object fdqyPesquisa: TFDQuery
    Connection = dmConexao.FDConnection
    Transaction = dmConexao.FDTransaction
    Left = 160
    Top = 30
  end
end
