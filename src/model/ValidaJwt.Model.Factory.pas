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
    function Autenticacao: IValidaJwtModelAutenticacao;
  end;

implementation

uses
  ValidaJwt.Model.Usuario,
  ValidaJwt.Model.Autenticacao;

{ TValidaJwtModelFactory }

function TValidaJwtModelFactory.Autenticacao: IValidaJwtModelAutenticacao;
begin
  Result := TValidaJwtModelAutenticacao.New;
end;

class function TValidaJwtModelFactory.New: IValidaJwtModelFactory;
begin
  Result := Self.Create;
end;

function TValidaJwtModelFactory.Usuario: IValidaJwtModelUsuario;
begin
  Result := TValidaJwtModelUsuario.New;
end;

end.
