unit uUtlInputFields;

interface

uses
  Vcl.StdCtrls;

function iif(ACondition: Boolean; AValue1: Variant; AValue2: Variant): Variant;

implementation

// REF: https://www.devmedia.com.br/forum/operador-ternario-em-delphi-e-possivel/582077
function iif(ACondition: Boolean; AValue1: Variant; AValue2: Variant): Variant;
begin
  if (ACondition) then
    result := AValue1
  else
    result := AValue2
end;

end.
