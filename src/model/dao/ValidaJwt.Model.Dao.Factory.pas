unit ValidaJwt.Model.Dao.Factory;

interface

uses
  ValidaJwt.Model.Dao.Interfaces;

type
  TValidaJwtModelDaoFactory = class(TNoRefCountObject,
    IValidaJwtModelDaoFactory)
  private
    class var FFactory: TValidaJwtModelDaoFactory;
  public
    class function New: IValidaJwtModelDaoFactory;
    class destructor UnInitialize;

    { IValidaJwtModelDaoFactory }
    function Usuario: IValidaJwtModelDaoUsuario;
    function TokenUsuario: IValidaJwtModelDaoTokenUsuario;
  end;

implementation

uses
  System.SysUtils,

  ValidaJwt.Model.Dao.Usuario.InMemory,
  ValidaJwt.Model.Dao.TokenUsuario.InMemory;

{ TValidaJwtModalDaoFactory }

class function TValidaJwtModelDaoFactory.New: IValidaJwtModelDaoFactory;
begin
  if not Assigned(FFactory)
  then FFactory := TValidaJwtModelDaoFactory.Create;

  Result := FFactory;
end;

function TValidaJwtModelDaoFactory.TokenUsuario: IValidaJwtModelDaoTokenUsuario;
begin
  Result := TValidaJwtModelDaoTokenUsuarioInMemory.GetInstance;
end;

class destructor TValidaJwtModelDaoFactory.UnInitialize;
begin
  FreeAndNil(FFactory);
end;

function TValidaJwtModelDaoFactory.Usuario: IValidaJwtModelDaoUsuario;
begin
  Result := TValidaJwtModelDaoUsuarioInMemory.GetInstance;
end;

end.
