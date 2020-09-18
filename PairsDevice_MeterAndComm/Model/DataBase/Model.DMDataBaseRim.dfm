object DMDatabaseRim: TDMDatabaseRim
  OldCreateOrder = False
  Height = 470
  Width = 728
  object SQLConnectionCesar: TSQLConnection
    ConnectionName = 'MSSQL_cesar_connection'
    DriverName = 'MSSQL'
    Params.Strings = (
      'GetDriverFunc=getSQLDriverMSSQL'
      'User_Name=user'
      'Password=password'
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
      'Prepare SQL=False'
      
        'ConnectionString=DriverName=MSSQL,SchemaOverride=%.dbo,DriverUni' +
        't=Data.DBXMSSQL,DriverPackageLoader=TDBXDynalinkDriverLoader,DBX' +
        'CommonDriver250.bpl,DriverAssemblyLoader=Borland.Data.TDBXDynali' +
        'nkDriverLoader,Borland.Data.DbxCommonDriver,Version=24.0.0.0,Cul' +
        'ture=neutral,PublicKeyToken=91d62ebb5b0d1b1b,MetaDataPackageLoad' +
        'er=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDriver250.bpl,MetaDat' +
        'aAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFactory,Bor' +
        'land.Data.DbxMSSQLDriver,Version=24.0.0.0,Culture=neutral,Public' +
        'KeyToken=91d62ebb5b0d1b1b,LibraryName=dbxmss.dll,VendorLib=sqlnc' +
        'li10.dll,VendorLibWin64=sqlncli10.dll,HostName=cesar,Database=el' +
        'ectrometer,MaxBlobSize=-1,LocaleCode=0000,IsolationLevel=ReadCom' +
        'mitted,OSAuthentication=True,PrepareSQL=True,BlobSize=-1,ErrorRe' +
        'sourceFile=,OS Authentication=True,Prepare SQL=False')
    Connected = True
    Left = 56
    Top = 16
  end
  object SQLDataSetFromRim: TSQLDataSet
    SchemaName = 'dbo'
    CommandText = 
      'WITH TableDescriptionVersionAndType AS ('#13#10'SELECT description.ope' +
      'ration_id,'#13#10'       MAX(CASE WHEN (description.title = '#39#1042#1077#1088#1089#1080#1103' '#1087#1088 +
      #1086#1096#1080#1074#1082#1080#39' OR description.title = '#39#1042#1077#1088#1089#1080#1103' '#1055#1054#39') THEN description.val' +
      'ue END) AS version,'#13#10'       MAX(CASE WHEN (description.title = '#39 +
      #1058#1080#1087' '#1089#1095#1077#1090#1095#1080#1082#1072#39' OR description.title = '#39#1058#1080#1087' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1090#1086#1088#1072#39') THEN d' +
      'escription.value END) AS name'#13#10'FROM description'#13#10'GROUP BY descri' +
      'ption.operation_id'#13#10'),'#13#10#13#10'MaxDateForElectroIdTypeId_3_FromOperat' +
      'ion AS ('#13#10'  SELECT operation.electro_id'#13#10'        ,MAX(operation.' +
      'date_operation) AS date_time'#13#10'  FROM operation'#13#10'  WHERE operatio' +
      'n.type_id = 3    '#13#10'  GROUP BY operation.electro_id'#13#10'),'#13#10#13#10'Electr' +
      'oIdTypeNameNumberVersion AS ('#13#10'SELECT operation.electro_id'#13#10'    ' +
      '  ,type_electro.name AS type_name'#13#10'      ,TableDescriptionVersio' +
      'nAndType.name'#13#10'      ,electrometer.number'#13#10'      ,TableDescripti' +
      'onVersionAndType.version'#13#10'      '#13#10'FROM MaxDateForElectroIdTypeId' +
      '_3_FromOperation'#13#10'    ,operation'#13#10'    ,TableDescriptionVersionAn' +
      'dType'#13#10'    ,electrometer'#13#10'    ,type_electro'#13#10'WHERE operation.ele' +
      'ctro_id = MaxDateForElectroIdTypeId_3_FromOperation.electro_id'#13#10 +
      '  AND operation.electro_id = electrometer.electro_id'#13#10'  AND elec' +
      'trometer.type_id = type_electro.type_id'#13#10'  AND operation.date_op' +
      'eration = MaxDateForElectroIdTypeId_3_FromOperation.date_time'#13#10' ' +
      ' AND operation.operation_id = TableDescriptionVersionAndType.ope' +
      'ration_id '#13#10'),'#13#10#13#10'TableOperatorDateMeterAndElectroIdComm AS ('#13#10'S' +
      'ELECT operation.date_operation'#13#10'      , operator.surname + '#39' '#39' +' +
      #13#10'       operator.first_name + '#39' '#39' +'#13#10'       operator.last_name ' +
      'AS operator_FIO'#13#10'      ,ElectroIdTypeNameNumberVersion.type_name' +
      ' AS type_meter'#13#10'      ,ElectroIdTypeNameNumberVersion.name AS na' +
      'me_meter '#13#10'      ,ElectroIdTypeNameNumberVersion.number AS numbe' +
      'r_meter'#13#10'      ,ElectroIdTypeNameNumberVersion.version AS versio' +
      'n_meter'#13#10'      ,operation_electro.electro_id AS electro_id_comm'#13 +
      #10'      '#13#10'  FROM operation_electro'#13#10'      ,operation'#13#10'      ,oper' +
      'ator'#13#10'      ,ElectroIdTypeNameNumberVersion '#13#10'      '#13#10'  WHERE op' +
      'eration_electro.operation_id = operation.operation_id'#13#10'    AND o' +
      'peration.date_operation BETWEEN (:FromDate) AND (:ToDate)'#13#10'    A' +
      'ND operation.person_id = operator.person_id'#13#10'    AND operation.e' +
      'lectro_id = ElectroIdTypeNameNumberVersion.electro_id'#13#10')'#13#10#13#10'SELE' +
      'CT TableOperatorDateMeterAndElectroIdComm.date_operation'#13#10'      ' +
      ',TableOperatorDateMeterAndElectroIdComm.operator_FIO'#13#10'      ,Tab' +
      'leOperatorDateMeterAndElectroIdComm.type_meter'#13#10'      ,TableOper' +
      'atorDateMeterAndElectroIdComm.name_meter'#13#10'      ,TableOperatorDa' +
      'teMeterAndElectroIdComm.number_meter'#13#10'      ,TableOperatorDateMe' +
      'terAndElectroIdComm.version_meter'#13#10'      ,ElectroIdTypeNameNumbe' +
      'rVersion.type_name AS type_comm'#13#10'      ,ElectroIdTypeNameNumberV' +
      'ersion.name AS name_comm'#13#10'      ,ElectroIdTypeNameNumberVersion.' +
      'number AS number_comm'#13#10'      ,ElectroIdTypeNameNumberVersion.ver' +
      'sion AS version_comm'#13#10'       '#13#10'FROM TableOperatorDateMeterAndEle' +
      'ctroIdComm'#13#10'    ,ElectroIdTypeNameNumberVersion'#13#10'    '#13#10'WHERE Tab' +
      'leOperatorDateMeterAndElectroIdComm.electro_id_comm = ElectroIdT' +
      'ypeNameNumberVersion.electro_id'#13#10#13#10'ORDER BY TableOperatorDateMet' +
      'erAndElectroIdComm.date_operation'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'FromDate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'ToDate'
        ParamType = ptInput
      end>
    SQLConnection = SQLConnectionCesar
    Left = 56
    Top = 72
  end
end
