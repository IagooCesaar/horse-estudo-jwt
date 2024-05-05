unit ValidaJwt.App.Test;

interface

uses
  App;

type
  TValidaJwtAppTest = class
  private
    FApp: TApp;

    class var FApiTest: TValidaJwtAppTest;
    function getBaseUrl: string;
  public
    constructor Create;
    destructor Destroy; override;

    property BaseURL: string read getBaseUrl;

    class destructor UnInitialize;
    class function GetInstance: TValidaJwtAppTest;
  end;

implementation

uses
  System.SysUtils;

{ TValidaJwtAppTest }

constructor TValidaJwtAppTest.Create;
begin
  FApp := TApp.Create;
  FApp.Start(9000);
end;

destructor TValidaJwtAppTest.Destroy;
begin
  if Assigned(FApp)
  then begin
    try
      FApp.Stop;
    finally
      FreeAndNil(FApp);
    end;
  end;
  inherited;
end;

function TValidaJwtAppTest.getBaseUrl: string;
begin
  Result := FApp.BaseURL;
end;

class function TValidaJwtAppTest.GetInstance: TValidaJwtAppTest;
begin
  if not Assigned(FApiTest)
  then FApiTest := TValidaJwtAppTest.Create;
  Result := FApiTest;
end;

class destructor TValidaJwtAppTest.UnInitialize;
begin
  if Assigned(FApiTest)
  then FreeAndNil(FApiTest);
end;

end.
