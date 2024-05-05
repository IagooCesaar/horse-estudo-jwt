unit ValidaJwt.Model.Usuario.Test;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  ValidaJwtModelUsuarioTest = class
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

    [Test]
    procedure Test_NaoCriarUsuario_EmailExistente;
  end;

implementation

uses
  System.JSON,
  System.SysUtils,
  System.StrUtils,

  Horse,
  Horse.Exception,
  Horse.JsonInterceptor.Helpers,

  ValidaJwt.Model.Factory,
  ValidaJwt.Dto.Req.ManutUsuario;

{ ValidaJwtModelUsuarioTest }

function ValidaJwtModelUsuarioTest.RepeteString(ATexto: string; AQtd: Integer): string;
begin
  Result := '';
  for var I := 1 to AQtd
  do Result := Result + ATexto;
end;

procedure ValidaJwtModelUsuarioTest.Test_CriarUsuario;
begin
  var LDto := TValidaJwtDtoReqCriarUsuario.Create;
  LDto.Nome := 'Nome do Usuário';
  LDto.Email := 'email@dominio.com';
  LDto.Senha := 'senha-complexa';

  var LUsuario := TValidaJwtModelFactory.New
    .Usuario
    .CriarUsuario(LDto);

  Assert.IsTrue(Assigned(LUsuario), 'Usuário não cadastrado');
  Assert.IsTrue(LUsuario.Id >0, 'Não foi gerado ID para o usuário');
  Assert.AreEqual(LDto.Nome, LUsuario.Nome);
  Assert.AreEqual(LDto.Email, LUsuario.Email);

  LDto.Free;
  LUsuario.Free;
end;

procedure ValidaJwtModelUsuarioTest.Test_NaoCriarUsuario(
  ANome, AEmail, ASenha, AErro: string;
  ARepeteNome, ARepeteEmail, ARepeteSenha: Integer
);
begin
  var LJson := TJSONObject.Create;

  if ANome <> ''
  then LJson.AddPair('nome', RepeteString(ANome, ARepeteNome));

  if AEmail <> ''
  then LJson.AddPair('email', RepeteString(AEmail, ARepeteEmail));

  if ASenha <> ''
  then LJson.AddPair('senha', RepeteString(ASenha, ARepeteSenha));

  var LDto := TJson.ClearJsonAndConvertToObject
    <TValidaJwtDtoReqCriarUsuario>(LJson);
  try
    Assert.WillRaiseWithMessageRegex(
      procedure begin
        TValidaJwtModelFactory.New
          .Usuario
          .CriarUsuario(LDto)
      end,
      EHorseException,
      AErro
    );
  finally
    LJson.Free;
    LDto.Free;
  end;
end;

procedure ValidaJwtModelUsuarioTest.Test_NaoCriarUsuario_EmailExistente;
begin
  var LDto := TValidaJwtDtoReqCriarUsuario.Create;
  LDto.Nome := 'Nome do Usuário';
  LDto.Email := 'email_existente@dominio.com';
  LDto.Senha := 'senha-complexa';

  var LUsuario := TValidaJwtModelFactory.New
    .Usuario
    .CriarUsuario(LDto);

  Assert.WillRaiseWithMessageRegex(
    procedure begin
      TValidaJwtModelFactory.New
        .Usuario
        .CriarUsuario(LDto)
    end,
    EHorseException,
    'Já existe um usuário cadastrado com o e-mail'
  );

  LDto.Free;
  LUsuario.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(ValidaJwtModelUsuarioTest);

end.
