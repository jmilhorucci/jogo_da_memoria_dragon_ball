program JogoDaMemoria;

uses
  Forms,
  TelaPrincipal in 'TelaPrincipal.pas' {FormTelaPrincipal};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormTelaPrincipal, FormTelaPrincipal);
  Application.Run;
end.
