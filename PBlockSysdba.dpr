program PBlockSysdba;

uses
  Vcl.Forms,
  UBloqueiaSysdba in 'UBloqueiaSysdba.pas' {frmBloqueiaSysdba};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Kyrius - Bloqueia SYSDBA';
  Application.CreateForm(TfrmBloqueiaSysdba, frmBloqueiaSysdba);
  Application.Run;
end.
