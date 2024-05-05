program ValidaPermissaoJWT;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  App in 'src\App.pas';

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
