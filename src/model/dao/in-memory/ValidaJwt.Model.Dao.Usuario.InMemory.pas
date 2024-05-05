unit ValidaJwt.Model.Dao.Usuario.InMemory;

interface

uses
  ValidaJwt.Model.Dao.Interfaces,
  ValidaJwt.Model.Entity.Usuario,
  ValidaJwt.Dto.Req.ManutUsuario;

type
  TValidaJwtModelDaoUsuarioInMemory = class(TNoRefCountObject,
    IValidaJwtModelDaoUsuario)
  private
    FRepository: TValidaJwtModelEntityUsuarioLista;
    class var FDao: TValidaJwtModelDaoUsuarioInMemory;

    function Clone(ASource: TValidaJwtModelEntityUsuario
      ): TValidaJwtModelEntityUsuario;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetInstance: IValidaJwtModelDaoUsuario;
    class destructor UnInitialize;

    { IValidaJwtModelDaoUsuario }
    function CriarUsuario(ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtModelEntityUsuario;
    function ObterPorId(AId: Integer): TValidaJwtModelEntityUsuario;
    function ObterPorEmail(AEmail: string): TValidaJwtModelEntityUsuario;
  end;

implementation

uses
  System.SysUtils;

{ TValidaJwtModelDaoUsuarioInMemory }

function TValidaJwtModelDaoUsuarioInMemory.Clone(
  ASource: TValidaJwtModelEntityUsuario
): TValidaJwtModelEntityUsuario;
begin
  Result := TValidaJwtModelEntityUsuario.Create;
  Result.Id := ASource.Id;
  Result.Nome := ASource.Nome;
  Result.Email := ASource.Email;
  Result.Senha := ASource.Senha;
  Result.DataCriacao := ASource.DataCriacao;
end;

constructor TValidaJwtModelDaoUsuarioInMemory.Create;
begin
  FRepository := TValidaJwtModelEntityUsuarioLista.Create;
end;

function TValidaJwtModelDaoUsuarioInMemory.CriarUsuario(
  ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtModelEntityUsuario;
var LId: Integer;
begin
  if FRepository.Count = 0
  then LId := 1
  else LId := FRepository.Last.Id + 1;

  FRepository.Add(TValidaJwtModelEntityUsuario.Create);
  FRepository.Last.Id := LId;
  FRepository.Last.Nome := ADto.Nome;
  FRepository.Last.Email := ADto.Email;
  FRepository.Last.Senha := ADto.Senha;
  FRepository.Last.DataCriacao := Now;

  Result := Clone(FRepository.Last);
end;

destructor TValidaJwtModelDaoUsuarioInMemory.Destroy;
begin
  FreeAndNil(FRepository);
  inherited;
end;

class function TValidaJwtModelDaoUsuarioInMemory.GetInstance: IValidaJwtModelDaoUsuario;
begin
  if not Assigned(FDao)
  then FDao := TValidaJwtModelDaoUsuarioInMemory.Create;
  Result := FDao;
end;

function TValidaJwtModelDaoUsuarioInMemory.ObterPorEmail(AEmail: string): TValidaJwtModelEntityUsuario;
begin
  Result := nil;
  for var LUsuario in FRepository
  do begin
    if LUsuario.Email = AEmail
    then Result := Clone(LUsuario);
  end;
end;

function TValidaJwtModelDaoUsuarioInMemory.ObterPorId(AId: Integer): TValidaJwtModelEntityUsuario;
begin
  Result := nil;
  for var LUsuario in FRepository
  do begin
    if LUsuario.Id = AId
    then Result := Clone(LUsuario);
  end;
end;

class destructor TValidaJwtModelDaoUsuarioInMemory.UnInitialize;
begin
  FreeAndNil(FDao);
end;

end.
