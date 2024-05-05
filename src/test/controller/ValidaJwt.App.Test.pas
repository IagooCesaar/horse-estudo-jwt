unit ValidaJwt.App.Test;

interface

uses
  App,
  RESTRequest4D,
  ValidaJwt.Dto.Resp.ApiError;

type
  TValidaJwtAppTest = class
  private
    FApp: TApp;
    class var FApiTest: TValidaJwtAppTest;
  public
    constructor Create;
    destructor Destroy; override;

    function PreparaRequest: IRequest;
    function ParteError(ABody: string): TValidaJwtDTORespApiError;

    class destructor UnInitialize;
    class function GetInstance: TValidaJwtAppTest;
  end;

implementation

uses
  System.SysUtils,
  Horse.JsonInterceptor.Helpers;

{ TValidaJwtAppTest }

constructor TValidaJwtAppTest.Create;
begin
  FApp := TApp.Create;
  FApp.Start(9001);
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

class function TValidaJwtAppTest.GetInstance: TValidaJwtAppTest;
begin
  if not Assigned(FApiTest)
  then FApiTest := TValidaJwtAppTest.Create;
  Result := FApiTest;
end;

function TValidaJwtAppTest.ParteError(ABody: string): TValidaJwtDTORespApiError;
begin
  Result := TJson.ClearJsonAndConvertToObject<TValidaJwtDTORespApiError>(ABody);
end;

function TValidaJwtAppTest.PreparaRequest: IRequest;
begin
  Result := TRequest.New
    .BaseURL(FApp.BaseURL);
end;

class destructor TValidaJwtAppTest.UnInitialize;
begin
  if Assigned(FApiTest)
  then FreeAndNil(FApiTest);
end;

end.
