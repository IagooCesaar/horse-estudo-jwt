unit ValidaJwt.Controller.Usuario.Test;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TValidaJwtControllerUsuarioTest = class
  public
  end;

implementation

uses
  Horse,
  ValidaJwt.App.Test;

initialization
  TDUnitX.RegisterTestFixture(TValidaJwtControllerUsuarioTest);

end.
