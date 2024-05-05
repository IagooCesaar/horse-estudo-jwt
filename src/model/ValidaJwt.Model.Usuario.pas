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
  end;

implementation

uses
  ValidaJwt.Model.Factory;

{ TValidaJwtModelUsuario }

function TValidaJwtModelUsuario.CriarUsuario(ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtDtoRespPerfil;
begin

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

end.
