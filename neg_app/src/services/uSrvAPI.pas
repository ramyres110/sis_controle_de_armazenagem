unit uSrvAPI;

interface

uses IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.SysUtils, Data.DBXJSON,
  uEntContract;

type
  TApi = class(TObject)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    FUrl: String;
  public
    constructor Create;
    destructor Destroy; override;

    procedure PostContract(const AContract:TContract);

  end;

implementation

{ TApi }

constructor TApi.Create;
begin
  FUrl := 'http://localhost:3000/api/v1/';

  FRESTClient := TRESTClient.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);
  FRESTRequest := TRESTRequest.Create(nil);

  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;

  FRESTClient.BaseURL := FUrl;
end;

destructor TApi.Destroy;
begin
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTResponse);

  inherited;
end;

procedure TApi.PostContract(const AContract: TContract);
begin

end;

end.
