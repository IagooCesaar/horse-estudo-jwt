unit ValidaJwt.Dto.Req.Autenticacao;

interface

type
  TValidaJwtDtoReqAutenticacao = class
  private
    FEmail: string;
    FSenha: string;
  public
    property Email: string read FEmail write FEmail;
    property Senha: string read FSenha write FSenha;
  end;

implementation

end.
