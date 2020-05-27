unit uEntUser;

interface

type
  TUser = class
  private
    FId: Integer;
    FUsername: String;
    FPassword: String;
    FCreatedBy: TUser;
    FCreatedAt: TDate;
    FChangedBy: TUser;
    FChangedAt: TDate;
  public
    constructor Create;
    destructor Destroy; override;

    property id: Integer read FId write FId;
    property username: String read FUsername write FUsername;
    property password: String read FPassword write FPassword;
    property createdBy: TUser read FCreatedBy write FCreatedBy;
    property createdAt: TDate read FCreatedAt write FCreatedAt;
    property changedBy: TUser read FChangedBy write FChangedBy;
    property changedAt: TDate read FChangedAt write FChangedAt;
  end;

implementation

uses
  System.SysUtils;

{ TUser }

constructor TUser.Create;
begin

end;

destructor TUser.Destroy;
begin
  if (Self.FCreatedBy <> nil) then
  begin
    FreeAndNil(Self.FCreatedBy);
  end;
  if (Self.FChangedBy <> nil) then
  begin
    FreeAndNil(Self.FChangedBy);
  end;
  inherited;
end;

end.
