unit ValidaJwt.Model.Usuario.Test;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  ValidaJwtModelUsuarioTest = class
  public
  end;

implementation

uses
  ValidaJwt.Model.Factory;

initialization
  TDUnitX.RegisterTestFixture(ValidaJwtModelUsuarioTest);

end.
