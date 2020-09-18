unit Model.DataBase;

interface

uses
  Model.Database.Interfaces;

  function CreateDatabaseClass: IDatabaseInterface;

implementation

uses System.SysUtils, System.DateUtils, System.Generics.Collections,
Model.DMDataBaseRim, Model.Declarations;

type
  TDataBase = class (TInterfacedObject, IDataBaseInterface)
    private
      fFromDate,
      fToDate: TDateTime;
      fPairDeviceList: TOBjectList<TPairDevice>;

      function GetFromDate: TDateTime;
      procedure SetFromDate(const newFromDate: TDateTime);
      function GetToDate: TDateTime;
      procedure SetToDate(const newToDate: TDateTime);
      function GetPairDeviceList: TOBjectList<TPairDevice>;
      Procedure SetPairDeviceList(const newPairDeviceList: TOBjectList<TPairDevice>);

    public
      constructor Create;
      //destructor Destroy; override;

      property FromDate: TDateTime read GetFromDate write SetFromDate;
      property ToDate: TDateTime read GetToDate write SetToDate;
      property PairDeviceList: TOBjectList<TPairDevice> read GetPairDeviceList
                                                        write SetPairDeviceList;
  end;

function CreateDataBaseClass: IDataBaseInterface;
begin
  result := TDataBase.Create;
end;

{ TDataBase }
constructor TDataBase.Create;
begin
  inherited;
  fPairDeviceList := TObjectList<TPairDevice>.Create;
end;

{destructor TDataBase.Destroy;
begin
  fPairDeviceList.Free;
  inherited;
end;}

function TDataBase.GetFromDate: TDateTime;
begin
  Result := fFromDate;
end;

function TDataBase.GetPairDeviceList: TOBjectList<TPairDevice>;
begin
  Result := fPairDeviceList;
end;

function TDataBase.GetToDate: TDateTime;
begin
  Result := fToDate;
end;

procedure TDataBase.SetFromDate(const newFromDate: TDateTime);
begin
  fFromDate := newfromDate;
end;

procedure TDataBase.SetPairDeviceList(
                             const newPairDeviceList: TOBjectList<TPairDevice>);
begin
  fPairDeviceList := newPairDeviceList;
end;

procedure TDataBase.SetToDate(const newToDate: TDateTime);
begin
  fToDate := newToDate;
end;

end.
