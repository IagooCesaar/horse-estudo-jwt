program ValidaPermissaoJWT;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  App in 'src\App.pas',
  ValidaJwt.Controllers.Registry in 'src\controllers\ValidaJwt.Controllers.Registry.pas',
  ValidaJwt.Controllers.PrivateRoutes in 'src\controllers\ValidaJwt.Controllers.PrivateRoutes.pas',
  ValidaJwt.Controllers.AuthenticationRoutes in 'src\controllers\ValidaJwt.Controllers.AuthenticationRoutes.pas',
  ValidaJwt.Controllers.PublicRoutes in 'src\controllers\ValidaJwt.Controllers.PublicRoutes.pas',
  ValidaJwt.Model.Entity.Usuario in 'src\model\entity\ValidaJwt.Model.Entity.Usuario.pas',
  ValidaJwt.Dto.Resp.Perfil in 'src\dto\ValidaJwt.Dto.Resp.Perfil.pas',
  ValidaJwt.Model.Entity.TokenUsuario in 'src\model\entity\ValidaJwt.Model.Entity.TokenUsuario.pas',
  ValidaJwt.Model.Interfaces in 'src\model\ValidaJwt.Model.Interfaces.pas',
  ValidaJwt.Model.Factory in 'src\model\ValidaJwt.Model.Factory.pas',
  ValidaJwt.Model.Dao.Factory in 'src\model\dao\ValidaJwt.Model.Dao.Factory.pas',
  ValidaJwt.Model.Dao.Interfaces in 'src\model\dao\ValidaJwt.Model.Dao.Interfaces.pas',
  ValidaJwt.Model.Dao.Usuario.InMemory in 'src\model\dao\in-memory\ValidaJwt.Model.Dao.Usuario.InMemory.pas',
  ValidaJwt.Model.Dao.TokenUsuario.InMemory in 'src\model\dao\in-memory\ValidaJwt.Model.Dao.TokenUsuario.InMemory.pas',
  ValidaJwt.Model.Usuario in 'src\model\ValidaJwt.Model.Usuario.pas',
  ValidaJwt.Dto.Req.ManutUsuario in 'src\dto\ValidaJwt.Dto.Req.ManutUsuario.pas',
  ValidaJwt.Dto.Resp.ApiError in 'src\dto\ValidaJwt.Dto.Resp.ApiError.pas',
  ValidaJwt.Model.Autenticacao in 'src\model\ValidaJwt.Model.Autenticacao.pas',
  ValidaJwt.Dto.Resp.Autenticacao in 'src\dto\ValidaJwt.Dto.Resp.Autenticacao.pas',
  ValidaJwt.Dto.Req.Autenticacao in 'src\dto\ValidaJwt.Dto.Req.Autenticacao.pas';

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
