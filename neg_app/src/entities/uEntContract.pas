unit uEntContract;

interface

uses uEntGeneric, uEntStorage, uEntUser, uEntGrain, uEntProducer;

type
  TContract = class(TGeneric)
  private
    FStorage: TStorage;
    FProducer: TProducer;
    FGrain: TGrain;
    FInitialWeight: Real;
    FInitialWeightedBy: TUser;
    FInitialWeightedAt: TDate;
    FFinalWeight: Real;
    FFinalWeightedBy: TUser;
    FFinalWeightedAt: TDate;
    FMoisturePercent: Real;
    FMoistureBy: TUser;
    FMoistureAt: TDate;
    FIsValidated: Boolean;
    FValidatedBy: String;
    FValidatedAt: TDate;
    FExternalId: Integer;
  public
    property storage: TStorage read FStorage write FStorage;
    property producer: TProducer read FProducer write FProducer;
    property grain: TGrain read FGrain write FGrain;
    property initialWeight: Real read FInitialWeight write FInitialWeight;
    property initialWeightedBy: TUser read FInitialWeightedBy write FInitialWeightedBy;
    property initialWeightedAt: TDate read FInitialWeightedAt write FInitialWeightedAt;
    property finalWeight: Real read FFinalWeight write FFinalWeight;
    property finalWeightedBy: TUser read FFinalWeightedBy write FFinalWeightedBy;
    property finalWeightedAt: TDate read FFinalWeightedAt write FFinalWeightedAt;
    property moisturePercent: Real read FMoisturePercent write FMoisturePercent;
    property moistureBy: TUser read FMoistureBy write FMoistureBy;
    property moistureAt: TDate read FMoistureAt write FMoistureAt;
    property isValidated: Boolean read FIsValidated write FIsValidated;
    property validatedBy: String read FValidatedBy write FValidatedBy;
    property validatedAt: TDate read FValidatedAt write FValidatedAt;
    property externalId: Integer read FExternalId write FExternalId;
  end;

implementation

end.
