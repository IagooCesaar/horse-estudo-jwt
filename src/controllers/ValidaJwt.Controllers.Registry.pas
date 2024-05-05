unit ValidaJwt.Controllers.Registry;

interface

uses
  Horse,
  Horse.Commons;

procedure DoRegistry(const AContext: string);

implementation

uses
  ValidaJwt.Controllers.PrivateRoutes,
  ValidaJwt.Controllers.PublicRoutes,
  ValidaJwt.Controllers.AuthenticationRoutes;

procedure DoRegistry(const AContext: string);
var LContext: string;
begin
  LContext := AContext + '/api';

  ValidaJwt.Controllers.PrivateRoutes.Registry(LContext);
  ValidaJwt.Controllers.PublicRoutes.Registry(LContext);
  ValidaJwt.Controllers.AuthenticationRoutes.Registry(LContext);
end;

end.
