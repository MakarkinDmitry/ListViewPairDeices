unit Model.DMDataBaseRim;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DBXMSSQL, Data.DB,
  Data.SqlExpr;

type
  TDMDatabaseRim = class(TDataModule)
    SQLConnectionCesar: TSQLConnection;
    SQLDataSetFromRim: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMDatabaseRim: TDMDatabaseRim;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
