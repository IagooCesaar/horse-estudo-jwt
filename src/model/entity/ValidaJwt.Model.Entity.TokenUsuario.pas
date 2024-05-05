unit ValidaJwt.Model.Entity.TokenUsuario;

interface

uses
  System.Generics.Collections;

type
  TValidaJwtModelEntityTokenUsuario = class
  private
    FIdUsuario: Integer;
    FToken: string;
    FRefreshToken: string;
    FDataCricao: TDateTime;
    FDataExpiracao: TDateTime;
  public
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property Token: string read FToken write FToken;
    property RefreshToken: string read FRefreshToken write FRefreshToken;
    property DataCricao: TDateTime read FDataCricao write FDataCricao;
    property DataExpiracao: TDateTime read FDataExpiracao write FDataExpiracao;
  end;

implementation

{ TValidaJwtModelEntityTokenUsuario }

end.
