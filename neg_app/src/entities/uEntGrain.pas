unit uEntGrain;

interface

uses uEntGeneric;

type

  TGrain = class(TGeneric)
  private
    FDescription: string;
    FPriceKG: Double;
  public
    property description: string read FDescription write FDescription;
    property priceKG: Double read FPriceKG write FPriceKG;
  end;

implementation

end.
