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

  Horse,
  Horse.Exception,
  Horse.JsonInterceptor.Helpers,

  ValidaJwt.Model.Factory,
  ValidaJwt.Model.Dao.Factory,

  ValidaJwt.Model.Entity.TokenUsuario;

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
    .Error('E-mail ou Senha fornecidos s�o inv�lidos');

  if not LUsuario.Senha.Equals(ADto.Senha)
  then raise EHorseException.New
    .Status(THTTPStatus.BadRequest)
    .&Unit(Self.UnitName)
    .Error('E-mail ou Senha fornecidos s�o inv�lidos');

  Result := TValidaJwtDtoRespAutenticacao.Create;
  Result.Perfil := TValidaJwtModelFactory.New
    .Usuario
    .ObterPorId(LUsuario.Id);

  Result.Token := 'token';
  Result.RefreshToken := 'refresh-token';

  var LToken := TValidaJwtModelEntityTokenUsuario.Create;
  LToken.IdUsuario := LUsuario.Id;
  LToken.Token := Result.Token;
  LToken.RefreshToken := Result.RefreshToken;
  LToken.DataCricao := Now;
  LToken.DataExpiracao := IncMinute(Now, 30);

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
