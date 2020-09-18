unit Model.Main;

interface

uses System.Generics.Collections,
  Model.Main.Interfaces, Model.Declarations;

function CreateMainModelClass: IMainModelInterface;

implementation

uses System.SysUtils, System.DateUtils,
  Model.DataBase, Model.DataBase.Interfaces, Model.ThreadLoadDataBase,
  Model.ProSu.Notification;

type
  TMainModel = class (TInterfacedObject, IMainModelInterface)
  private
    fDatabaseRim: IDataBaseInterface;

    procedure UpdateDataBaseRimDateRange(const fromDate, toDate: TDateTime);
    function GetDataBaseRim: IDataBaseInterface;
    procedure SetDataBaseRim (const newDataBaseRim: IDataBaseInterface);

  public
    property DataBaseRim: IDataBaseInterface read GetDataBaseRim
                                                           write SetDataBaseRim;

    constructor Create;
  end;

function CreateMainModelClass: IMainModelInterface;
begin
  result := TMainModel.Create;
end;

{ TMainModel }

constructor TMainModel.Create;
var
  ThreadDataBaseRim: TThreadDataBaseRim;
begin
  fDataBaseRim := CreateDataBaseClass;
  fDatabaseRim.ToDate := DateOf(Now);
  fDatabaseRim.FromDate := StartOfTheMonth(IncMonth(fDatabaseRim.ToDate, -6));

  if not Assigned(ThreadDataBaseRim) then
  begin
    ThreadDataBaseRim := TThreadDataBaseRim.Create(True);
    ThreadDataBaseRim.FreeOnTerminate := True;
    try
      ThreadDataBaseRim.DataBaseRim := fDataBaseRim;
      ThreadDataBaseRim.Resume;
    except on EConvertError do
      begin
        FreeAndNil(ThreadDataBaseRim);
        //ShowMessage('That is not a valid number!');
      end;
    end;
  end;
end;

function TMainModel.GetDatabaseRim: IDatabaseInterface;
begin
  Result := fDataBaseRim;
end;

procedure TMainModel.SetDataBaseRim(const newDataBaseRim: IDataBaseInterface);
begin
  fDataBaseRim := newDataBaseRim;
end;

procedure TMainModel.UpdateDataBaseRimDateRange(const fromDate, toDate: TDateTime);
var
  ThreadDataBaseRim: TThreadDataBaseRim;
begin
  if toDate > fDatabaseRim.ToDate then
    fDatabaseRim.ToDate := DateOf(Now);

  while fromDate < fDatabaseRim.FromDate do
    fDatabaseRim.FromDate := IncMonth(fDatabaseRim.FromDate, -3);

  //fDatabaseRim.PairDeviceList :=
    //fDatabaseRim.UpdatePairDeviceListDatabaseRimDateRange(fDatabaseRim.FromDate,
                                                          //fDatabaseRim.ToDate);
  //if not Assigned(ThreadDataBaseRim) then
  //begin
    ThreadDataBaseRim := TThreadDataBaseRim.Create(True);
    ThreadDataBaseRim.FreeOnTerminate := True;
    try
      ThreadDataBaseRim.DataBaseRim := fDataBaseRim;
      ThreadDataBaseRim.Resume;
    except on EConvertError do
      begin
        FreeAndNil(ThreadDataBaseRim);
        //ShowMessage('That is not a valid number!');
      end;
    end;
  //end;
end;
end.
