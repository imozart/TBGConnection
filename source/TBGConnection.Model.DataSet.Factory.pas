unit TBGConnection.Model.DataSet.Factory;

interface

uses
  TBGConnection.Model.DataSet.Interfaces, TBGConnection.Model.DataSet.Proxy,
  TBGConnection.Model.Interfaces;

Type
  TConnectionModelDataSetFactory = class(TInterfacedObject, iDataSetFactory)
    private
      FDriver : iDriver;
    public
      constructor Create(Driver : iDriver);
      destructor Destroy; override;
      class function New(Driver : iDriver) : iDataSetFactory;
      function DataSet(Observer : ICacheDataSetSubject): iDataSet;
  end;

implementation

//uses
  //TBGConnection.Model.DataSet;

{ TConnectionModelDataSetFactory }

constructor TConnectionModelDataSetFactory.Create(Driver : iDriver);
begin
  FDriver := Driver;
end;

function TConnectionModelDataSetFactory.DataSet(Observer : ICacheDataSetSubject): iDataSet;
begin
  //Result := FDriver.

  // TConnectionModelDataSet.New(Observer);
  //FDataSetProxy.AddCacheDataSet(Result.GUUID, Result);
end;

destructor TConnectionModelDataSetFactory.Destroy;
begin

  inherited;
end;

class function TConnectionModelDataSetFactory.New(Driver : iDriver) : iDataSetFactory;
begin
  Result := Self.Create(Driver);
end;

end.

