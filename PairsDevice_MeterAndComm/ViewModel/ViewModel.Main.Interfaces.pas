unit ViewModel.Main.Interfaces;

interface

uses
  System.Generics.Collections,
  Model.DataBase.Interfaces, Model.Declarations,
  Model.ProSu.Interfaces, Model.Main.Interfaces;

  type
    IMainViewModelInterface = interface
      ['{62CF0DAC-C808-4B1A-A6DC-57D7DC1912CB}']

    procedure ValidateRangeDate (const newFromDate, newToDate: TDateTime);
    procedure ValidateNumberMeter (const newNumberMeter: string);
    procedure ValidateNumberComm (const newNumberComm: string);
    procedure EnabledCheckBoxMeters;
    procedure WaitProcessStart;
    procedure WaitProcessFinish;

    procedure UpdateDataBaseListViewRangeDate(const fromDate, toDate: TDateTime);

    function GetModel: IMainModelInterface;
    procedure SetModel (const newModel: IMainModelInterface);
    function GetProvider: IProviderInterface;
    function GetFromDate: TDateTime;
    procedure SetFromDate(const newFromDate: TDateTime);
    function GetToDate: TDateTime;
    procedure SetToDate(const newToDate: TDateTime);
    function GetPairDeviceArr: TPairDeviceArr;

    function GetAniIndicatorWaitVisible: Boolean;
    function GetNumberMeter: String;
    procedure SetNumberMeter(const newNumberMeter: String);

    procedure SetRiM189_2xApplied(const checkedRiM189_2x: Boolean);
    function GetRiM189_2xApplied: Boolean;
    procedure SetRiM289_2xApplied(const checkedRiM289_2x: Boolean);
    function GetRiM289_2xApplied: Boolean;
    procedure SetRiM489_2xApplied(const checkedRiM489_2x: Boolean);
    function GetRiM489_2xApplied: Boolean;

    function GetRiM189_2xEnabled: Boolean;
    function GetRiM289_2xEnabled: Boolean;
    function GetRiM489_2xEnabled: Boolean;

    property Model: IMainModelInterface read GetModel write SetModel;
    property Provider: IProviderInterface read GetProvider;
    property FromDate: TDateTime read GetFromDate write SetFromDate;
    property ToDate: TDateTime read GetToDate write SetToDate;
    property PairDeviceArr: TPairDeviceArr read GetPairDeviceArr;
    property AniIndicatorWaitVisible: Boolean read GetAniIndicatorWaitVisible;
    property NumberMeter: String read GetNumberMeter write SetNumberMeter;
    property RiM189_2xApplied: Boolean read GetRiM189_2xApplied write SetRiM189_2xApplied;
    property RiM289_2xApplied: Boolean read GetRiM289_2xApplied write SetRiM289_2xApplied;
    property RiM489_2xApplied: Boolean read GetRiM489_2xApplied write SetRiM489_2xApplied;
    property RiM189_2xEnabled: Boolean read GetRiM189_2xEnabled;
    property RiM289_2xEnabled: Boolean read GetRiM289_2xEnabled;
    property RiM489_2xEnabled: Boolean read GetRiM489_2xEnabled;
  end;
implementation

end.
