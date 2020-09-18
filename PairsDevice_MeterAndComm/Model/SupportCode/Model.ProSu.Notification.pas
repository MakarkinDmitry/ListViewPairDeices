unit Model.ProSu.Notification;

interface

uses Model.ProSu.InterfaceActions, Model.ProSu.Interfaces;

type
  TNotificationClass = class (TInterfacedObject, INotificationClass)
    private
      fActions: TInterfaceActions;
      fActionValue: Double;
    public
      property Actions: TInterfaceActions read fActions
                                          write fActions;
      property ActionValue: double read fActionValue
                                   write fActionValue;
  end;

  TErrorNotificationClass = class (TInterfacedObject, INotificationClass)
  private
    fActions: TInterfaceErrors;
    fActionMessage: String;

  public
    property Actions: TInterfaceerrors read fActions write fActions;
    property ActionMessage: String read fActionMessage write fActionMessage;
  end;

implementation

end.
