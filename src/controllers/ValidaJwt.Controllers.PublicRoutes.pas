unit ValidaJwt.Controllers.PublicRoutes;

interface

uses
  Horse,
  Horse.Commons,
  Horse.JsonInterceptor.Helpers;

procedure Registry(const AContext: string);

implementation

uses
  ValidaJwt.Model.Factory,
  ValidaJwt.Dto.Req.ManutUsuario;

const
  C_UNIT_NAME: string = 'ValidaJwt.Controllers.PublicRoutes';

procedure PostCriarUsuario(Req: THorseRequest; Resp: THorseResponse);
begin
  if Req.Body = ''
  then raise EHorseException.New
    .Status(THTTPStatus.BadRequest)
    .&Unit(C_UNIT_NAME)
    .Error('O body não estava no formato esperado');

  var LDto := TJson.ClearJsonAndConvertToObject
    <TValidaJwtDtoReqCriarUsuario>(Req.Body);
  try
    var LTipoSoli := TValidaJwtModelFactory.New
      .Usuario
      .CriarUsuario(LDto);

    Resp.Status(THTTPStatus.Created).Send(TJson.ObjectToClearJsonValue(LTipoSoli));

    LTipoSoli.Free;
  finally
    LDto.Free;
  end;
end;

procedure Registry(const AContext: string);
begin
  THorse
    .Group.Prefix(AContext + '/usuarios')
    .Post('/', PostCriarUsuario)
  ;
end;

end.
