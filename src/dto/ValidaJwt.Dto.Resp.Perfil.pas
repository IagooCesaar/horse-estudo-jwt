unit ValidaJwt.Dto.Resp.Perfil;

interface

uses
  System.Generics.Collections;

type
  TValidaJwtDtoRespPerfil = class
  private
    FId: Integer;
    FNome: string;
    FEmail: string;
    FDataCriacao: TDateTime;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
    property DataCriacao: TDateTime read FDataCriacao write FDataCriacao;
  end;

  TValidaJwtDtoRespPerfilLista = TObjectList<TValidaJwtDtoRespPerfil>;

implementation

end.

