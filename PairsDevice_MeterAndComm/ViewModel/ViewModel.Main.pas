unit ViewModel.Main;

interface

uses System.Generics.Collections,
  Model.ProSu.Notification, Model.Declarations, ViewModel.Main.Interfaces;

//const

//type

//var

// procedure

function CreateMainViewModelClass: IMainViewModelInterface;

implementation

uses System.SysUtils, System.RegularExpressions, System.DateUtils,
  Model.DataBase.Interfaces, Model.DataBase,
  Model.ProSu.InterfaceActions, Model.ProSu.Interfaces, Model.ProSu.Provider,
  Model.Main.Interfaces;

// const

type
  TMainViewModel = class (TInterfacedObject, IMainViewModelInterface)
  private
    fModel: IMainModelInterface;
    fProvider: IProviderInterface;

    fFromDate,
    fToDate: TDateTime;
    fPairDeviceArr: TPairDeviceArr;

    fAniIndicatorVisible: Boolean;
    fNumberMeter: String;
    fRiM189_2xChecked,
    fRiM289_2xChecked,
    fRiM489_2xChecked,
    fRiM189_2xEnabled,
    fRiM289_2xEnabled,
    fRiM489_2xEnabled: Boolean;

    procedure SendNotification (const actions: TInterfaceActions);
    procedure SendErrorNotification (const errorType: TInterfaceErrors;
                                         const errorMessage: string);

    function GetModel: IMainModelInterface;
    procedure SetModel (const newModel: IMainModelInterface);
    function GetProvider: IProviderInterface;

    function GetFromDate: TDateTime;
    procedure SetFromDate(const newFromDate: TDateTime);
    function GetToDate: TDateTime;
    procedure SetToDate(const newToDate: TDateTime);
    function GetPairDeviceArr: TPairDeviceArr;
    procedure UpdateDataBaseListViewRangeDate(const fromDate, toDate: TDateTime);

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

    function GetAniIndicatorWaitVisible: Boolean;

  public
    constructor Create;

    procedure ValidateRangeDate (const newFromDate, newToDate: TDateTime);
    procedure ValidateNumberMeter (const newNumberMeter: string);
    procedure ValidateNumberComm (const newNumberComm: string);
    procedure EnabledCheckBoxMeters;
    procedure WaitProcessStart;
    procedure WaitProcessFinish;

    property Model: IMainModelInterface read GetModel write SetModel;
    property Provider: IProviderInterface read GetProvider;

    property FromDate: TDateTime read GetFromDate write SetFromDate;
    property ToDate: TDateTime read GetToDate write SetToDate;
    property PairDeviceArr: TPairDeviceArr read GetPairDeviceArr;

    property AniIndicatorWaitVisible: Boolean read GetAniIndicatorWaitVisible;
    property Numbermeter: String read GetNumberMeter write SetNumberMeter;
    property RiM189_2xApplied: Boolean read GetRiM189_2xApplied write SetRiM189_2xApplied;
    property RiM289_2xApplied: Boolean read GetRiM289_2xApplied write SetRiM289_2xApplied;
    property RiM489_2xApplied: Boolean read GetRiM489_2xApplied write SetRiM489_2xApplied;
    property RiM189_2xEnabled: Boolean read GetRiM189_2xEnabled;
    property RiM289_2xEnabled: Boolean read GetRiM289_2xEnabled;
    property RiM489_2xEnabled: Boolean read GetRiM489_2xEnabled;
  end;

// var

function CreateMainViewModelClass: IMainViewModelInterface;
begin
  result := TMainViewModel.Create;
end;

{ TMainViewModel }

constructor TMainViewModel.Create;
begin
  fProvider := CreateProSuProviderClass;
  fRiM189_2xChecked := True;
  fRiM289_2xChecked := True;
  fRiM489_2xChecked := True;
end;

function TMainViewModel.GetModel: IMainModelInterface;
begin
   result := fModel;
end;

procedure TMainViewModel.SetModel(const newModel: IMainModelInterface);
begin
  fModel := newModel;
end;

function TMainViewModel.GetFromDate: TDateTime;
begin
  Result := fFromDate;
end;

procedure TMainViewModel.SetFromDate(const newFromDate: TDateTime);
begin
  fFromDate := newFromDate;
end;

function TMainViewModel.GetToDate: TDateTime;
begin
  Result := fToDate;
end;

procedure TMainViewModel.SetToDate(const newToDate: TDateTime);
begin
  fToDate := newToDate;
end;

function TMainViewModel.GetPairDeviceArr: TPairDeviceArr;
begin
  Result := fPairDeviceArr;
end;

function TMainViewModel.GetNumberMeter: String;
begin
  Result := fNumberMeter;
end;

procedure TMainViewModel.SetNumberMeter(const newNumberMeter: String);
begin
  fNumberMeter := newNumberMeter;
end;

function TMainViewModel.GetRiM189_2xApplied: Boolean;
begin
  Result := fRiM189_2xChecked;
end;

function TMainViewModel.GetRiM189_2xEnabled: Boolean;
begin
  Result := fRiM189_2xEnabled;
end;

procedure TMainViewModel.SetRiM189_2xApplied(const checkedRiM189_2x: Boolean);
begin
  fRiM189_2xChecked := checkedRiM189_2x;
end;

function TMainViewModel.GetRiM289_2xApplied: Boolean;
begin
  Result := fRiM289_2xChecked
end;

function TMainViewModel.GetRiM289_2xEnabled: Boolean;
begin
  Result := fRiM289_2xEnabled;
end;

procedure TMainViewModel.SetRiM289_2xApplied(const checkedRiM289_2x: Boolean);
begin
  fRiM289_2xChecked := checkedRiM289_2x;
end;

function TMainViewModel.GetRiM489_2xApplied: Boolean;
begin
  Result := fRiM489_2xChecked;
end;

function TMainViewModel.GetRiM489_2xEnabled: Boolean;
begin
  Result := fRiM489_2xEnabled
end;

procedure TMainViewModel.SetRiM489_2xApplied(const checkedRiM489_2x: Boolean);
begin
  fRiM489_2xChecked := checkedRiM489_2x;
end;

function TMainViewModel.GetProvider: IProviderInterface;
begin
  result := fProvider;
end;

function TMainViewModel.GetAniIndicatorWaitVisible: Boolean;
begin
  Result := fAniIndicatorVisible;
end;

procedure TMainViewModel.UpdateDataBaseListViewRangeDate(const fromDate, toDate: TDateTime);
var
  tmpPairDevice: TPairDevice;
  RegEx: TRegEx;
  Pattern: String;
  tmpPairDeviceArr: TPairDeviceArr;
  tmpCountRim189, tmpCountRim289, tmpCountRim489,
  ln, i, j: Integer;
begin
  if not Assigned(fModel) then
    Exit;
  // условие проверки диапазон даты
  if (CompareDate(fromDate, fModel.DataBaseRim.FromDate) < 0) then
  begin
    WaitProcessStart;
    // Начальная дата находится вне диапазона даты дданных в памяти - обновляем данные в памяти из сервера
    fModel.UpdateDataBaseRimDateRange(fromDate, DateOf(now));
  end
  else
  begin
    tmpCountRim189 := 0;
    tmpCountRim289 := 0;
    tmpCountRim489 := 0;

    fRiM189_2xEnabled := True;
    fRiM289_2xEnabled := True;
    fRiM489_2xEnabled := True;

    i := -1;
    for tmpPairDevice in fModel.DataBaseRim.PairDeviceList do
    begin
      if (CompareDate(fromDate, StrToDate(tmpPairDevice.Date)) < 1) and
         (CompareDate(StrToDate(tmpPairDevice.Date), toDate) < 1) then
      begin
        Inc(i);
        SetLength(fPairDeviceArr, i + 1);
        fPairDeviceArr[i].PersonFIO := tmpPairDevice.PersonFIO;
        fPairDeviceArr[i].Date := tmpPairDevice.Date;
        fPairDeviceArr[i].Time := tmpPairDevice.Time;
        fPairDeviceArr[i].TypeMeter := tmpPairDevice.TypeMeter;
        fPairDeviceArr[i].NameMeter := tmpPairDevice.NameMeter;
        fPairDeviceArr[i].NumberMeter := tmpPairDevice.NumberMeter;
        fPairDeviceArr[i].VersionMeter := tmpPairDevice.VersionMeter;
        fPairDeviceArr[i].TypeComm := tmpPairDevice.TypeComm;
        fPairDeviceArr[i].NameComm := tmpPairDevice.NameComm;
        fPairDeviceArr[i].NumberComm := tmpPairDevice.NumberComm;
        fPairDeviceArr[i].VersionComm := tmpPairDevice.VersionComm;

        if fPairDeviceArr[i].TypeMeter = 'РиМ 189.2x' then
          Inc(tmpCountRim189)
        else if fPairDeviceArr[i].TypeMeter = 'РиМ 289.2x' then
          Inc(tmpCountRim289)
        else if fPairDeviceArr[i].TypeMeter = 'РиМ 489.2x (3x)' then
          Inc(tmpCountRim489);
      end;
    end;

    if tmpCountRim189 = 0 then
      fRiM189_2xEnabled := False;
    if tmpCountRim289 = 0 then
      fRiM289_2xEnabled := False;
    if tmpCountRim489 = 0 then
      fRiM489_2xEnabled := False;

    if fNumberMeter <> '' then
    begin
      ln := Length(fNumberMeter);
      if (6 - ln) > 1 then
        Pattern := Format('%s\d{%d}\d?\d?', [fNumberMeter, (6 - ln)])
      else if (6 - ln) = 1  then
        Pattern := Format('%s\d\d?\d?', [fNumberMeter])
      else
        Pattern := Format('%s\d?\d?', [fNumberMeter]);

      j := -1;

      RegEx := TRegEx.Create(Pattern);

      for i := 0 to Length(fPairDeviceArr) - 1 do
      begin
        if RegEx.IsMatch(IntToStr(fPairDeviceArr[i].NumberMeter)) then
        begin
          Inc(j);
          SetLength(tmpPairDeviceArr, j + 1);
          tmpPairDeviceArr[j] := fPairDeviceArr[i];
        end;
      end;

      fPairDeviceArr := tmpPairDeviceArr;
    end;

    if ((not fRiM189_2xChecked) or
        (not fRiM289_2xChecked) or
        (not fRiM489_2xChecked))then
    begin
      j := -1;

      for i := 0 to Length(fPairDeviceArr) - 1 do
      begin
        if (fRiM189_2xChecked) and (fPairDeviceArr[i].TypeMeter = 'РиМ 189.2x') then
        begin
          Inc(j);
          SetLength(tmpPairDeviceArr, j + 1);
          tmpPairDeviceArr[j] := fPairDeviceArr[i];
        end
        else if (fRiM289_2xChecked) and (fPairDeviceArr[i].TypeMeter = 'РиМ 289.2x') then
        begin
          Inc(j);
          SetLength(tmpPairDeviceArr, j + 1);
          tmpPairDeviceArr[j] := fPairDeviceArr[i];
        end
        else if (fRiM489_2xChecked) and (fPairDeviceArr[i].TypeMeter = 'РиМ 489.2x (3x)') then
        begin
          Inc(j);
          SetLength(tmpPairDeviceArr, j + 1);
          tmpPairDeviceArr[j] := fPairDeviceArr[i];
        end;
      end;

      fPairDeviceArr := tmpPairDeviceArr;
    end;

    if fAniIndicatorVisible then
      WaitProcessFinish;
  end;
end;

procedure TMainViewModel.SendErrorNotification (const errorType: TInterfaceErrors;
                                         const errorMessage: string);
var
  tmpErrorNotificationClass: TErrorNotificationClass;
begin
  tmpErrorNotificationClass := TErrorNotificationClass.Create;
  try
    tmpErrorNotificationClass.Actions := errorType;
    tmpErrorNotificationClass.ActionMessage := errorMessage;
    fProvider.NotifySubscribers(tmpErrorNotificationClass);
  finally
    tmpErrorNotificationClass.Free;
  end;

end;

procedure TMainViewModel.SendNotification(const actions: TInterfaceActions);
var
  tmpNotificationClass: TNotificationClass;
begin
  tmpNotificationClass := TNotificationClass.Create;
  tmpNotificationClass.Actions := actions;
  if Assigned(fProvider) then
   fProvider.NotifySubscribers(tmpNotificationClass);
  tmpNotificationClass.Free;
end;

procedure TMainViewModel.ValidateNumberComm(const newNumberComm: string);
var
  value,
  code: integer;
begin
Val(trim(newNumberComm), value, code);
  if code <> 0 then
  begin
    SendErrorNotification([errNumberMeterNotNumber],
                         'Номер коммуникатора должен содержаться только цифры');
    Exit;
  end;

  if trim(newNumberComm).ToInteger <= 0 then
  begin
    SendErrorNotification([errNumberMeterNonPositive],
                              'В номере коммуникатора есть посторонний символ');
    Exit;
  end;

  SendErrorNotification([errNoErrorNumberComm], '');
end;

procedure TMainViewModel.ValidateNumberMeter(const newNumberMeter: string);
var
  value,
  code: integer;
begin
  {if trim(newNumberMeter)='' then
  begin
    SendErrorNotification([errInvoiceItemQuantityEmpty], 'Please enter quantity');
    Exit;
  end;}

  Val(trim(newNumberMeter), value, code);
  if code <> 0 then
  begin
    SendErrorNotification([errNumberMeterNotNumber],
                              'Номер счетчика должен содержаться только цифры');
    Exit;
  end;

  if trim(newNumberMeter).ToInteger <= 0 then
  begin
    SendErrorNotification([errNumberMeterNonPositive],
                                   'В номере счетчика есть посторонний символ');
    Exit;
  end;

  SendErrorNotification([errNoErrorNumberMeter], '');
end;

procedure TMainViewModel.ValidateRangeDate(const newFromDate,
                                                          newToDate: TDateTime);
begin
  if CompareDate(newFromDate, newToDate) > 0 then
  begin
    SendErrorNotification([errRangeDate], 'Диапазон даты указан не верно - Начальная дата указана позднее, чем конечной даты');
    WaitProcessFinish;
    Exit;
  end;

  SendErrorNotification([errNoErrorRangeDate], '');
end;

procedure TMainViewModel.EnabledCheckBoxMeters;
begin
  SendNotification([actCheckBoxMeters]);
end;

procedure TMainViewModel.WaitProcessFinish;
begin
  fAniIndicatorVisible := False;

  SendNotification([actWaitFinish]);
end;

procedure TMainViewModel.WaitProcessStart;
begin
  fAniIndicatorVisible := True;

  SendNotification([actWaitStart]);
end;

end.
