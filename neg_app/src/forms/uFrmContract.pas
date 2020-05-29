unit uFrmContract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls,
  uEntContract, uMdlContract, uUtlForm, uUtlAlert, uUtlInputFields, uUtlCalculator;

type
  TFrmContract = class(TGenericForm)
    PnlFull: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    BtnNew: TButton;
    PgCtrl: TPageControl;
    TbShList: TTabSheet;
    LblTotal: TLabel;
    Panel2: TPanel;
    EdSearch: TEdit;
    BtnSearch: TBitBtn;
    DBGrid: TDBGrid;
    TbShAdd: TTabSheet;
    PnlControls: TPanel;
    BtnDelete: TButton;
    BtnCancel: TButton;
    BtnSave: TButton;
    ScBoxForm: TScrollBox;
    Produtor: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CboxStorage: TComboBox;
    CboxProducer: TComboBox;
    CboxGrain: TComboBox;
    EdInitialWeight: TLabeledEdit;
    EdMoisturePercent: TLabeledEdit;
    EdFinalWeight: TLabeledEdit;
    EdGrainPrice: TLabeledEdit;
    EdTotalWeighted: TLabeledEdit;
    EdTotalPrice: TLabeledEdit;
    RdGrValidated: TRadioGroup;
    EdValidatedBy: TLabeledEdit;
    CboxSearchStorage: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CBoxSearchProducer: TComboBox;
    CBoxSearchGrain: TComboBox;
    CBoxSearchValidated: TComboBox;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
    procedure RdGrValidatedClick(Sender: TObject);
    procedure CboxGrainChange(Sender: TObject);
    procedure EdInitialWeightExit(Sender: TObject);
    procedure EdMoisturePercentExit(Sender: TObject);
    procedure EdFinalWeightExit(Sender: TObject);
  private
    { Private declarations }
    FContractModel: TContractModel;

    procedure clear;
    procedure search;
    procedure save;
    procedure update;
    procedure delete;

    procedure calculate;

    procedure onBtnNewClick(Sender: TObject);

    procedure fillComboBoxes;
    function getComboBoxIndexByItemId(var ACbox: TComboBox; AId: Integer): Integer;
  public
    { Public declarations }
  end;

var
  FrmContract: TFrmContract;

implementation

uses
  uEntUser, uEntGrain, uEntStorage, uEntProducer, uMdlGrain;

{$R *.dfm}
{ TFrmContract }

procedure TFrmContract.BtnDeleteClick(Sender: TObject);
begin
  Self.delete;
end;

procedure TFrmContract.BtnSaveClick(Sender: TObject);
begin
  if (CboxStorage.ItemIndex < 0) then
  begin
    showWarning('Selecione o Armaz�m/Silo!');
    CboxStorage.SetFocus;
    Exit;
  end;

  if (CboxProducer.ItemIndex < 0) then
  begin
    showWarning('Selecione o Produtor!');
    CboxProducer.SetFocus;
    Exit;
  end;

  if (CboxGrain.ItemIndex < 0) then
  begin
    showWarning('Selecione o Gr�o!');
    CboxGrain.SetFocus;
    Exit;
  end;

  if (RdGrValidated.ItemIndex = 1) and (EdValidatedBy.Text = EmptyStr) then
  begin
    showWarning('Informe quem validou!');
    EdValidatedBy.SetFocus;
    Exit;
  end;

  if (EdMoisturePercent.Text <> EmptyStr) then
    if (EdInitialWeight.Text = EmptyStr) then
    begin
      showWarning('Para informar a umidade informe o peso inicial!');
      EdFinalWeight.SetFocus;
      Exit;
    end;

  if (EdFinalWeight.Text <> EmptyStr) then
    if (EdInitialWeight.Text = EmptyStr) or (EdMoisturePercent.Text = EmptyStr) then
    begin
      showWarning('Para informar o peso final informe o peso inicial e a umidade!');
      EdFinalWeight.SetFocus;
      Exit;
    end;

  if (Self.Tag = 1) then
    Self.update
  else
    Self.save;

end;

procedure TFrmContract.BtnSearchClick(Sender: TObject);
begin
  Self.search;
end;

procedure TFrmContract.calculate;
var
  vInitWght, vMoist, vFinalWght, vGrainPrice, vTotalWhgt, vTotalPrice: double;

begin
  vTotalWhgt := 0;
  vTotalPrice := 0;

  if (EdInitialWeight.Text <> EmptyStr) and (EdMoisturePercent.Text <> EmptyStr) and (EdFinalWeight.Text <> EmptyStr) and
    (EdGrainPrice.Text <> EmptyStr) then
  begin
    vGrainPrice := TGrainModel.getPriceById(Integer(CboxGrain.Items.Objects[CboxGrain.ItemIndex]));
    vInitWght := StrToFloat(EdInitialWeight.Text);
    vMoist := StrToFloat(EdMoisturePercent.Text);
    vFinalWght := StrToFloat(EdFinalWeight.Text);

    vTotalWhgt := calculateFinalWeight(vInitWght, vMoist, vFinalWght);
    vTotalPrice := calculateFinalValue(vTotalWhgt, vGrainPrice);
  end;

  EdTotalWeighted.Text := FloatToStr(vTotalWhgt);
  EdTotalPrice.Text := FloatToStrF(vTotalPrice, ffCurrency, 8, 4);

end;

procedure TFrmContract.CboxGrainChange(Sender: TObject);
var
  vGrain: TGrain;
begin
  if (CboxGrain.ItemIndex < 0) then
    Exit;

  EdGrainPrice.Text := FloatToStrF(TGrainModel.getPriceById(Integer(CboxGrain.Items.Objects[CboxGrain.ItemIndex])), ffCurrency, 8, 4);
end;

procedure TFrmContract.clear;
begin
  if (Self.Tag = 2) then
  begin
    Close;
  end;

  Self.GoToSearch(nil);
  Self.ClearAllEdits;
  Self.search;
end;

procedure TFrmContract.DBGridDblClick(Sender: TObject);
var
  vId: Integer;
begin
  Self.GoToEdit(CboxStorage);

  vId := DBGrid.Fields[0].AsInteger;
  FContractModel.getById(vId);
  if (FContractModel.contract <> nil) then
  begin
    CboxStorage.ItemIndex := getComboBoxIndexByItemId(CboxStorage, FContractModel.contract.storage.id);
    CboxProducer.ItemIndex := getComboBoxIndexByItemId(CboxProducer, FContractModel.contract.producer.id);
    CboxGrain.ItemIndex := getComboBoxIndexByItemId(CboxGrain, FContractModel.contract.grain.id);

    EdInitialWeight.Text := FloatToStr(FContractModel.contract.initialWeight);
    EdMoisturePercent.Text := FloatToStr(FContractModel.contract.moisturePercent);
    EdFinalWeight.Text := FloatToStr(FContractModel.contract.finalWeight);

    if (FContractModel.contract.isValidated) then
    begin
      RdGrValidated.ItemIndex := 1;
      EdValidatedBy.Visible := True;
      EdValidatedBy.Text := FContractModel.contract.validatedBy
    end
    else
    begin
      RdGrValidated.ItemIndex := 0;
      EdValidatedBy.Visible := False;
      EdValidatedBy.Text := '';
    end;

    CboxGrainChange(Sender);
  end;
end;

procedure TFrmContract.delete;
begin
  if (FContractModel.contract = nil) then
    Exit;

  if (showQuestion('Excluir contrato ' + IntToStr(FContractModel.contract.id) + '?')) then
  begin
    FContractModel.delete;
    FContractModel.freeContract;
    Self.clear;
  end;
end;

procedure TFrmContract.EdFinalWeightExit(Sender: TObject);
begin
  Self.calculate;
end;

procedure TFrmContract.EdInitialWeightExit(Sender: TObject);
begin
  Self.calculate;
end;

procedure TFrmContract.EdMoisturePercentExit(Sender: TObject);
begin
  Self.calculate;
end;

procedure TFrmContract.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Self.search;
end;

procedure TFrmContract.fillComboBoxes;
begin
  fillComboBoxStorage(CboxSearchStorage);
  fillComboBoxStorage(CboxStorage);

  fillComboBoxProducer(CBoxSearchProducer);
  fillComboBoxProducer(CboxProducer);

  fillComboBoxGrain(CBoxSearchGrain);
  fillComboBoxGrain(CboxGrain);

  CBoxSearchValidated.Items.clear;
  CBoxSearchValidated.Items.Add('SIM');
  CBoxSearchValidated.Items.Add('N�O');
end;

procedure TFrmContract.FormCreate(Sender: TObject);
begin
  FContractModel := TContractModel.Create;
  DBGrid.DataSource := Self.FContractModel.ds;
  Self.search;

  // SetLength(FDinamicGridColumIndexes, 1);
  // FDinamicGridColumIndexes[0] := 1; // name

  PrepareForm;

  Self.fillComboBoxes;

  onNewClick := onBtnNewClick;
end;

procedure TFrmContract.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FContractModel);
end;

function TFrmContract.getComboBoxIndexByItemId(var ACbox: TComboBox; AId: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ACbox.Items.Count - 1 do
  begin
    if (Integer(ACbox.Items.Objects[I]) = AId) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TFrmContract.onBtnNewClick(Sender: TObject);
begin
  EdGrainPrice.Text := '0';
  calculate;
end;

procedure TFrmContract.RdGrValidatedClick(Sender: TObject);
begin
  if (RdGrValidated.ItemIndex = 1) then
    EdValidatedBy.Visible := True
  else
    EdValidatedBy.Visible := False;
end;

procedure TFrmContract.save;
begin
  FContractModel.contract := TContract.Create;
  try

    FContractModel.contract.storage := TStorage.Create;
    FContractModel.contract.storage.id := Integer(CboxStorage.Items.Objects[CboxStorage.ItemIndex]);

    FContractModel.contract.producer := TProducer.Create;
    FContractModel.contract.producer.id := Integer(CboxProducer.Items.Objects[CboxProducer.ItemIndex]);

    FContractModel.contract.grain := TGrain.Create;
    FContractModel.contract.grain.id := Integer(CboxGrain.Items.Objects[CboxGrain.ItemIndex]);

    FContractModel.contract.createdBy := TUser.Create;
    FContractModel.contract.createdBy.id := userLogged.id;

    if not(EdInitialWeight.Text = EmptyStr) then
    begin
      FContractModel.contract.initialWeight := StrToFloat(EdInitialWeight.Text);
      FContractModel.contract.initialWeightedAt := now();
      FContractModel.contract.initialWeightedBy := TUser.Create;
      FContractModel.contract.initialWeightedBy.id := userLogged.id;
    end;

    if not(EdMoisturePercent.Text = EmptyStr) then
    begin
      FContractModel.contract.moisturePercent := StrToFloat(EdMoisturePercent.Text);
      FContractModel.contract.moistureAt := now();
      FContractModel.contract.moistureBy := TUser.Create;
      FContractModel.contract.moistureBy.id := userLogged.id;
    end;

    if not(EdFinalWeight.Text = EmptyStr) then
    begin
      FContractModel.contract.finalWeight := StrToFloat(EdFinalWeight.Text);
      FContractModel.contract.finalWeightedAt := now();
      FContractModel.contract.finalWeightedBy := TUser.Create;
      FContractModel.contract.finalWeightedBy.id := userLogged.id;
    end;

    FContractModel.contract.isValidated := iif((RdGrValidated.ItemIndex = 1), True, False);
    if (FContractModel.contract.isValidated) then
    begin
      FContractModel.contract.validatedBy := EdValidatedBy.Text;
      FContractModel.contract.validatedAt := now();
    end;

    try
      FContractModel.save();
      showInformation('Contrato salvo com sucesso!');
    except
      on err: Exception do
        showError(err.Message);
    end;
  finally
    FContractModel.freeContract;
    Self.clear;
  end;
end;

procedure TFrmContract.search;
begin
  FContractModel.findAll(EdSearch.Text);
  LblTotal.Caption := IntToStr(FContractModel.qry.RecordCount);
end;

procedure TFrmContract.update;
begin
  if (FContractModel.contract = nil) then
    Exit;

  if (showQuestion('Salvar altera��es?')) then
  begin
    FContractModel.contract.changedBy.id := FUserLogged.id;
    FContractModel.contract.storage.id := Integer(CboxStorage.Items.Objects[CboxStorage.ItemIndex]);
    FContractModel.contract.producer.id := Integer(CboxProducer.Items.Objects[CboxProducer.ItemIndex]);
    FContractModel.contract.grain.id := Integer(CboxGrain.Items.Objects[CboxGrain.ItemIndex]);

    if not(EdInitialWeight.Text = EmptyStr) then
    begin
      FContractModel.contract.initialWeight := StrToFloat(EdInitialWeight.Text);
      FContractModel.contract.initialWeightedAt := now();
      FContractModel.contract.initialWeightedBy.id := userLogged.id;
    end;

    if not(EdMoisturePercent.Text = EmptyStr) then
    begin
      FContractModel.contract.moisturePercent := StrToFloat(EdMoisturePercent.Text);
      FContractModel.contract.moistureAt := now();
      FContractModel.contract.moistureBy.id := userLogged.id;
    end;

    if not(EdFinalWeight.Text = EmptyStr) then
    begin
      FContractModel.contract.finalWeight := StrToFloat(EdFinalWeight.Text);
      FContractModel.contract.finalWeightedAt := now();
      FContractModel.contract.finalWeightedBy.id := userLogged.id;
    end;

    FContractModel.contract.isValidated := iif((RdGrValidated.ItemIndex = 1), True, False);
    if (FContractModel.contract.isValidated) then
    begin
      FContractModel.contract.validatedBy := EdValidatedBy.Text;
      FContractModel.contract.validatedAt := now();
    end;

    FContractModel.update;

    FContractModel.freeContract;

    Self.clear;
  end;
end;

end.
