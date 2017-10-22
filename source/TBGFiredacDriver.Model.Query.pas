unit TBGFiredacDriver.Model.Query;

interface

uses
  TBGConnection.Model.Interfaces, Data.DB, System.Classes, FireDAC.Comp.Client,
  System.SysUtils;

Type
  TFiredacModelQuery = class(TInterfacedObject, iQuery)
    private
      FConexao : TFDConnection;
      FQuery : TFDQuery;
      FDataSource : TDataSource;
      FDataSet : TDataSet;
      FChangeDataSet : TChangeDataSet;
    public
      constructor Create(Conexao : TFDConnection);
      destructor Destroy; override;
      class function New(Conexao : TFDConnection) : iQuery;
      //iQuery
      function Open(aSQL: String): iQuery;
      function ExecSQL(aSQL : String) : iQuery;
      function DataSet : TDataSet; overload;
      function DataSet(Value : TDataSet) : iQuery; overload;
      function DataSource(Value : TDataSource) : iQuery;
      function Fields : TFields;
      function ChangeDataSet(Value : TChangeDataSet) : iQuery;
      function &End: TComponent;
  end;

implementation

{ TFiredacModelQuery }

function TFiredacModelQuery.&End: TComponent;
begin
  Result := FQuery;
end;

function TFiredacModelQuery.ExecSQL(aSQL: String): iQuery;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(aSQL);
  FQuery.ExecSQL;
end;

function TFiredacModelQuery.Fields: TFields;
begin
  Result := FQuery.Fields;
end;

function TFiredacModelQuery.ChangeDataSet(Value: TChangeDataSet): iQuery;
begin
  Result := Self;
  FChangeDataSet := Value;
end;

constructor TFiredacModelQuery.Create(Conexao : TFDConnection);
begin
  FConexao := Conexao;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
end;

function TFiredacModelQuery.DataSet: TDataSet;
begin
  Result := TDataSet(FQuery);
end;

function TFiredacModelQuery.DataSet(Value: TDataSet): iQuery;
begin
  Result := Self;
  FDataSet := Value;
end;

function TFiredacModelQuery.DataSource(Value : TDataSource) : iQuery;
begin
  Result := Self;
  FDataSource := Value;
end;

destructor TFiredacModelQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

class function TFiredacModelQuery.New(Conexao : TFDConnection) : iQuery;
begin
  Result := Self.Create(Conexao);
end;

function TFiredacModelQuery.Open(aSQL: String): iQuery;
begin

  if not (Assigned(FDataSource) or Assigned(FDataSet))then
    raise Exception.Create('N�o Foi Instanciado um Container DataSet/DataSource');

  if Assigned(FDataSource) then
    FDataSource.DataSet := FQuery;

  if Assigned(FDataSet) then
    FDataSet := FQuery;

  Result := Self;
  FQuery.Close;
  FQuery.Open(aSQL);


end;

end.
