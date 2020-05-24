unit uEntUser;

interface

type
  TUser = class
  private
    FId: Integer;
    FUsername: String;
    FPassword: String;
    FCreatedBy: Integer;
    FCreatedAt: TDate;
    FChangedBy: Integer;
    FChangedAt: TDate;
  public
    constructor Create;
    destructor Destrou;
    property id: Integer read FId write FId;
    property username: String read FUsername write FUsername;
    property password: String read FPassword write FPassword;
    property createdBy: Integer read FCreatedBy write FCreatedBy;
    property createdAt: TDate read FCreatedAt write FCreatedAt;
    property changedBy: Integer read FChangedBy write FChangedBy;
    property changedAt: TDate read FChangedAt write FChangedAt;
  end;

implementation

{ TUser }

constructor TUser.Create;
begin

end;

destructor TUser.Destrou;
begin

end;

end.
