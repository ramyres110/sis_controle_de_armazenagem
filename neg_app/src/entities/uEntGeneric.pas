unit uEntGeneric;

interface

uses uEntUser;

type
  TGeneric = class
  protected
    FId: Integer;
    FCreatedBy: TUser;
    FCreatedAt: TDate;
    FChangedBy: TUser;
    FChangedAt: TDate;
  public
    constructor Create;
    destructor Destroy; override;

    property id: Integer read FId write FId;
    property createdBy: TUser read FCreatedBy write FCreatedBy;
    property createdAt: TDate read FCreatedAt write FCreatedAt;
    property changedBy: TUser read FChangedBy write FChangedBy;
    property changedAt: TDate read FChangedAt write FChangedAt;
  end;

implementation

uses
  System.SysUtils;

{ TGeneric }

constructor TGeneric.Create;
begin

end;

destructor TGeneric.Destroy;
begin
  if (Self.FCreatedBy <> nil) then
  begin
    FreeAndNil(Self.FCreatedBy);
  end;
  if (Self.FChangedBy <> nil) then
  begin
    FreeAndNil(Self.FChangedBy);
  end;
end;

end.
