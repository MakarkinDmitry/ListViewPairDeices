unit Model.Main.Interfaces;

interface

uses
  System.Generics.Collections,
  Model.DataBase.Interfaces, Model.Declarations, Model.ProSu.Interfaces;

type
  IMainModelInterface = interface
    ['{1345E22D-6229-4C27-8D08-6EA8584BE718}']

    procedure UpdateDataBaseRimDateRange(const fromDate, toDate: TDateTime);

    function GetDataBaseRim: IDataBaseInterface;
    procedure SetDataBaseRim(const newDataBaseRim: IDataBaseInterface);

    property DataBaseRim: IDataBaseInterface read GetDataBaseRim
                                             write SetDataBaseRim;
  end;

implementation

end.
