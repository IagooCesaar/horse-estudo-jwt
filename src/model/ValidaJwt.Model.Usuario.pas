unit ValidaJwt.Model.Usuario;

interface

uses
  ValidaJwt.Model.Interfaces,

  ValidaJwt.Model.Entity.Usuario,
  ValidaJwt.Dto.Req.ManutUsuario,
  ValidaJwt.Dto.Resp.Perfil;

type
  TValidaJwtModelUsuario = class(TInterfacedObject,
    IValidaJwtModelUsuario)
  private
    function Mapper(ASource: TValidaJwtModelEntityUsuario): TValidaJwtDtoRespPerfil; overload;
    function Mapper(ALista: TValidaJwtModelEntityUsuarioLista): TValidaJwtDtoRespPerfilLista; overload;
  public
    class function New: IValidaJwtModelUsuario;

    { IValidaJwtModelUsuario }
    function CriarUsuario(ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtDtoRespPerfil;
    function ObterPorId(AId: Integer): TValidaJwtDtoRespPerfil;
    function ObterTodos: TValidaJwtDtoRespPerfilLista;
  end;

implementation

uses
  System.SysUtils,

  Horse,
  Horse.Exception,
  Horse.JsonInterceptor.Helpers,

  ValidaJwt.Model.Dao.Factory;

{ TValidaJwtModelUsuario }

function TValidaJwtModelUsuario.CriarUsuario(ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtDtoRespPerfil;
begin
  var LVal := TJson.RevalidateSetters
    <TValidaJwtDtoReqCriarUsuario>(ADto);
  LVal.Free;

  var LExisteEmail := TValidaJwtModelDaoFactory.New
    .Usuario
    .ObterPorEmail(ADto.Email);
  try
    if Assigned(LExisteEmail)
    then raise EHorseException.New
      .Status(THTTPStatus.PreconditionFailed)
      .&Unit(Self.UnitName)
      .Error(Format('Já existe um usuário cadastrado com o e-mail %s.', [ADto.Email]));
  finally
    FreeAndNil(LExisteEmail);
  end;

  var LUsuario := TValidaJwtModelDaoFactory.New
    .Usuario
    .CriarUsuario(ADto);

  Result := Mapper(LUsuario);
  LUsuario.Free;
end;

function TValidaJwtModelUsuario.Mapper(
  ALista: TValidaJwtModelEntityUsuarioLista
): TValidaJwtDtoRespPerfilLista;
begin
  Result := TValidaJwtDtoRespPerfilLista.Create;
  for var LUsuario in ALista
  do Result.Add(Mapper(LUsuario));
end;

function TValidaJwtModelUsuario.Mapper(
  ASource: TValidaJwtModelEntityUsuario
): TValidaJwtDtoRespPerfil;
begin
  Result := TValidaJwtDtoRespPerfil.Create;
  Result.Id := ASource.Id;
  Result.Nome := ASource.Nome;
  Result.Email := ASource.Email;
  Result.DataCriacao := ASource.DataCriacao;
end;

class function TValidaJwtModelUsuario.New: IValidaJwtModelUsuario;
begin
  Result := Self.Create;
end;

function TValidaJwtModelUsuario.ObterPorId(AId: Integer): TValidaJwtDtoRespPerfil;
begin
  var LUsuario := TValidaJwtModelDaoFactory.New
    .Usuario
    .ObterPorId(AId);

  if not Assigned(LUsuario)
  then raise EHorseException.New
    .Status(THTTPStatus.NotFound)
    .&Unit(Self.UnitName)
    .Error(Format('Não foi possível encontrar um usuário com o ID %d.', [AId]));

  Result := Mapper(LUsuario);
  LUsuario.Free;
end;

function TValidaJwtModelUsuario.ObterTodos: TValidaJwtDtoRespPerfilLista;
begin
  var LUsuarios := TValidaJwtModelDaoFactory.New
    .Usuario
    .ObterTodos;

  Result := Mapper(LUsuarios);
  LUsuarios.Free;
end;

end.
