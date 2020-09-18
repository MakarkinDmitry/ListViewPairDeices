unit Model.RemoteDatabase;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr,
  Data.DBXMSSQL;

type
  TCesarDataBaseRiM = class(TDataModule)
    SQLConnectionCesar: TSQLConnection;
    SQLqSelOperationDateBetveen: TSQLQuery;
    SQLqSelOperator: TSQLQuery;
    SQLqSelElectrometer: TSQLQuery;
    SQLqSelMslElectro: TSQLQuery;
    SQLqSelOperationElectro: TSQLQuery;
    SQLqSelJournalMsl: TSQLQuery;
    SQLqSelNameElectro: TSQLQuery;
    SQLqSelTypeElectro: TSQLQuery;

    SQL_GetOperationElectroBetweenDate: TSQLQuery;
    SQL_GetNumberNameFromElectrometer: TSQLQuery;
    SQL_GetNumberNameFromMsl: TSQLQuery;
    SQL_GetFIOFromOperator: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CesarDataBaseRiM: TCesarDataBaseRiM;

implementation

end.
