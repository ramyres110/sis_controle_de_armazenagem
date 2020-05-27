unit uEntContract;

interface

uses uEntGeneric, uEntStorage, uEntUser, uEntGrain, uEntProducer;

type
  TContract = class(TGeneric)
  private
    FStorage: TStorage;
    FProducer: TProducer;
    FGrain: TGrain;

    FInitialWeight: Double;
    FInitialWeightedBy: TUser;
    FInitialWeightedAt: TDate;

    FMoisturePercent: Double;
    FMoistureBy: TUser;
    FMoistureAt: TDate;

    FFinalWeight: Double;
    FFinalWeightedBy: TUser;
    FFinalWeightedAt: TDate;

    FIsValidated: Boolean;
    FValidatedBy: String;
    FValidatedAt: TDate;
    FExternalId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property storage: TStorage read FStorage write FStorage;
    property producer: TProducer read FProducer write FProducer;
    property grain: TGrain read FGrain write FGrain;

    property initialWeight: Double read FInitialWeight write FInitialWeight;
    property initialWeightedBy: TUser read FInitialWeightedBy write FInitialWeightedBy;
    property initialWeightedAt: TDate read FInitialWeightedAt write FInitialWeightedAt;

    property moisturePercent: Double read FMoisturePercent write FMoisturePercent;
    property moistureBy: TUser read FMoistureBy write FMoistureBy;
    property moistureAt: TDate read FMoistureAt write FMoistureAt;

    property finalWeight: Double read FFinalWeight write FFinalWeight;
    property finalWeightedBy: TUser read FFinalWeightedBy write FFinalWeightedBy;
    property finalWeightedAt: TDate read FFinalWeightedAt write FFinalWeightedAt;


    property isValidated: Boolean read FIsValidated write FIsValidated;
    property validatedBy: String read FValidatedBy write FValidatedBy;
    property validatedAt: TDate read FValidatedAt write FValidatedAt;
    property externalId: Integer read FExternalId write FExternalId;
  end;

implementation

uses
  System.SysUtils;

{ TContract }

constructor TContract.Create;
begin

end;

destructor TContract.Destroy;
begin
  if (Self.FStorage <> nil) then
  begin
    FreeAndNil(Self.FStorage);
  end;
  if (Self.FProducer <> nil) then
  begin
    FreeAndNil(Self.FProducer);
  end;
  if (Self.FGrain <> nil) then
  begin
    FreeAndNil(Self.FGrain);
  end;
  if (Self.FInitialWeightedBy <> nil) then
  begin
    FreeAndNil(Self.FInitialWeightedBy);
  end;
  if (Self.FFinalWeightedBy <> nil) then
  begin
    FreeAndNil(Self.FFinalWeightedBy);
  end;
  if (Self.FMoistureBy <> nil) then
  begin
    FreeAndNil(Self.FMoistureBy);
  end;
  inherited;
end;

end.
