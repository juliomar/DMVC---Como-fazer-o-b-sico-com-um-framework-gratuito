object DataModule3: TDataModule3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\juliomar\AppData\Roaming\DBeaverData\workspace' +
        '6\.metadata\sample-database-sqlite-1\Chinook.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object ACBrIBPTax1: TACBrIBPTax
    ProxyPort = '8080'
    Left = 136
    Top = 48
  end
end
