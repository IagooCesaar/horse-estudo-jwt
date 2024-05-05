unit ValidaJwt.Model.Dao.Usuario.InMemory;

interface

uses
  ValidaJwt.Model.Dao.Interfaces,
  ValidaJwt.Model.Entity.Usuario;

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

class destructor TValidaJwtModelDaoUsuarioInMemory.UnInitialize;
begin
  FreeAndNil(FDao);
end;

end.
