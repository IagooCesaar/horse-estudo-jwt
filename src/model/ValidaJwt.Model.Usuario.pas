unit ValidaJwt.Model.Usuario;

interface

uses
  ValidaJwt.Model.Interfaces;

type
  TValidaJwtModelUsuario = class(TInterfacedObject,
    IValidaJwtModelUsuario)
  public
    class function New: IValidaJwtModelUsuario;

    { IValidaJwtModelUsuario }
  end;

implementation

uses
  ValidaJwt.Model.Factory;

{ TValidaJwtModelUsuario }

class function TValidaJwtModelUsuario.New: IValidaJwtModelUsuario;
begin
  Result := Self.Create;
end;

end.
