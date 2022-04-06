object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 461
  Width = 718
  object conexao: TFDConnection
    Params.Strings = (
      'Database=C:\Delphi\desafio_delphi_03\data\BD.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object driver: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_1\bin\fbclient.dll'
    Left = 112
    Top = 24
  end
  object cursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 192
    Top = 24
  end
  object script: TFDScript
    SQLScripts = <>
    Connection = conexao
    Params = <>
    Macros = <>
    Left = 272
    Top = 24
  end
end
