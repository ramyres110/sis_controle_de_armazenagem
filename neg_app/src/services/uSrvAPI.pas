unit uSrvAPI;

interface

uses IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.SysUtils, REST.JSON, REST.Types, uEntContract;

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

    procedure PostContractAPI(var AContract: TContract);
    procedure PostValidateContractAPI(const AContract: TContract);

    function GetContractValidationById(AContractExternalId: string): Boolean;

    class procedure PostContract(var AContract: TContract);
    class procedure PostValidateContract(const AContract: TContract);
    class function GetContractValidation(AContractExternalId: string): Boolean;
  end;

implementation

{ TApi }

constructor TApi.Create;
begin
{$IFDEF DEBUG}
  FUrl := 'http://localhost:3000/api/v1';
{$ELSE}
  FUrl := 'http://localhost:3000/api/v1';
{$ENDIF}
  FRESTClient := TRESTClient.Create(nil);
  FRESTClient.BaseURL := FUrl;
  FRESTClient.FallbackCharsetEncoding := 'UTF-8';
  FRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';

  FRESTResponse := TRESTResponse.Create(nil);

  FRESTRequest := TRESTRequest.Create(nil);
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
end;

destructor TApi.Destroy;
begin
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTResponse);

  inherited;
end;

class function TApi.GetContractValidation(AContractExternalId: string): Boolean;
var
  vApi: TApi;
begin
  Result := False;
  try
    vApi := TApi.Create;
    Result := vApi.GetContractValidationById(AContractExternalId);
  finally
    FreeAndNil(vApi);
  end;
end;

function TApi.GetContractValidationById(AContractExternalId: String): Boolean;
var
  vResult: TContract;
begin
  Result := False;

  FRESTRequest.Resource := '/contrato/' + AContractExternalId;
  FRESTRequest.Method := TRESTRequestMethod.rmGET;

  try
    FRESTRequest.Execute;
  except
    on E: Exception do
      Exit;
  end;

  if FRESTResponse.StatusCode = 200 then
  begin
    try
      vResult := TJson.JsonToObject<TContract>(FRESTResponse.Content);
      Result := vResult.isValidated;
    finally
      FreeAndNil(vResult);
    end;
  end
  else
    raise Exception.Create('Error on Post Contract');
end;

procedure TApi.PostContractAPI(var AContract: TContract);
var
  vJson: string;
  vResult: TContract;
begin
  if (AContract = nil) then
    Exit;

  vJson := TJson.ObjectToJsonString(AContract, [joIgnoreEmptyStrings, joIgnoreEmptyArrays]);

  FRESTRequest.Resource := '/contrato';
  FRESTRequest.Method := TRESTRequestMethod.rmPOST;
  FRESTRequest.AddBody(vJson, ContentTypeFromString('application/json'));

  FRESTRequest.Execute;

  if FRESTResponse.StatusCode = 200 then
  begin
    try
      vResult := TJson.JsonToObject<TContract>(FRESTResponse.Content);
      AContract.externalId := vResult.externalId;
    finally
      FreeAndNil(vResult);
    end;
  end
  else
    raise Exception.Create('Error on Post Contract');
end;

class procedure TApi.PostContract(var AContract: TContract);
var
  vApi: TApi;
begin
  if (AContract = nil) then
    Exit;
  try
    vApi := TApi.Create;
    vApi.PostContractAPI(AContract);
  finally
    FreeAndNil(vApi);
  end;
end;

class procedure TApi.PostValidateContract(const AContract: TContract);
var
  vApi: TApi;
begin
  if (AContract = nil) then
    Exit;
  try
    vApi := TApi.Create;
    vApi.PostValidateContractAPI(AContract);
  finally
    FreeAndNil(vApi);
  end;

end;

procedure TApi.PostValidateContractAPI(const AContract: TContract);
var
  vJson: string;
  vResult: TContract;
begin
  if (AContract = nil) then
    Exit;

  vJson := '{"isValidated": true,"validatedBy": "' + AContract.validatedBy + '"}';

  FRESTRequest.Resource := '/contrato/' + AContract.externalId + '/valida';
  FRESTRequest.Method := TRESTRequestMethod.rmPOST;
  FRESTRequest.AddBody(vJson, ContentTypeFromString('application/json'));

  FRESTRequest.Execute;

  if FRESTResponse.StatusCode = 200 then
  begin
  end
  else
    raise Exception.Create('Error on Post Contract');
end;

end.
