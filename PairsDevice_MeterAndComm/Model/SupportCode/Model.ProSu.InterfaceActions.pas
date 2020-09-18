unit Model.ProSu.InterfaceActions;

interface
type
  TInterfaceAction = (actUpdateDatabaseRim,
                      actWaitStart,
                      actWaitFinish,
                      actCheckBoxMeters
                      );

  TInterfaceActions = set of TInterfaceAction;


  TInterfaceError = (errRangeDate,
                     errNoErrorRangeDate,
                     errNumberMeterNonPositive,
                     errNumberMeterNotNumber,
                     errNoErrorNumberMeter,
                     errNumberCommNonPositive,
                     errNumberCommNotNumber,
                     errNoErrorNumberComm);

  TInterfaceErrors = set of TInterfaceError;

implementation

end.
