unit ValidaJwt.Model.Dao.Interfaces;

interface

uses
  ValidaJwt.Model.Entity.Usuario,
  ValidaJwt.Model.Entity.TokenUsuario,

  ValidaJwt.Dto.Req.ManutUsuario;

type
  IValidaJwtModelDaoUsuario = interface
    ['{BBA1B307-01B0-43F0-AA4E-3C17C2AAB044}']
    function ObterTodos: TValidaJwtModelEntityUsuarioLista;
    function CriarUsuario(ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtModelEntityUsuario;
    function ObterPorId(AId: Integer): TValidaJwtModelEntityUsuario;
    function ObterPorEmail(AEmail: string): TValidaJwtModelEntityUsuario;
  end;

  IValidaJwtModelDaoTokenUsuario = interface
    ['{8C067757-22F5-4C86-AC8A-AF9616B0ACD3}']
    function CriarToken(AEntity: TValidaJwtModelEntityTokenUsuario): TValidaJwtModelEntityTokenUsuario;
  end;

  IValidaJwtModelDaoFactory = interface
    ['{151C6B74-43D9-4BE8-AFDE-C216A9E90815}']
    function Usuario: IValidaJwtModelDaoUsuario;
    function TokenUsuario: IValidaJwtModelDaoTokenUsuario;
  end;

implementation

end.
