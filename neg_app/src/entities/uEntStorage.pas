unit uEntStorage;

interface

uses uEntGeneric;

type

  TStorage = class(TGeneric)
  private
    FName: string;
  public
    property name: string read FName write FName;
  end;

implementation

end.
