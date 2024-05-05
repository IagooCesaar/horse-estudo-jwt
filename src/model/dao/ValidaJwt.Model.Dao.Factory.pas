unit ValidaJwt.Model.Dao.Factory;

interface

uses
  ValidaJwt.Model.Dao.Interfaces;

type
  TValidaJwtModalDaoFactory = class(TNoRefCountObject,
    IValidaJwtModelDaoFactory)
  private
    class var FFactory: TValidaJwtModalDaoFactory;
  public
    class function New: IValidaJwtModelDaoFactory;
    class destructor UnInitialize;
    { IValidaJwtModelDaoFactory }
  end;

implementation

uses
  System.SysUtils;

{ TValidaJwtModalDaoFactory }

class function TValidaJwtModalDaoFactory.New: IValidaJwtModelDaoFactory;
begin
  if not Assigned(FFactory)
  then FFactory := TValidaJwtModalDaoFactory.Create;

  Result := FFactory;
end;

class destructor TValidaJwtModalDaoFactory.UnInitialize;
begin
  FreeAndNil(FFactory);
end;

end.
