unit Model.Declarations;

interface

//uses

type
  TPairDevice = class
    private
      fPersonFIO,
      fDate,
      fTime,
      fTypeMeter,
      fNameMeter: String;
      fNumberMeter: Integer;
      fVersionMeter: String;
      fTypeComm,
      fNameComm: String;
      fNumberComm: Integer;
      fVersionComm: String;
      //fSuccess: String;

    public
      property PersonFIO: String read fPersonFIO write fPersonFIO;
      property Date: String read fDate write fDate;
      property Time: String read fTime write fTime;
      property TypeMeter: String read fTypeMeter write fTypeMeter;
      property NameMeter: String read fNameMeter write fNameMeter;
      property NumberMeter: Integer read fNumberMeter write fNumberMeter;
      property VersionMeter: String read fVersionMeter write fVersionMeter;
      property TypeComm: String read fTypeComm write fTypeComm;
      property NameComm: String read fNameComm write fNameComm;
      property NumberComm: Integer read fNumberComm write fNumberComm;
      property VersionComm: String read fVersionComm write fVersionComm;
     // property Success: String read fSuccess write fSuccess;
  end;

  TPairDeviceRec = record
    PersonFIO,
    Date,
    Time,
    TypeMeter,
    NameMeter: String;
    NumberMeter: Integer;
    VersionMeter: String;
    TypeComm,
    NameComm: String;
    NumberComm: Integer;
    VersionComm: String;
  end;

  TPairDeviceArr = array of TPairDeviceRec;

implementation

end.
