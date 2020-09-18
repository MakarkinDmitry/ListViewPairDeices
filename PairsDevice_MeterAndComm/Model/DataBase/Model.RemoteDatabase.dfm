object CesarDataBaseRiM: TCesarDataBaseRiM
  OldCreateOrder = False
  Height = 383
  Width = 998
  object SQLConnectionCesar: TSQLConnection
    ConnectionName = 'MSSQL_cesar_connection'
    DriverName = 'MSSQL'
    Params.Strings = (
      'DriverName=MSSQL'
      'SchemaOverride=%.dbo'
      'DriverUnit=Data.DBXMSSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver250.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver250.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=24.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxmss.dll'
      'VendorLib=sqlncli10.dll'
      'VendorLibWin64=sqlncli10.dll'
      'HostName=cesar'
      'Database=electrometer'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=True'
      'PrepareSQL=True'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=True'
      'Prepare SQL=False')
    Connected = True
    Left = 48
    Top = 328
  end
  object SQLqSelOperationDateBetveen: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'FromDate'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'ToDate'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM operation'
      
        'WHERE (date_operation >=(:FromDate)) AND (date_operation <=(:ToD' +
        'ate))'
      'AND type_id = 35')
    SQLConnection = SQLConnectionCesar
    Left = 80
    Top = 56
  end
  object SQLqSelOperator: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'person_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM operator'
      'WHERE person_id = (:person_id)')
    SQLConnection = SQLConnectionCesar
    Left = 80
    Top = 184
  end
  object SQLqSelElectrometer: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'electro_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM electrometer'
      'WHERE electro_id = (:electro_id)')
    SQLConnection = SQLConnectionCesar
    Left = 224
    Top = 16
  end
  object SQLqSelMslElectro: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'electro_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM MslElectro'
      'WHERE electro_id = (:electro_id)')
    SQLConnection = SQLConnectionCesar
    Left = 368
    Top = 48
  end
  object SQLqSelOperationElectro: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'operation_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM operation_electro'
      'WHERE operation_id = (:operation_id)')
    SQLConnection = SQLConnectionCesar
    Left = 80
    Top = 8
  end
  object SQLqSelJournalMsl: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'JournalMsl_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM JournalMsl'
      'WHERE JournalMsl_id = (:JournalMsl_id)')
    SQLConnection = SQLConnectionCesar
    Left = 368
    Top = 104
  end
  object SQLqSelNameElectro: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'name_electro_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM name_electro'
      'WHERE name_electro_id = (:name_electro_id)')
    SQLConnection = SQLConnectionCesar
    Left = 368
    Top = 168
  end
  object SQLqSelTypeElectro: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'type_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM type_electro'
      'WHERE type_id = (:type_id)')
    SQLConnection = SQLConnectionCesar
    Left = 224
    Top = 64
  end
  object SQL_GetOperationElectroBetweenDate: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'FromDate'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'ToDate'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT operation.date_operation'
      '      ,operation.person_id'
      '      ,operation.type_id'
      '      ,operation_electro.operation_id'
      '      ,operation_electro.electro_id'
      'FROM operation_electro'
      '    ,operation'
      
        'WHERE operation_electro].operation_id = [electrometer].[dbo].[op' +
        'eration].operation_id'
      
        '  AND [electrometer].[dbo].[operation].date_operation BETWEEN (:' +
        'FromDate) AND (:ToDate)'
      '  AND [electrometer].[dbo].[operation].type_id = 35'
      ''
      'ORDER BY [electrometer].[dbo].[operation].date_operation')
    SQLConnection = SQLConnectionCesar
    Left = 728
    Top = 24
  end
  object SQL_GetNumberNameFromElectrometer: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'electro_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT electrometer.electro_id'
      '      ,electrometer.number'
      '      ,type_electro.name'
      'FROM electrometer.dbo.electrometer'
      '    ,electrometer.dbo.type_electro'
      'WHERE electrometer.electro_id = (:electro_id)'
      
        '  AND electrometer.dbo.electrometer.type_id = electrometer.dbo.t' +
        'ype_electro.type_id')
    SQLConnection = SQLConnectionCesar
    Left = 728
    Top = 88
  end
  object SQL_GetNumberNameFromMsl: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'electro_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT electrometer.dbo.electrometer.electro_id'
      '      ,electrometer.dbo.electrometer.number'
      '      ,electrometer.dbo.type_electro.name'
      'FROM electrometer.dbo.electrometer'
      '    ,electrometer.dbo.type_electro'
      'WHERE electrometer.dbo.electrometer.electro_id = (:electro_id)'
      
        '  AND electrometer.dbo.electrometer.type_id = electrometer.dbo.t' +
        'ype_electro.type_id')
    SQLConnection = SQLConnectionCesar
    Left = 728
    Top = 160
  end
  object SQL_GetFIOFromOperator: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'person_id'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT operator.person_id'
      '      ,operator.surname + '#39' '#39' +'
      '       operator.first_name + '#39' '#39' +'
      '       operator.last_name AS operator_FIO'
      'FROM electrometer.dbo.operator'
      'WHERE electrometer.dbo.operator.person_id = (:person_id)'
      ''
      'ORDER BY electrometer.dbo.operator.person_id')
    SQLConnection = SQLConnectionCesar
    Left = 912
    Top = 24
  end
end
