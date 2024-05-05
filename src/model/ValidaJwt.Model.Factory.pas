unit ValidaJwt.Model.Factory;

interface

uses
  ValidaJwt.Model.Interfaces;

type
  TValidaJwtModelFactory = class(TInterfacedObject,
    IValidaJwtModelFactory)
  public
    class function New: IValidaJwtModelFactory;

    { IValidaJwtModelFactory }
    function Usuario: IValidaJwtModelUsuario;
  end;

implementation

uses
  ValidaJwt.Model.Usuario;

{ TValidaJwtModelFactory }

class function TValidaJwtModelFactory.New: IValidaJwtModelFactory;
begin
  Result := Self.Create;
end;

function TValidaJwtModelFactory.Usuario: IValidaJwtModelUsuario;
begin
  Result := TValidaJwtModelUsuario.New;
end;

end.
