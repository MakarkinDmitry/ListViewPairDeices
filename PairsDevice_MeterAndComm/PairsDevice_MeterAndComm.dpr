program PairsDevice_MeterAndComm;

uses
  Model.Database.Interfaces in 'Model\DataBase\Model.Database.Interfaces.pas',
  Model.DataBase in 'Model\DataBase\Model.DataBase.pas',
  Model.DMDataBaseRim in 'Model\DataBase\Model.DMDataBaseRim.pas' {DMDatabaseRim: TDataModule},
  Model.ProSu.InterfaceActions in 'Model\SupportCode\Model.ProSu.InterfaceActions.pas',
  Model.ProSu.Interfaces in 'Model\SupportCode\Model.ProSu.Interfaces.pas',
  Model.ProSu.Notification in 'Model\SupportCode\Model.ProSu.Notification.pas',
  Model.ProSu.Provider in 'Model\SupportCode\Model.ProSu.Provider.pas',
  Model.ProSu.Subscriber in 'Model\SupportCode\Model.ProSu.Subscriber.pas',
  Model.Declarations in 'Model\Model.Declarations.pas',
  Model.Main.Interfaces in 'Model\Model.Main.Interfaces.pas',
  Model.Main in 'Model\Model.Main.pas',
  ViewModel.Main.Interfaces in 'ViewModel\ViewModel.Main.Interfaces.pas',
  ViewModel.Main in 'ViewModel\ViewModel.Main.pas',
  View.Main in 'View\View.Main.pas' {ViewMainForm},
  Vcl.Forms,
  Model.ThreadLoadDataBase in 'Model\DataBase\Model.ThreadLoadDataBase.pas';

{$R *.res}

var
  mainModel: IMainModelInterface;
  mainViewModel: IMainViewModelInterface;

begin
  Application.Initialize;

  Application.CreateForm(TDMDatabaseRim, DMDatabaseRim);
  mainModel := CreateMainModelClass;
  mainViewModel := CreateMainViewModelClass;
  mainViewModel.Model := mainModel;

  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TViewMainForm, ViewMainForm);
  //MainForm := TMainForm.Create(Application); // вызывает пустой конструктор из FMX.Forms

  ViewMainForm.ViewModel := mainViewModel;
  //Application.MainForm := MainForm;

  ViewMainForm.Show;

  Application.Run;
end.
