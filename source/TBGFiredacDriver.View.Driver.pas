unit TBGFiredacDriver.View.Driver;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, TBGConnection.Model.Conexao.Parametros,
  FireDAC.Comp.Client, System.Generics.Collections;

Type
  TBGFiredacDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TFDConnection;
    FFQuery: TFDQuery;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    procedure SetFConnection(const Value: TFDConnection);
    procedure SetFQuery(const Value: TFDQuery);
    protected
      FParametros : iConexaoParametros;
      function Conexao : iConexao;
      function Query : iQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDriver;
      function Conectar : iConexao;
      function &End: TComponent;
      function Parametros: iConexaoParametros;

    published
      property FConnection : TFDConnection read FFConnection write SetFConnection;
  end;

procedure Register;

implementation

uses
  TBGFiredacDriver.Model.Conexao, TBGFiredacDriver.Model.Query,
  System.SysUtils;

{ TBGFiredacDriverConexao }

function TBGFiredacDriverConexao.Conectar: iConexao;
begin

end;

function TBGFiredacDriverConexao.&End: TComponent;
begin

end;

function TBGFiredacDriverConexao.Conexao: iConexao;
begin
  FiConexao := TFiredacDriverModelConexao.New(FFConnection);
  Result := FiConexao;
end;

constructor TBGFiredacDriverConexao.Create;
begin
  FiQuery := TList<iQuery>.Create;
end;

destructor TBGFiredacDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

class function TBGFiredacDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGFiredacDriverConexao.Parametros: iConexaoParametros;
begin
  Result := FParametros;
end;


function TBGFiredacDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  FiQuery.Add(TFiredacModelQuery.New(FFConnection));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGFiredacDriverConexao.SetFConnection(const Value: TFDConnection);
begin
  FFConnection := Value;
end;

procedure TBGFiredacDriverConexao.SetFQuery(const Value: TFDQuery);
begin
  FFQuery := Value;
end;

procedure Register;
begin
  RegisterComponents('TBGConnection', [TBGFiredacDriverConexao]);
end;


end.
