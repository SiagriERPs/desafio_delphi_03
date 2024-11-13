object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 145
  Width = 271
  object FDConnection: TFDConnection
    Params.Strings = (
      'Password=masterkey'
      'User_Name=sysdba'
      
        'Database=D:\Portifolio\Delphi\desafio_delphi_03\data\DESAFIOALIA' +
        'RE.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 144
    Top = 32
  end
end
