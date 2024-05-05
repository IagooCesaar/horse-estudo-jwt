unit ValidaJwt.Model.Factory;

interface

uses
  ValidaJwt.Model.Interfaces;

type
  TValidaJwtModelFactory = class(TInterfacedObject,
    IValidaJwtModelFactory)
  public
    class function New: IValidaJwtModelFactory;

    { IValidaJwtModelFactory }
  end;

implementation

{ TValidaJwtModelFactory }

class function TValidaJwtModelFactory.New: IValidaJwtModelFactory;
begin
  Result := Self.Create;
end;

end.
