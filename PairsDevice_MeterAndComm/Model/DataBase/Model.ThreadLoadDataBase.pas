unit Model.ThreadLoadDataBase;

interface

uses
  System.Classes, System.Generics.Collections,
  Model.DataBase.Interfaces, Model.DMDataBaseRim, Model.Declarations;

type
  TThreadDataBaseRim = class(TThread)
  private
    { Private declarations }
    fDatabaseRim: IDataBaseInterface;
  protected
    procedure Execute; override;
  public
     property DataBaseRim: IDataBaseInterface read fDataBaseRim
                                              write fDataBaseRim;
  end;

implementation

uses Model.Main.Interfaces, View.Main;

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure ThreadDataBaseRim.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ ThreadDataBaseRim }

procedure TThreadDataBaseRim.Execute;
var
  tmpPairDevice: TPairDevice;
begin
  { Place thread code here }
  if Assigned(fDataBaseRim) then
  begin
    fDatabaseRim.PairDeviceList.Clear;

    With DMDatabaseRim.SQLDataSetFromRim do
    begin
      Close;
      ParamByName('FromDate').AsDateTime := fDataBaseRim.FromDate;
      ParamByName('ToDate').AsDateTime := fDataBaseRim.ToDate;

      Open;
      First;
      while not Eof do
      begin
        tmpPairDevice := TPairDevice.Create;

        tmpPairDevice.PersonFIO := Fields[1].AsString; // PersonFIO
        tmpPairDevice.Date := copy(Fields[0].AsString,1,10); // date_operation
        tmpPairDevice.Time := copy(Fields[0].AsString,12,19); // date_operation

        tmpPairDevice.TypeMeter := Fields[2].AsString; // type_meter
        tmpPairDevice.NameMeter := Fields[3].AsString; // name_meter
        tmpPairDevice.NumberMeter := Fields[4].AsInteger; // number_meter
        tmpPairDevice.VersionMeter := Fields[5].AsString; // version_meter

        tmpPairDevice.TypeComm := Fields[6].AsString; // type_comm
        tmpPairDevice.NameComm := Fields[7].AsString; // name_comm
        tmpPairDevice.NumberComm := Fields[8].AsInteger; // number_comm
        tmpPairDevice.VersionComm := Fields[9].AsString; // version_comm

        {if Fields[9].AsString = 'True' then //success
          tmpPairDevice.Success := 'Годен'
        else
          tmpPairDevice.Success := 'Брак';}

        fDataBaseRim.PairDeviceList.Add(tmpPairDevice);
        Next;
      end;
      Close;
    end;

    ViewMainForm.UpdateListView;
  end;
end;

end.
