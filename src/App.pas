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

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.Compression,

  ValidaJwt.Controllers.Registry;

{ TApp }

constructor TApp.Create;
begin
  {$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse.MaxConnections := StrToIntDef(GetEnvironmentVariable('MAXCONNECTIONS'), 10000);
  THorse.ListenQueue := StrToIntDef(GetEnvironmentVariable('LISTENQUEUE'), 200);

  THorse
    .Use(Compression())
    .Use(Jhonson('UTF-8'))
    //HandleException deverá ser o último Middleware
    .Use(HandleException);

  ValidaJwt.Controllers.Registry.DoRegistry(FContext);
end;

destructor TApp.Destroy;
begin
  while THorse.IsRunning do begin
    THorse.StopListen;
    Sleep(1000);
  end;
  inherited;
end;

function TApp.GetBaseURL: string;
begin
  Result := Format('http://localhost:%d%s/%s', [THorse.Port, FContext, 'api']);
end;

function TApp.GetEmExecucao: Boolean;
begin
  Result := THorse.IsRunning;
end;

procedure TApp.Start(APort: Integer);
begin
  THorse.Listen(APort,
    procedure begin
      {$IF defined(CONSOLE) and (not defined(TEST))}
      Writeln(Format('Server is runing on %s:%d', [THorse.Host, THorse.Port]));
      Readln;
      {$ENDIF}
    end);
end;

procedure TApp.Stop;
begin
  while THorse.IsRunning
  do THorse.StopListen;
end;

end.
