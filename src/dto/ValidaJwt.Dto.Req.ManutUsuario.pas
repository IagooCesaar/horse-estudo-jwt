unit ValidaJwt.Dto.Req.ManutUsuario;

interface

type
  TValidaJwtDtoReqAtualizarUsuario = class
  private
    FSenha: string;
    function GetSenha: string;
    procedure SetSenha(const Value: string);
  public
    property Senha: string read GetSenha write SetSenha;
  end;

  TValidaJwtDtoReqCriarUsuario = class(TValidaJwtDtoReqAtualizarUsuario)
  private
    FNome: string;
    FEmail: string;
    function GetNome: string;
    procedure SetNome(const Value: string);
    function GetEmail: string;
    procedure SetEmail(const Value: string);
  public
    property Nome: string read GetNome write SetNome;
    property Email: string read GetEmail write SetEmail;
  end;


implementation

uses
  Horse,
  Horse.Exception,
  System.SysUtils;

const
  C_QTD_MIN_NOME = 5;
  C_QTD_MAX_NOME = 100;
  C_QTD_MIN_EMAIL = 7;
  C_QTD_MAX_EMAIL = 250;
  C_QTD_MIN_SENHA = 5;
  C_QTD_MAX_SENHA = 100;

{ TValidaJwtDtoReqAtualizarUsuario }

function TValidaJwtDtoReqAtualizarUsuario.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TValidaJwtDtoReqAtualizarUsuario.SetSenha(const Value: string);
begin
  if Value.Length < C_QTD_MIN_SENHA
  then raise EHorseException.New
    .Status(THTTPStatus.PreconditionFailed)
    .&Unit(Self.UnitName)
    .Error(Format('A senha deverá ter no mínimo %d caracteres', [C_QTD_MIN_SENHA]));

  if Value.Length > C_QTD_MAX_SENHA
  then raise EHorseException.New
    .Status(THTTPStatus.PreconditionFailed)
    .&Unit(Self.UnitName)
    .Error(Format('A senha deverá ter no máximo %d caracteres', [C_QTD_MAX_SENHA]));

  FSenha := Value;
end;

{ TValidaJwtDtoReqCriarUsuario }

function TValidaJwtDtoReqCriarUsuario.GetEmail: string;
begin
  Result := FEmail;
end;

function TValidaJwtDtoReqCriarUsuario.GetNome: string;
begin
  Result := FNome;
end;

procedure TValidaJwtDtoReqCriarUsuario.SetEmail(const Value: string);
begin
  if Value.Length < C_QTD_MIN_EMAIL
  then raise EHorseException.New
    .Status(THTTPStatus.PreconditionFailed)
    .&Unit(Self.UnitName)
    .Error(Format('O e-mail deverá ter no mínimo %d caracteres', [C_QTD_MIN_EMAIL]));

  if Value.Length > C_QTD_MAX_EMAIL
  then raise EHorseException.New
    .Status(THTTPStatus.PreconditionFailed)
    .&Unit(Self.UnitName)
    .Error(Format('O e-mail deverá ter no máximo %d caracteres', [C_QTD_MAX_EMAIL]));

  FEmail := Value;
end;

procedure TValidaJwtDtoReqCriarUsuario.SetNome(const Value: string);
begin
  if Value.Length < C_QTD_MIN_NOME
  then raise EHorseException.New
    .Status(THTTPStatus.PreconditionFailed)
    .&Unit(Self.UnitName)
    .Error(Format('O nome deverá ter no mínimo %d caracteres', [C_QTD_MIN_NOME]));

  if Value.Length > C_QTD_MAX_NOME
  then raise EHorseException.New
    .Status(THTTPStatus.PreconditionFailed)
    .&Unit(Self.UnitName)
    .Error(Format('O nome deverá ter no máximo %d caracteres', [C_QTD_MAX_NOME]));

  FNome := Value;
end;

end.
