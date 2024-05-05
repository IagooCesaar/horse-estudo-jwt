unit ValidaJwt.Model.Autenticacao;

interface

uses
  ValidaJwt.Model.Interfaces,
  ValidaJwt.Dto.Resp.Autenticacao;

type
  TValidaJwtModelAutenticacao = class(TInterfacedObject,
    IValidaJwtModelAutenticacao)
  private
  public
    class function New: IValidaJwtModelAutenticacao;

    { IValidaJwtModelAutenticacao }
  end;

implementation

{ TValidaJwtModelAutenticacao }

class function TValidaJwtModelAutenticacao.New: IValidaJwtModelAutenticacao;
begin
  Result := Self.Create;
end;

end.
