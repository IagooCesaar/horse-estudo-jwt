program ValidaPermissaoJWT;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  App in 'src\App.pas',
  ValidaJwt.Controllers.Registry in 'src\controllers\ValidaJwt.Controllers.Registry.pas',
  ValidaJwt.Controllers.PrivateRoutes in 'src\controllers\ValidaJwt.Controllers.PrivateRoutes.pas',
  ValidaJwt.Controllers.AuthenticationRoutes in 'src\controllers\ValidaJwt.Controllers.AuthenticationRoutes.pas',
  ValidaJwt.Controllers.PublicRoutes in 'src\controllers\ValidaJwt.Controllers.PublicRoutes.pas';

var LApp: TApp;
begin
  try
    try
      LApp := TApp.Create;
      LApp.Start(9000);
    finally
      LApp.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
