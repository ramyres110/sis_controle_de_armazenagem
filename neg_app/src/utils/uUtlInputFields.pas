unit uUtlInputFields;

interface

uses
  Vcl.StdCtrls, uMdlGrain, uMdlProducer, uMdlStorage, uMdlUser;

function iif(ACondition: Boolean; AValue1: Variant; AValue2: Variant): Variant;

procedure fillComboBoxStorage(const AComboBox: TComboBox);
procedure fillComboBoxProducer(const AComboBox: TComboBox);
procedure fillComboBoxGrain(const AComboBox: TComboBox);
procedure fillComboBoxGrainObject(const AComboBox: TComboBox);
procedure fillComboBoxUser(const AComboBox: TComboBox);

implementation

uses
  System.Generics.Collections, uEntStorage, System.SysUtils, uEntProducer,
  uEntGrain, uEntUser;

// REF: https://www.devmedia.com.br/forum/operador-ternario-em-delphi-e-possivel/582077
function iif(ACondition: Boolean; AValue1: Variant; AValue2: Variant): Variant;
begin
  if (ACondition) then
    result := AValue1
  else
    result := AValue2
end;

procedure fillComboBoxStorage(const AComboBox: TComboBox);
var
  vList: TObjectList<TStorage>;
  vStorage: TStorage;
begin
  if (AComboBox = nil) then
    raise Exception.Create('ComboBox Storage not instanciated');

  vList := TObjectList<TStorage>.Create;
  try
    TStorageModel.loadList(vList);
    for vStorage in vList do
    begin
      AComboBox.Items.AddObject(vStorage.name, TObject(vStorage.id));
    end;
  finally
    FreeAndNil(vList);
  end;
end;

procedure fillComboBoxProducer(const AComboBox: TComboBox);
var
  vList: TObjectList<TProducer>;
  vProducer: TProducer;
begin
  if (AComboBox = nil) then
    raise Exception.Create('ComboBox Producer not instanciated');

  vList := TObjectList<TProducer>.Create;
  try
    TProducerModel.loadList(vList);
    for vProducer in vList do
    begin
      AComboBox.Items.AddObject(vProducer.name, TObject(vProducer.id));
    end;
  finally
    FreeAndNil(vList);
  end;

end;

procedure fillComboBoxGrain(const AComboBox: TComboBox);
var
  vList: TObjectList<TGrain>;
  vGrain: TGrain;
begin
  if (AComboBox = nil) then
    raise Exception.Create('ComboBox Grain not instanciated');

  vList := TObjectList<TGrain>.Create;
  try
    TGrainModel.loadList(vList);
    for vGrain in vList do
    begin
      AComboBox.Items.AddObject(vGrain.description, TObject(vGrain.id));
    end;
  finally
    FreeAndNil(vList);
  end;
end;

procedure fillComboBoxGrainObject(const AComboBox: TComboBox);
var
  vList: TObjectList<TGrain>;
  vGrain: TGrain;
begin
  if (AComboBox = nil) then
    raise Exception.Create('ComboBox Grain not instanciated');

  vList := TObjectList<TGrain>.Create;
  try
    TGrainModel.loadList(vList);
    for vGrain in vList do
    begin
      AComboBox.Items.AddObject(vGrain.description, TObject(vGrain));
    end;
  finally
    FreeAndNil(vList);
  end;

end;

procedure fillComboBoxUser(const AComboBox: TComboBox);
var
  vList: TObjectList<TUser>;
  vUser: TUser;
begin
  if (AComboBox = nil) then
    raise Exception.Create('ComboBox Grain not instanciated');

  vList := TObjectList<TUser>.Create;
  try
    TUserModel.loadList(vList);
    for vUser in vList do
    begin
      AComboBox.Items.AddObject(vUser.username, TObject(vUser.id));
    end;
  finally
    FreeAndNil(vList);
  end;

end;

end.
