unit App;

interface

type
  TApp = class
  private
    FContext: string;
    FCreatedAt: TDateTime;
    FStartedAt: TDateTime;
    FUsuario: string;
    FSenha: string;

    function GetBaseURL: string;
    function GetEmExecucao: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Start(APort: Integer);
    procedure Stop;

    property Context: string read FContext;
    property BaseURL: string read GetBaseURL;
    property EmExecucao: Boolean read GetEmExecucao;
end;

implementation

{ TApp }

constructor TApp.Create;
begin

end;

destructor TApp.Destroy;
begin

  inherited;
end;

function TApp.GetBaseURL: string;
begin

end;

function TApp.GetEmExecucao: Boolean;
begin

end;

procedure TApp.Start(APort: Integer);
begin

end;

procedure TApp.Stop;
begin

end;

end.
