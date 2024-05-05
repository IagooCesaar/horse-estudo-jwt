unit ValidaJwt.Model.Autenticacao;

interface

uses
  ValidaJwt.Model.Interfaces,
  ValidaJwt.Dto.Req.Autenticacao,
  ValidaJwt.Dto.Resp.Autenticacao;

type
  TValidaJwtModelAutenticacao = class(TInterfacedObject,
    IValidaJwtModelAutenticacao)
  private
  public
    class function New: IValidaJwtModelAutenticacao;

    { IValidaJwtModelAutenticacao }
    function CriarSessao(ADto: TValidaJwtDtoReqAutenticacao): TValidaJwtDtoRespAutenticacao;
  end;

implementation

uses
  System.SysUtils,

  Horse,
  Horse.Exception,
  Horse.JsonInterceptor.Helpers,

  ValidaJwt.Model.Factory,
  ValidaJwt.Model.Dao.Factory;

{ TValidaJwtModelAutenticacao }

function TValidaJwtModelAutenticacao.CriarSessao(
  ADto: TValidaJwtDtoReqAutenticacao
): TValidaJwtDtoRespAutenticacao;
begin
  var LUsuario := TValidaJwtModelDaoFactory.New
    .Usuario
    .ObterPorEmail(ADto.Email);

  if not Assigned(LUsuario)
  then raise EHorseException.New
    .Status(THTTPStatus.BadRequest)
    .&Unit(Self.UnitName)
    .Error('E-mail ou Senha fornecidos são inválidos');

  if not LUsuario.Senha.Equals(ADto.Senha)
  then raise EHorseException.New
    .Status(THTTPStatus.BadRequest)
    .&Unit(Self.UnitName)
    .Error('E-mail ou Senha fornecidos são inválidos');

  Result := TValidaJwtDtoRespAutenticacao.Create;
  Result.Perfil := TValidaJwtModelFactory.New
    .Usuario
    .ObterPorId(LUsuario.Id);

  Result.Token := 'token';
  Result.RefreshToken := 'refresh-token';

  LUsuario.Free;
end;

class function TValidaJwtModelAutenticacao.New: IValidaJwtModelAutenticacao;
begin
  Result := Self.Create;
end;

end.
