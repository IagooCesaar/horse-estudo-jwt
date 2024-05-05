unit ValidaJwt.Controller.Usuario.Test;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TValidaJwtControllerUsuarioTest = class
  private
    function RepeteString(ATexto: string; AQtd: Integer): string;

  public
    [Test]
    procedure Test_CriarUsuario;

    [Test]
    [TestCase('Não criar com Nome com quantidade de caracterers < min',
      'A,teste@teste.com,abc123,O nome deverá ter no mínimo,4,1,1')]
    [TestCase('Não criar com Nome com quantidade de caracterers < min',
      'Teste,teste@teste.com,abc123,O nome deverá ter no máximo,101,1,1')]

    [TestCase('Não criar com E-mail com quantidade de caracterers < min',
      'Teste,A,abc123,O e-mail deverá ter no mínimo,1,6,1')]
    [TestCase('Não criar com E-mail com quantidade de caracterers > max',
      'Teste,A,abc123,O e-mail deverá ter no máximo,1,251,1')]

    [TestCase('Não criar com Senha com quantidade de caracterers < min',
      'Teste,teste@teste.com,S,A senha deverá ter no mínimo,1,1,4')]
    [TestCase('Não criar com Senha com quantidade de caracterers > max',
      'Teste,teste@teste.com,S,A senha deverá ter no máximo,1,1,101')]

    procedure Test_NaoCriarUsuario(
      ANome, AEmail, ASenha, AErro: string;
      ARepeteNome, ARepeteEmail, ARepeteSenha: Integer
    );
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

function TValidaJwtControllerUsuarioTest.RepeteString(ATexto: string; AQtd: Integer): string;
begin
  Result := '';
  for var I := 1 to AQtd
  do Result := Result + ATexto;
end;

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

procedure TValidaJwtControllerUsuarioTest.Test_NaoCriarUsuario(ANome, AEmail, ASenha, AErro: string; ARepeteNome,
  ARepeteEmail, ARepeteSenha: Integer);
begin
  var LJson := TJSONObject.Create; // Próprio RestRequest irá destruir

  if ANome <> ''
  then LJson.AddPair('nome', RepeteString(ANome, ARepeteNome));

  if AEmail <> ''
  then LJson.AddPair('email', RepeteString(AEmail, ARepeteEmail));

  if ASenha <> ''
  then LJson.AddPair('senha', RepeteString(ASenha, ARepeteSenha));

  var LResponse := TValidaJwtAppTest.GetInstance
    .PreparaRequest
    .Resource('/usuarios')
    .AddBody(LJson)
    .Post();

  Assert.AreEqual(THTTPStatus.PreconditionFailed, THTTPStatus(LResponse.StatusCode));

  var LError := TValidaJwtAppTest.GetInstance.ParteError(LResponse.Content);
  Assert.Contains(LError.error, AErro);
  LError.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TValidaJwtControllerUsuarioTest);

end.
