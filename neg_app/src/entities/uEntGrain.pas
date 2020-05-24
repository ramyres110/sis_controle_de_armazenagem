unit uEntGrain;

interface

uses uEntGeneric;

type

  TGrain = class(TGeneric)
  private
    FDescription: string;
    FPriceKG: Real;
  public
    property description: string read FDescription write FDescription;
    property priceKG: Real read FPriceKG write FPriceKG;
  end;

implementation

end.
