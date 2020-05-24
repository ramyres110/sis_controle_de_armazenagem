unit uEntProducer;

interface

uses uEntGeneric;

type
  TProducer = class(TGeneric)
  private
    FName: String;
    FDocument: String;
    FPhone: String;
    FEmail: String;
  public
    property name: String read FName write FName;
    property document: String read FDocument write FDocument;
    property phone: String read FPhone write FPhone;
    property email: String read FEmail write FEmail;
  end;

implementation

end.
