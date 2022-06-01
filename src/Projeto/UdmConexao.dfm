object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 300
  Width = 694
  object FDConnection: TFDConnection
    ConnectionName = 'FB'
    Params.Strings = (
      
        'Database=L:\Entrevistas - Testes - Emprego\SiagriERPs\desafio_de' +
        'lphi_03\desafio_delphi_03\data\CONTROLE_NEGOCIACAO.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 40
    Top = 32
  end
  object FDTransaction: TFDTransaction
    Options.Isolation = xiReadCommitted
    Connection = FDConnection
    Left = 128
    Top = 32
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_1\bin\fbclient.dll'
    Left = 232
    Top = 32
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 336
    Top = 32
  end
end
