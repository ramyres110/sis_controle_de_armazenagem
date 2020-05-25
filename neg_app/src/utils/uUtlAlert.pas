unit uUtlAlert;

interface

procedure showAlert(msg: string);
procedure showError(msg: string);
procedure showInformation(msg: string);
function showQuestion(question: string): Boolean;
procedure showWarning(msg: string);

implementation

uses
  Vcl.Forms, Winapi.Windows;

procedure showAlert(msg: string);
begin
  Application.MessageBox(PChar(msg), PChar(Application.Title), MB_OK);
end;

procedure showError(msg: string);
begin
  Application.MessageBox(PChar(msg), PChar(Application.Title), MB_ICONERROR + MB_OK);
end;

procedure showInformation(msg: string);
begin
  Application.MessageBox(PChar(msg), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
end;

function showQuestion(question: string): Boolean;
begin
  Result := False;
  if (Application.MessageBox(PChar(question), PChar(Application.Title), MB_ICONQUESTION + MB_YESNO) = ID_YES) then
    Result := True;
end;

procedure showWarning(msg: string);
begin
  Application.MessageBox(PChar(msg), PChar(Application.Title), MB_ICONWARNING + MB_OK);
end;

end.
