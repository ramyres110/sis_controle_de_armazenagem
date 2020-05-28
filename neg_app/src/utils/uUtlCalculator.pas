unit uUtlCalculator;

interface

function calculateFinalWeight(AInitialWeight, AMoisture, AFinalWeight: Double): Double;

function calculateFinalValue(AFinalWeight, AGrainPrice: Double): Double;

implementation

function calculateFinalWeight(AInitialWeight, AMoisture, AFinalWeight: Double): Double;
begin
  Result := (AInitialWeight - AFinalWeight) * (1 - (AMoisture/100));
end;


function calculateFinalValue(AFinalWeight, AGrainPrice: Double): Double;
begin
  Result := AFinalWeight * AGrainPrice;
end;

end.
