program ValidaPermissaoJWT_Test;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  ValidaJwt.Model.Usuario.Test in 'src\test\model\ValidaJwt.Model.Usuario.Test.pas',
  ValidaJwt.Controllers.AuthenticationRoutes in 'src\controllers\ValidaJwt.Controllers.AuthenticationRoutes.pas',
  ValidaJwt.Controllers.PrivateRoutes in 'src\controllers\ValidaJwt.Controllers.PrivateRoutes.pas',
  ValidaJwt.Controllers.PublicRoutes in 'src\controllers\ValidaJwt.Controllers.PublicRoutes.pas',
  ValidaJwt.Controllers.Registry in 'src\controllers\ValidaJwt.Controllers.Registry.pas',
  ValidaJwt.Dto.Req.ManutUsuario in 'src\dto\ValidaJwt.Dto.Req.ManutUsuario.pas',
  ValidaJwt.Dto.Resp.Perfil in 'src\dto\ValidaJwt.Dto.Resp.Perfil.pas',
  ValidaJwt.Model.Factory in 'src\model\ValidaJwt.Model.Factory.pas',
  ValidaJwt.Model.Interfaces in 'src\model\ValidaJwt.Model.Interfaces.pas',
  ValidaJwt.Model.Usuario in 'src\model\ValidaJwt.Model.Usuario.pas',
  ValidaJwt.Model.Dao.Factory in 'src\model\dao\ValidaJwt.Model.Dao.Factory.pas',
  ValidaJwt.Model.Dao.Interfaces in 'src\model\dao\ValidaJwt.Model.Dao.Interfaces.pas',
  ValidaJwt.Model.Dao.TokenUsuario.InMemory in 'src\model\dao\in-memory\ValidaJwt.Model.Dao.TokenUsuario.InMemory.pas',
  ValidaJwt.Model.Dao.Usuario.InMemory in 'src\model\dao\in-memory\ValidaJwt.Model.Dao.Usuario.InMemory.pas',
  ValidaJwt.Model.Entity.TokenUsuario in 'src\model\entity\ValidaJwt.Model.Entity.TokenUsuario.pas',
  ValidaJwt.Model.Entity.Usuario in 'src\model\entity\ValidaJwt.Model.Entity.Usuario.pas',
  App in 'src\App.pas',
  ValidaJwt.Controller.Usuario.Test in 'src\test\controller\ValidaJwt.Controller.Usuario.Test.pas',
  ValidaJwt.App.Test in 'src\test\controller\ValidaJwt.App.Test.pas',
  ValidaJwt.Dto.Resp.ApiError in 'src\dto\ValidaJwt.Dto.Resp.ApiError.pas';

{ keep comment here to protect the following conditional from being removed by the IDE when adding a unit }
{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}

{$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := True;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    TDUnitX.Options.ExitBehavior := TDUnitXExitBehavior.Pause;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
