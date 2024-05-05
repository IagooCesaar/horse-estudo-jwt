unit ValidaJwt.Dto.Req.ManutUsuario;

interface

type
  TValidaJwtDtoReqAtualizarUsuario = class
  private
    FSenha: string;
  public
    property Senha: string read FSenha write FSenha;
  end;

  TValidaJwtDtoReqCriarUsuario = class(TValidaJwtDtoReqAtualizarUsuario)
  private
    FNome: string;
    FEmail: string;
  public
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
  end;


implementation

end.
