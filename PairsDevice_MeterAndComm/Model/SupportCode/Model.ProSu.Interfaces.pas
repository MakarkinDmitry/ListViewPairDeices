unit Model.ProSu.Interfaces;

interface

uses
  System.Generics.Collections,
  Model.ProSu.InterfaceActions;

type
  INotificationClass = interface
    ['{6CCACF62-760C-42F1-BF68-96F47CE62A14}'] // Press Ctrl+Shift+G to generate it
  end;

  TUpdateSubscriberMethod = procedure (const notifyClass: INotificationClass) of object;

  ISubscriberInterface = interface
  // subscriper - подписчик
    ['{A31B16BF-BA0C-4D41-9DA4-4B366B2D6B16}']
    procedure UpdateSubscriber (const notifyClass: INotificationClass);
    procedure SetUpdateSubscriberMethod (newMethod: TUpdateSubscriberMethod);
  end;

  IProviderInterface = interface
  // provider - поставщик
    ['{BFFBF6F5-9EDB-4657-BE8D-56C3358A00B0}']
    procedure Subscribe (const tmpSubscriber: ISubscriberInterface);
    procedure UnSubscribe (const tmpSubscriber: ISubscriberInterface);
    procedure NotifySubscribers (const notifyClass: INotificationClass);
  end;

implementation

end.
