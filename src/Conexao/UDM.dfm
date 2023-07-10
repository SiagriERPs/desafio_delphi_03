object DM: TDM
  Height = 190
  Width = 276
  object Conexão: TFDConnection
    Params.Strings = (
      
        'Database=C:\Delphi\desafio_delphi_03-main\data\CONTROLE-NEGOCIAC' +
        'AO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    Left = 72
    Top = 40
  end
  object QueryAux: TFDQuery
    Connection = Conexão
    Left = 168
    Top = 104
  end
end
