unit Model.Database.Interfaces;

interface
uses
  System.Generics.Collections,
  Model.Declarations;

type
  IDatabaseInterface = interface
  ['{DDE3E13A-0EC5-4712-B068-9B510977CF71}']
    //function UpdatePairDeviceListDatabaseRimDateRange: TOBjectList<TPairDevice>;

    function GetFromDate: TDateTime;
    procedure SetFromDate(const newFromDate: TDateTime);
    function GetToDate: TDateTime;
    procedure SetToDate(const newToDate: TDateTime);
    function GetPairDeviceList: TOBjectList<TPairDevice>;
    procedure SetPairDeviceList(const newPairDeviceList: TOBjectList<TPairDevice>);

    property FromDate: TDateTime read GetFromDate write SetFromDate;
    property ToDate: TDateTime read GetToDate write SetToDate;
    property PairDeviceList: TOBjectList<TPairDevice> read GetPairDeviceList write SetPairDeviceList;
  end;

implementation

end.
