unit ValidaJwt.Model.Usuario.Test;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  ValidaJwtModelUsuarioTest = class
  public

    [Test]
    procedure Test_CriarUsuario;
  end;

implementation

uses
  ValidaJwt.Model.Factory,
  ValidaJwt.Dto.Req.ManutUsuario;

{ ValidaJwtModelUsuarioTest }

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

initialization
  TDUnitX.RegisterTestFixture(ValidaJwtModelUsuarioTest);

end.
