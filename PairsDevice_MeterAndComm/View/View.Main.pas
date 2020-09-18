unit View.Main;

interface
  uses
    Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
    System.Generics.Collections,

    Model.ProSu.Interfaces, Model.Main, ViewModel.Main.Interfaces, Model.Declarations,
  Vcl.WinXCtrls;

  //const

  type
    TViewMainForm = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    LbFrom: TLabel;
    LbTo: TLabel;
    LbNumberMeter: TLabel;
    edNumberMeter: TEdit;
    ToDateTimePicker: TDateTimePicker;
    FromDateTimePicker: TDateTimePicker;
    cbRiM189_2x: TCheckBox;
    cbRiM289_2x: TCheckBox;
    cbRiM489_2x: TCheckBox;
    CheckBox4: TCheckBox;
    StatusBar1: TStatusBar;
    ActivityIndicatorWait: TActivityIndicator;

    procedure FormCreate(Sender: TObject);
    procedure FromDateTimePickerChange(Sender: TObject);
    procedure ToDateTimePickerChange(Sender: TObject);
    procedure edNumberMeterChange(Sender: TObject);
    procedure cbRiM189_2xClick(Sender: TObject);
    procedure cbRiM289_2xClick(Sender: TObject);
    procedure cbRiM489_2xClick(Sender: TObject);
    procedure ListView1Data(Sender: TObject; Item: TListItem);

    private
      { Private declarations }
      fViewModel: IMainViewModelInterface;
      fSubscriber: ISubscriberInterface;
      fProvider: IProviderInterface;

      procedure NotificationFromProvider(const notifyClass: INotificationClass);

      procedure SetViewModel(const newViewModel: IMainViewModelInterface);
      procedure SetupGUI;
      procedure GroupComponetsEnabbled(const newEnabled: Boolean);

    public
      { Public declarations }
      property ViewModel: IMainViewModelInterface read fViewModel
                                                  write SetViewModel;
      property Provider: IProviderInterface read fProvider;

      procedure UpdateListView;
    end;

  var
    ViewMainForm: TViewMainForm;

  //*procedure headers*

  //*function headers*

implementation

{$R *.dfm}

uses
  System.SysUtils, System.DateUtils,
  Model.DataBase.Interfaces,
  Model.ProSu.InterfaceActions, Model.ProSu.Subscriber, Model.ProSu.Notification,
  Model.ProSu.Provider;

// const

// type

// var

// description of procedures

{ TViewMainForm }
procedure TViewMainForm.NotificationFromProvider(
                                         const notifyClass: INotificationClass);
var
  tmpNotifClass: TNotificationClass;
  tmpErrorNotifClass: TErrorNotificationClass;
begin
  if notifyClass is TNotificationClass then
  begin
    tmpNotifClass := notifyClass as TNotificationClass;

    {if actInvoiceItemsChanges in tmpNotifClass.Actions then
      UpdateInvoiceGrid;}

    if actWaitStart in tmpNotifClass.Actions then
    begin
      ActivityIndicatorWait.Visible := fViewModel.AniIndicatorWaitVisible;
      ActivityIndicatorWait.Animate := fViewModel.AniIndicatorWaitVisible;
      StatusBar1.Panels[0].Text := 'Идёт загрузка данных из сервера';
      GroupComponetsEnabbled(not fViewModel.AniIndicatorWaitVisible);
    end;

    if actWaitFinish in tmpNotifClass.Actions then
    begin
      ActivityIndicatorWait.Animate := fViewModel.AniIndicatorWaitVisible;
      ActivityIndicatorWait.Visible := fViewModel.AniIndicatorWaitVisible;
      StatusBar1.Panels[0].Text := '';
      GroupComponetsEnabbled(not fViewModel.AniIndicatorWaitVisible);
    end;

    if actCheckBoxMeters in tmpNotifClass.Actions then
    begin
      cbRiM189_2x.Enabled := fViewModel.RiM189_2xEnabled;
      cbRiM289_2x.Enabled := fViewModel.RiM289_2xEnabled;
      cbRiM489_2x.Enabled := fViewModel.RiM489_2xEnabled;
    end;
  end;

  if notifyClass is TErrorNotificationClass then
  begin
    tmpErrorNotifClass := notifyClass as TErrorNotificationClass;

    if errRangeDate in tmpErrorNotifClass.Actions then
    begin
      ShowMessage(tmpErrorNotifClass.ActionMessage);

      if CompareDate(fViewModel.FromDate, FromDateTimePicker.Date) <> 0 then
      begin
        FromDateTimePicker.Date := fViewModel.FromDate;
        FromDateTimePicker.SetFocus;
      end
      else
      if CompareDate(fViewModel.ToDate, ToDateTimePicker.Date) <> 0 then
      begin
        ToDateTimePicker.Date := fViewModel.ToDate;
        ToDateTimePicker.SetFocus;
      end;

      Exit;
    end
    else
    if errNoErrorRangeDate in tmpErrorNotifClass.Actions then
    begin
      if CompareDate(fViewModel.FromDate, FromDateTimePicker.Date) <> 0 then
      begin
        fViewModel.FromDate := FromDateTimePicker.Date;
        UpdateListView;
      end
      else
      if CompareDate(fViewModel.ToDate, ToDateTimePicker.Date) <> 0 then
      begin
        fViewModel.ToDate := ToDateTimePicker.Date;
        UpdateListView;
      end;
    end
    else
    if (errNumberMeterNonPositive in tmpErrorNotifClass.Actions)
      or (errNumberMeterNotNumber in tmpErrorNotifClass.Actions) then
    begin
      ShowMessage(tmpErrorNotifClass.ActionMessage);
      edNumberMeter.SelectAll;
      edNumberMeter.SetFocus;
      Exit;
    end
    else if (errNoErrorNumberMeter in tmpErrorNotifClass.Actions) then
    begin
      fViewModel.NumberMeter := edNumberMeter.Text;
      UpdateListView;
    end
    else if (errNumberCommNonPositive in tmpErrorNotifClass.Actions)
      or (errNumberCommNotNumber in tmpErrorNotifClass.Actions) then
    begin
      ShowMessage(tmpErrorNotifClass.ActionMessage);
      //edNumberMeter.SelectAll;
      //edNumberMeter.SetFocus;
      Exit;
    //end
    //else
    //begin
      //ActivityIndicatorWait.Animate := True;
      //fViewModel.WaitProcessStart;
      //TimerStartUpdateListView.Enabled := True;
      //UpdateListViewDateRange(fViewModel.FilterNumberMeterDatabaseListView(edNumberMeter.Text));
    end;
  end;
end;

procedure TViewMainForm.SetViewModel(const newViewModel: IMainViewModelInterface);
begin
  fViewModel := newViewModel;
  if not Assigned(fViewModel) then
    raise Exception.Create('Main View Model is required.');

  fSubscriber := CreateProSuSubcriberClass;
  fSubscriber.SetUpdateSubscriberMethod(NotificationFromProvider);
  fViewModel.Provider.Subscribe(fSubscriber);

  fProvider := CreateProSuProviderClass;

  // и далее вызываем функцию...
  SetupGUI;
end;

procedure TViewMainForm.SetupGUI;
begin
  // здесь надо извлечь данные из модели и заполнять таблицу
  fViewModel.WaitProcessStart;

  fViewModel.ToDate := DateOf(Now);
  fViewModel.FromDate := StartOfTheMonth(IncMonth(fViewModel.ToDate, -3));

  ViewMainForm.FromDateTimePicker.Date := fViewModel.FromDate;
  ViewMainForm.ToDateTimePicker.Date := fViewModel.ToDate;

  cbRiM189_2x.Checked := fViewModel.RiM189_2xApplied;
  cbRiM289_2x.Checked := fViewModel.RiM289_2xApplied;
  cbRiM489_2x.Checked := fViewModel.RiM489_2xApplied;
end;

procedure TViewMainForm.GroupComponetsEnabbled(const newEnabled: Boolean);
begin
  FromDateTimePicker.Enabled := newEnabled;
  ToDateTimePicker.Enabled := newEnabled;
  edNumberMeter.Enabled := newEnabled;
  cbRiM189_2x.Enabled := newEnabled;
  cbRiM289_2x.Enabled := newEnabled;
  cbRiM489_2x.Enabled := newEnabled;
end;

procedure TViewMainForm.UpdateListView;
begin
  fViewModel.UpdateDatabaseListViewRangeDate(fViewModel.FromDate, fViewModel.ToDate);
  fViewModel.EnabledCheckBoxMeters;
  ListView1.Items.Count := Length(fViewModel.PairDeviceArr);
  StatusBar1.Panels[2].Text := 'Количество записей:  ' + IntToStr(ListView1.Items.Count);
  ListView1.UpdateItems(0, ListView1.Items.Count);
end;

procedure TViewMainForm.FormCreate(Sender: TObject);
begin
  fSubscriber := CreateProSuSubcriberClass;
  fSubscriber.SetUpdateSubscriberMethod(NotificationFromProvider);
  Listview1.OwnerData := True;
end;

procedure TViewMainForm.cbRiM189_2xClick(Sender: TObject);
begin
  fViewModel.RiM189_2xApplied := cbRiM189_2x.Checked;
  UpdateListView;
end;

procedure TViewMainForm.cbRiM289_2xClick(Sender: TObject);
begin
  fViewModel.RiM289_2xApplied := cbRiM289_2x.Checked;
  UpdateListView;
end;

procedure TViewMainForm.cbRiM489_2xClick(Sender: TObject);
begin
  fViewModel.RiM489_2xApplied := cbRiM489_2x.Checked;
  UpdateListView;
end;

procedure TViewMainForm.edNumberMeterChange(Sender: TObject);
begin
  fViewModel.ValidateNumberMeter(edNumberMeter.Text)
end;

procedure TViewMainForm.FromDateTimePickerChange(Sender: TObject);
begin
  if CompareDate(FromDateTimePicker.Date, fViewModel.FromDate) <> 0 then
    fViewModel.ValidateRangeDate(ViewMainForm.FromDateTimePicker.Date, ViewMainForm.ToDateTimePicker.Date);
end;

procedure TViewMainForm.ToDateTimePickerChange(Sender: TObject);
begin
  if CompareDate(ToDateTimePicker.Date, fViewModel.ToDate) <> 0 then
    fViewModel.ValidateRangeDate(FromDateTimePicker.Date, ToDateTimePicker.Date);
end;

procedure TViewMainForm.ListView1Data(Sender: TObject; Item: TListItem);
begin
  if Assigned(fViewModel) then
  begin
    Item.Caption := fViewModel.PairDeviceArr[Item.Index].PersonFIO;
    Item.SubItems.Add(fViewModel.PairDeviceArr[Item.Index].Date);
    Item.SubItems.Add(fViewModel.PairDeviceArr[Item.Index].Time);
    Item.SubItems.Add(fViewModel.PairDeviceArr[Item.Index].NameMeter);
    Item.SubItems.Add(IntToStr(fViewModel.PairDeviceArr[Item.Index].NumberMeter));
    Item.SubItems.Add(fViewModel.PairDeviceArr[Item.Index].VersionMeter);
    Item.SubItems.Add(fViewModel.PairDeviceArr[Item.Index].NameComm);
    Item.SubItems.Add(IntToStr(fViewModel.PairDeviceArr[Item.Index].NumberComm));
    Item.SubItems.Add(fViewModel.PairDeviceArr[Item.Index].VersionComm);
  end;
end;

  // function description
end.
