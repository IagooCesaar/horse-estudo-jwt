unit ValidaJwt.Controllers.PrivateRoutes;

interface

uses
  Horse,
  Horse.Commons,
  Horse.JsonInterceptor.Helpers;

procedure Registry(const AContext: string);

implementation

uses
  ValidaJwt.Model.Factory;

const
  C_UNIT_NAME: string = 'ValidaJwt.Controllers.PrivateRoutes';

procedure GetObterUsuarioPorId(Req: THorseRequest; Resp: THorseResponse);
begin
   var LId := Req.Params.Field('id')
    .InvalidFormatMessage('O valor informado não é um inteiro válido')
    .AsInteger;

   var LUsuario := TValidaJwtModelFactory.New
    .Usuario
    .ObterPorId(LId);

   Resp.Status(THTTPStatus.OK).Send(TJson.ObjectToClearJsonValue(LUsuario));

   LUsuario.Free;
end;

procedure GetObterTodosUsuarios(Req: THorseRequest; Resp: THorseResponse);
begin
  var LUsuarios := TValidaJwtModelFactory.New
    .Usuario
    .ObterTodos;

  if not Assigned(LUsuarios)
  then Resp.Status(THTTPStatus.NoContent)
  else begin
    if (LUsuarios.Count = 0)
    then Resp.Status(THTTPStatus.NoContent)
    else Resp.Status(THTTPStatus.OK).Send(TJSON.ObjectToClearJsonValue(LUsuarios));
    LUsuarios.Free;
  end;
end;

procedure Registry(const AContext: string);
begin
  THorse
    .Group.Prefix(AContext + '/usuarios')
    .Get('/:id', GetObterUsuarioPorId)
    .Get('/', GetObterTodosUsuarios)
  ;
end;

end.
