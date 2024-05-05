unit ValidaJwt.Model.Entity.Usuario;

interface

uses
  System.Generics.Collections;

type
  TValidaJwtModelEntityUsuario = class
  private
    FId: Integer;
    FNome: string;
    FEmail: string;
    FSenha: string;
    FDataCriacao: TDateTime;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
    property Senha: string read FSenha write FSenha;
    property DataCriacao: TDateTime read FDataCriacao write FDataCriacao;
  end;

  TValidaJwtModelEntityUsuarioLista = TObjectList<TValidaJwtModelEntityUsuario>;

implementation

end.
