unit ValidaJwt.Controller.Usuario.Test;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TValidaJwtControllerUsuarioTest = class
  public

    [Test]
    procedure Test_CriarUsuario;
  end;

implementation

uses
  System.JSON,
  System.SysUtils,
  System.StrUtils,

  Horse,
  Horse.Exception,
  Horse.JsonInterceptor.Helpers,

  ValidaJwt.App.Test,
  ValidaJwt.Model.Factory,
  ValidaJwt.Dto.Req.ManutUsuario;

{ TValidaJwtControllerUsuarioTest }

procedure TValidaJwtControllerUsuarioTest.Test_CriarUsuario;
begin
  var LDto := TValidaJwtDtoReqCriarUsuario.Create;
  LDto.Nome := 'Nome do Usuário';
  LDto.Email := 'email-controller@dominio.com';
  LDto.Senha := 'senha-complexa';

  var LResponse := TValidaJwtAppTest.GetInstance
    .PreparaRequest
    .Resource('/usuarios')
    .AddBody(TJson.ObjectToClearJsonObject(LDto))
    .Post();

  Assert.AreEqual(THTTPStatus.Created, THTTPStatus(LResponse.StatusCode));

  LDto.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TValidaJwtControllerUsuarioTest);

end.
