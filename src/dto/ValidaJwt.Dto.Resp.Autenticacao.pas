unit ValidaJwt.Dto.Resp.Autenticacao;

interface

uses
  ValidaJwt.Dto.Resp.Perfil;

type
  TValidaJwtDtoRespAutenticacao = class
  private
    FToken: string;
    FRefreshToken: string;
    FPerfil: TValidaJwtDtoRespPerfil;
  public
    property Token: string read FToken write FToken;
    property RefreshToken: string read FRefreshToken write FRefreshToken;
    property Perfil: TValidaJwtDtoRespPerfil read FPerfil write FPerfil;
  end;

implementation

end.
