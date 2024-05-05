unit ValidaJwt.Model.Dao.TokenUsuario.InMemory;

interface

uses
  ValidaJwt.Model.Dao.Interfaces,
  ValidaJwt.Model.Entity.TokenUsuario;

type
  TValidaJwtModelDaoTokenUsuarioInMemory = class(TNoRefCountObject,
    IValidaJwtModelDaoTokenUsuario)
  private
    FRepository: TValidaJwtModelEntityTokenUsuarioLista;
    class var FDao: TValidaJwtModelDaoTokenUsuarioInMemory;

    function Clone(ASource: TValidaJwtModelEntityTokenUsuario
      ): TValidaJwtModelEntityTokenUsuario;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetInstance: IValidaJwtModelDaoTokenUsuario;
    class destructor UnInitialize;

    { IValidaJwtModelDaoTokenUsuario }
    function CriarToken(AEntity: TValidaJwtModelEntityTokenUsuario): TValidaJwtModelEntityTokenUsuario;

  end;

implementation

uses
  System.SysUtils;

{ TValidaJwtModelDaoUsuarioInMemory }

function TValidaJwtModelDaoTokenUsuarioInMemory.Clone(
  ASource: TValidaJwtModelEntityTokenUsuario
): TValidaJwtModelEntityTokenUsuario;
begin
  Result := TValidaJwtModelEntityTokenUsuario.Create;
  Result.IdUsuario := ASource.IdUsuario;
  Result.Token := ASource.Token;
  Result.RefreshToken := ASource.RefreshToken;
  Result.DataCricao := ASource.DataCricao;
  Result.DataExpiracao := ASource.DataExpiracao;
end;

constructor TValidaJwtModelDaoTokenUsuarioInMemory.Create;
begin
  FRepository := TValidaJwtModelEntityTokenUsuarioLista.Create;
end;

function TValidaJwtModelDaoTokenUsuarioInMemory.CriarToken(
  AEntity: TValidaJwtModelEntityTokenUsuario): TValidaJwtModelEntityTokenUsuario;
begin
  Result := nil;
  FRepository.Add(TValidaJwtModelEntityTokenUsuario.Create);
  FRepository.Last.IdUsuario := AEntity.IdUsuario;
  FRepository.Last.Token := AEntity.Token;
  FRepository.Last.RefreshToken := AEntity.RefreshToken;
  FRepository.Last.DataCricao := Now;
  FRepository.Last.DataExpiracao := AEntity.DataExpiracao;

  Result := Clone(FRepository.Last);
end;

destructor TValidaJwtModelDaoTokenUsuarioInMemory.Destroy;
begin
  FreeAndNil(FRepository);
  inherited;
end;

class function TValidaJwtModelDaoTokenUsuarioInMemory.GetInstance: IValidaJwtModelDaoTokenUsuario;
begin
  if not Assigned(FDao)
  then FDao := TValidaJwtModelDaoTokenUsuarioInMemory.Create;
  Result := FDao;
end;

class destructor TValidaJwtModelDaoTokenUsuarioInMemory.UnInitialize;
begin
  FreeAndNil(FDao);
end;

end.

