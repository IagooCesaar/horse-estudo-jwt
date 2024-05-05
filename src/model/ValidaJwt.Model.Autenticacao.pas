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
  System.DateUtils,
  System.JSON,

  Horse,
  Horse.Exception,
  Horse.JsonInterceptor.Helpers,
  JOSE.Producer,
  JOSE.Core.JWA,

  ValidaJwt.Model.Factory,
  ValidaJwt.Model.Dao.Factory,

  ValidaJwt.Model.Entity.TokenUsuario;

const
  C_TOKEN_KEY = 'chave-secreta';
  C_TOKEN_EXPIRES_IN_MINUTES = 30;

  C_REFRESH_TOKEN_KEY = 'outra-chave-secreta';
  C_REFRESH_TOKEN_EXPIRES_IN_DAYS = 30;

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

  var LDataExpiracao := IncMinute(Now, C_TOKEN_EXPIRES_IN_MINUTES);

  var LJwtToken := TJOSEProcess.New
    .SetIssuer('Delphi ValidaJwt')
    .SetIssuedAt(Now)
    .SetExpiration(Now + 1)
    .SetAlgorithm(TJOSEAlgorithmId.HS256)
    .SetKey(C_TOKEN_KEY)
    .SetSubject(LUsuario.Id.ToString)
    .SetExpiration(LDataExpiracao)
    .Build
    .GetCompactToken;

  var LJwtRefreshToken := TJOSEProcess.New
    .SetIssuer('Delphi ValidaJwt')
    .SetIssuedAt(Now)
    .SetExpiration(Now + 1)
    .SetAlgorithm(TJOSEAlgorithmId.HS256)
    .SetKey(C_TOKEN_KEY)
    .SetSubject(LUsuario.Id.ToString)
    .SetExpiration(IncDay(Now, C_REFRESH_TOKEN_EXPIRES_IN_DAYS))
    .SetCustomClaim('email', LUsuario.Email)
    .Build
    .GetCompactToken;

  Result.Token := LJwtToken;
  Result.RefreshToken := LJwtRefreshToken;

  var LToken := TValidaJwtModelEntityTokenUsuario.Create;
  LToken.IdUsuario := LUsuario.Id;
  LToken.Token := Result.Token;
  LToken.RefreshToken := Result.RefreshToken;
  LToken.DataCricao := Now;
  LToken.DataExpiracao := LDataExpiracao;

  var LTokenUsuario := TValidaJwtModelDaoFactory.New
    .TokenUsuario
    .CriarToken(LToken);

  LUsuario.Free;
  LToken.Free;
  LTokenUsuario.Free;
end;

class function TValidaJwtModelAutenticacao.New: IValidaJwtModelAutenticacao;
begin
  Result := Self.Create;
end;

end.
