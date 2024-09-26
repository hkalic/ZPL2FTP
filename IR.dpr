program IR;

uses
  Vcl.Forms,
  IR_ZPL in 'IR_ZPL.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
