unit uCmpPanelContract;

interface

uses
  Vcl.ExtCtrls, uEntContract, System.SysUtils, Vcl.Controls, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, System.Classes, uUtlForm, uMdlContract, uUtlAlert,
  uEntUser, uUtlCalculator;

type
  TPanelContract = class(TPanel)
  private
    FPnlHeader: TPanel;
    FPpMnOption: TPopupMenu;
    FPpItemValidate: TMenuItem;
    FPpItemEdit: TMenuItem;
    FPpItemDelete: TMenuItem;
    FLblHeader: TLabel;
    FBtnOption: TSpeedButton;

    FLblStorage: TLabel;
    FLblProducer: TLabel;
    FLblGrain: TLabel;

    FLblInitialWeight: TLabel;
    FLblMoisture: TLabel;
    FLblFinalWeight: TLabel;

    FLblTotalWeight: TLabel;
    FLblTotalPrice: TLabel;

    FBtnInsert: TButton;

    FContract: TContract;
    FColIndex: Integer;

    FUserLogged: TUser;

    procedure btnOptionClick(Sender: TObject);
    procedure btnOptionValidarClick(Sender: TObject);
    procedure btnOptionEditClick(Sender: TObject);
    procedure btnOptionDeleteClick(Sender: TObject);

    procedure btnInsertClick(Sender: TObject);

    procedure constructPanelHead;
    procedure constructInfoLabels;
    procedure constructDataLabels;
    procedure constructFinalReports;

    procedure setContract(const Value: TContract);

  public
    onUpdate: TEventListener;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property contract: TContract read FContract write setContract;
    property userLogged: TUser write FUserLogged;
    property colIndex: Integer read FColIndex write FColIndex;
  end;

implementation

uses
  Vcl.Graphics, Winapi.Windows, Vcl.Dialogs;

{ TPanelContract }

procedure TPanelContract.btnInsertClick(Sender: TObject);
var
  vValue: string;
begin
  if FContract = nil then
    Exit;

  vValue := InputBox('Inserir Valor', 'Informe o valor medido:', '');
  if (vValue <> EmptyStr) then
  begin
    if (FColIndex = 0) then
      TContractModel.updateInitialWeight(FContract.id, StrToFloat(vValue), FUserLogged)
    else if (FColIndex = 1) then
      TContractModel.updateMoisture(FContract.id, StrToFloat(vValue), FUserLogged)
    else if (FColIndex = 2) then
      TContractModel.updateFinalWeight(FContract.id, StrToFloat(vValue), FUserLogged);

    onUpdate(Sender);
  end;
end;

procedure TPanelContract.btnOptionClick(Sender: TObject);
var
  vPoint: TPoint;
begin
  if FContract = nil then
    Exit;

  vPoint := FBtnOption.ClientToScreen(Point(0, FBtnOption.Height));
  FPpMnOption.Popup(vPoint.X, vPoint.Y);
end;

procedure TPanelContract.btnOptionDeleteClick(Sender: TObject);
begin
  if (showQuestion('Excluir contrato ' + IntToStr(FContract.id) + '?')) then
  begin
    TContractModel.deleteById(FContract.id);
    onUpdate(Sender);
  end;
end;

procedure TPanelContract.btnOptionEditClick(Sender: TObject);
begin

end;

procedure TPanelContract.btnOptionValidarClick(Sender: TObject);
var
  vValue: string;
begin
  if FContract = nil then
    Exit;

  if (FContract.isValidated) then
  begin
    showInformation('Contrato já validado!');
    Exit;
  end;

  vValue := InputBox('Inserir Valor', 'Informe o nome de quem validou:', '');
  if (vValue <> EmptyStr) then
  begin
    TContractModel.updateValidated(FContract.id, True, vValue);
    onUpdate(Sender);
  end;
end;

procedure TPanelContract.constructDataLabels;
begin
  FLblInitialWeight := TLabel.Create(Self);
  with FLblInitialWeight do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'PESO INICIAL: ';
    ShowHint := True;
    Hint := '';
  end;
  FLblInitialWeight.Parent := Self;

  FLblMoisture := TLabel.Create(Self);
  with FLblMoisture do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'UMIDADE: ';
    ShowHint := True;
    Hint := '';
  end;
  FLblMoisture.Parent := Self;

  FLblFinalWeight := TLabel.Create(Self);
  with FLblFinalWeight do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'PESO FINAL: ';
    ShowHint := True;
    Hint := '';
  end;
  FLblFinalWeight.Parent := Self;

end;

procedure TPanelContract.constructFinalReports;
begin
  FLblTotalWeight := TLabel.Create(Self);
  with FLblTotalWeight do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'PESO TOTAL: ';
    Font.Size := 11;
    Font.Style := [fsBold];
    ShowHint := True;
    Hint := '';
  end;
  FLblTotalWeight.Parent := Self;

  FLblTotalPrice := TLabel.Create(Self);
  with FLblTotalPrice do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'PREÇO TOTAL: ';
    Font.Size := 11;
    Font.Style := [fsBold];
    ShowHint := True;
    Hint := '';
  end;
  FLblTotalPrice.Parent := Self;
end;

procedure TPanelContract.constructInfoLabels;
begin
  FLblStorage := TLabel.Create(Self);
  with FLblStorage do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'ARMAZÉM: ';
    ShowHint := True;
    Hint := '';
  end;
  FLblStorage.Parent := Self;

  FLblProducer := TLabel.Create(Self);
  with FLblProducer do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'PRODUTOR: ';
    ShowHint := True;
    Hint := '';
  end;
  FLblProducer.Parent := Self;

  FLblGrain := TLabel.Create(Self);
  with FLblGrain do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 37;
    Width := 202;
    Height := 16;
    Align := alTop;
    Caption := 'GRÃO: ';
    ShowHint := True;
    Hint := '';
  end;
  FLblGrain.Parent := Self;
end;

procedure TPanelContract.constructPanelHead;
begin
  // FPpMnOption
  FPpMnOption := TPopupMenu.Create(Self);

  FPpItemValidate := TMenuItem.Create(FPpMnOption);
  FPpItemValidate.Caption := 'Validar';
  FPpItemValidate.OnClick := btnOptionValidarClick;
  FPpMnOption.Items.Add(FPpItemValidate);

  FPpItemEdit := TMenuItem.Create(FPpMnOption);
  FPpItemEdit.Caption := 'Editar';
  FPpItemEdit.OnClick := btnOptionEditClick;
  FPpMnOption.Items.Add(FPpItemEdit);

  FPpItemDelete := TMenuItem.Create(FPpMnOption);
  FPpItemDelete.Caption := 'Excluir';
  FPpItemDelete.OnClick := btnOptionDeleteClick;
  FPpMnOption.Items.Add(FPpItemDelete);

  // FPnlHeader
  FPnlHeader := TPanel.Create(Self);
  with FPnlHeader do
  begin
    Left := 2;
    Top := 2;
    Width := 208;
    Height := 32;
    Align := alTop;
    BevelOuter := bvNone;
    TabOrder := 0;
  end;
  FPnlHeader.Parent := Self;

  // LblHeader
  FLblHeader := TLabel.Create(Self);
  with FLblHeader do
  begin
    AlignWithMargins := True;
    Left := 3;
    Top := 3;
    Width := 170;
    Height := 26;
    Align := alClient;
    Caption := '# ';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -15;
    Font.Name := '\';
    Font.Size := 11;
    Font.Style := [fsBold];
    ParentFont := False;
    Layout := tlCenter;
  end;
  FLblHeader.Parent := FPnlHeader;

  // FBtnOption
  FBtnOption := TSpeedButton.Create(Self);
  with FBtnOption do
  begin
    Left := 176;
    Top := 0;
    Width := 32;
    Height := 32;
    Align := alRight;
    Caption := '...';
    Font.Size := 16;
    Font.Style := [fsBold];
    Flat := True;
    OnClick := btnOptionClick;
  end;
  FBtnOption.Parent := FPnlHeader;
end;

constructor TPanelContract.Create(AOwner: TComponent);
begin
  inherited;

  with Self do
  begin
    AlignWithMargins := True;
    Left := 3;
    Top := 3;
    Width := 212;
    Align := alTop;
    BevelInner := bvRaised;
    BevelOuter := bvLowered;
    Color := clWhite;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := '\';
    Font.Style := [];
    ParentBackground := False;
    ParentFont := False;
    TabOrder := 0;
    AutoSize := True;
  end;

  Self.constructPanelHead;
  Self.constructInfoLabels;
  Self.constructDataLabels;
  Self.constructFinalReports;

  FBtnInsert := TButton.Create(Self);
  with FBtnInsert do
  begin
    AlignWithMargins := True;
    Left := 5;
    Top := 161;
    Width := 202;
    Height := 32;
    Align := alTop;
    Caption := 'Lançar Valor';
    TabOrder := 1;
    OnClick := btnInsertClick;
  end;
  FBtnInsert.Parent := Self;
end;

destructor TPanelContract.Destroy;
begin

  inherited;
end;

procedure TPanelContract.setContract(const Value: TContract);
var
  vTotalWeight, vTotalPrice: Double;
begin
  FContract := Value;

  if (FContract.isValidated) then
  begin
    FPpItemValidate.Visible := False;
  end;

  FLblHeader.Caption := FLblHeader.Caption + IntToStr(FContract.id);

  FLblStorage.Caption := FLblStorage.Caption + FContract.storage.Name;
  FLblStorage.Hint := FContract.storage.Name;

  FLblProducer.Caption := FLblProducer.Caption + FContract.producer.Name;
  FLblProducer.Hint := FContract.producer.Name;

  FLblGrain.Caption := FLblGrain.Caption + FContract.grain.description;
  FLblGrain.Hint := FContract.grain.description;

  // initialWeight
  if FContract.initialWeight > 0 then
  begin
    FLblInitialWeight.Caption := FLblInitialWeight.Caption + FloatToStr(FContract.initialWeight);
    FLblInitialWeight.Visible := True;
  end
  else
    FLblInitialWeight.Visible := False;

  // moisturePercent
  if FContract.moisturePercent > 0 then
  begin
    FLblMoisture.Caption := FLblMoisture.Caption + FloatToStr(FContract.moisturePercent);
    FLblMoisture.Visible := True;
  end
  else
    FLblMoisture.Visible := False;

  // finalWeight
  if FContract.finalWeight > 0 then
  begin
    FLblFinalWeight.Caption := FLblFinalWeight.Caption + FloatToStr(FContract.finalWeight);
    FLblFinalWeight.Visible := True;
  end
  else
    FLblFinalWeight.Visible := False;

  // Finalized
  if (FContract.initialWeight > 0) and (FContract.moisturePercent > 0) and (FContract.finalWeight > 0) then
  begin
    vTotalWeight := calculateFinalWeight(FContract.initialWeight, FContract.moisturePercent, FContract.finalWeight);
    vTotalPrice := calculateFinalValue(vTotalWeight, FContract.grain.priceKG);

    FLblTotalWeight.Caption := FLblTotalWeight.Caption + FloatToStrF(vTotalWeight, ffNumber, 8, 4);
    FLblTotalWeight.Visible := True;

    FLblTotalPrice.Caption := FLblTotalPrice.Caption + FloatToStrF(vTotalPrice, ffCurrency, 8, 4);
    FLblTotalPrice.Visible := True;

    FBtnInsert.Visible := False;
  end
  else
  begin
    FLblTotalWeight.Visible := False;
    FLblTotalPrice.Visible := False;
  end;

end;

end.
