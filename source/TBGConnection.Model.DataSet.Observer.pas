unit TBGConnection.Model.DataSet.Observer;

interface

uses SysUtils, TBGConnection.Model.Interfaces, System.Generics.Collections, Data.DB,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TConnectionModelDataSetObserver = class
  private
    FLista : TList<ICacheDataSetObserver>;
  public
    constructor Create;
    destructor Destroy; override;
    function AddObserver(Value : ICacheDataSetObserver) : TConnectionModelDataSetObserver;
    function RemoveObserver(Value : ICacheDataSetObserver) : TConnectionModelDataSetObserver;
    function Notify(Value : String) : TConnectionModelDataSetObserver;
  end;

var
  FDataSetObserver : TConnectionModelDataSetObserver;

implementation

{ TConnectionModelDataSetObserver }

function TConnectionModelDataSetObserver.AddObserver(Value : ICacheDataSetObserver) : TConnectionModelDataSetObserver;
begin
  Result := Self;
  FLista.Add(Value);
end;

constructor TConnectionModelDataSetObserver.Create;
begin
  FLista := TList<ICacheDataSetObserver>.Create;
end;

destructor TConnectionModelDataSetObserver.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

function TConnectionModelDataSetObserver.Notify(Value : String) : TConnectionModelDataSetObserver;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Pred(FLista.Count) do
    FLista.Items[I].Update(Value)
end;

function TConnectionModelDataSetObserver.RemoveObserver(Value : ICacheDataSetObserver) : TConnectionModelDataSetObserver;
begin
  Result := Self;
  FLista.Remove(Value);
end;

initialization
  FDataSetObserver := TConnectionModelDataSetObserver.Create;

finalization
  //FDataSetObserver.Free;

end.