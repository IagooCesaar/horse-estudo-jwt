unit ValidaJwt.Model.Interfaces;

interface

uses
  ValidaJwt.Dto.Req.ManutUsuario,
  ValidaJwt.Dto.Resp.Perfil,
  ValidaJwt.Dto.Resp.Autenticacao;

type
  IValidaJwtModelUsuario = interface
    ['{D34FABE8-C65D-4C62-A265-FEF97E427DC9}']
    function CriarUsuario(ADto: TValidaJwtDtoReqCriarUsuario): TValidaJwtDtoRespPerfil;
    function ObterPorId(AId: Integer): TValidaJwtDtoRespPerfil;
    function ObterTodos: TValidaJwtDtoRespPerfilLista;
  end;

  IValidaJwtModelAutenticacao = interface
    ['{A061A150-9F53-46DC-A6CD-0DEF67F407CC}']
    // Criar Sessão (token)
    // Criar refresh token
    // Obter perfil
  end;

  IValidaJwtModelFactory = interface
    ['{5E9C1684-EBC5-4172-8423-F24E8DFC2106}']
    function Usuario: IValidaJwtModelUsuario;
    function Autenticacao: IValidaJwtModelAutenticacao;
  end;

implementation

end.
