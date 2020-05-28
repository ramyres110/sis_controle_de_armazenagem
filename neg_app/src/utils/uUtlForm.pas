unit uUtlForm;

interface

uses
  System.Classes, Vcl.StdCtrls, System.SysUtils, Vcl.ExtCtrls, Vcl.DBGrids,
  Vcl.Forms, Vcl.Controls, Vcl.ComCtrls, Vcl.Graphics, uUtlGrid, uEntUser;

type
  TNotifyNewClick = procedure(Sender: TObject) of object;

  TGenericForm = class(TForm)
  private
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);

  protected
    FUserLogged: TUser;
    FDinamicGridColumIndexes: Array of Integer;

    procedure GoToSearch(const AComponentToFocus: TWinControl);
    procedure GoToNew(const AComponentToFocus: TWinControl);
    procedure GoToEdit(const AComponentToFocus: TWinControl);

    procedure SetFocusOnComponent(const AComponentToFocus: TWinControl);
    procedure SetColorOnEdits(const AParent: TTabSheet; AColor: TColor);
    procedure ClearAllEdits;

    procedure PrepareForm;
  public
    onNewClick: TNotifyNewClick;

    property userLogged: TUser read FUserLogged write FUserLogged;
  end;

implementation

  { TGenericForm }

procedure TGenericForm.BtnCancelClick(Sender: TObject);
begin
  if(Self.Tag = 2)then
  begin
    Close;
    Exit;
  end;

  Self.GoToSearch(nil);
  Self.ClearAllEdits;
end;

procedure TGenericForm.BtnNewClick(Sender: TObject);
begin
  Self.Tag := 0;
  GoToNew(nil);
  if (Assigned(onNewClick)) then
    onNewClick(Sender);
end;

procedure TGenericForm.ClearAllEdits;
var
  i: Integer;
  vComp: TComponent;
begin
  for i := 0 to Self.ComponentCount - 1 do
  begin
    vComp := Self.Components[i];
    if (vComp.ClassName = 'TEdit') then
    begin
      (vComp as TEdit).Text := EmptyStr;
    end;
    if (vComp.ClassName = 'TLabeledEdit') then
    begin
      (vComp as TLabeledEdit).Text := EmptyStr;
    end;
  end;
end;

procedure TGenericForm.FormResize(Sender: TObject);
var
  i: Integer;
  vComp: TComponent;
  DBGrid: TDBGrid;
begin
  if (FDinamicGridColumIndexes = nil) then
    Exit;
  if (Length(FDinamicGridColumIndexes) = 0) then
    Exit;

  for i := 0 to Self.ComponentCount - 1 do
  begin
    vComp := Self.Components[i];
    if (vComp.ClassName = 'TDBGrid') then
    begin
      DBGrid := (vComp as TDBGrid);
      FixDBGridColumnsWidth(DBGrid, FDinamicGridColumIndexes);
      Break;
    end;
  end;
end;

procedure TGenericForm.FormShow(Sender: TObject);
begin
  if Self.FUserLogged = nil then
    Self.Close;

  Self.ClearAllEdits;
  if (Self.Tag = 2) then
    Self.GoToNew(nil)
  else
    Self.GoToSearch(nil);

end;

procedure TGenericForm.GoToEdit(const AComponentToFocus: TWinControl);
var
  i: Integer;
  vComp: TComponent;
  vTabAdd: TTabSheet;
begin
  GoToNew(AComponentToFocus);
  Self.Tag := 1;
  vTabAdd := nil;
  for i := 0 to Self.ComponentCount - 1 do
  begin
    vComp := Self.Components[i];
    if (vComp.Name = 'TbShAdd') then
    begin
      vTabAdd := (vComp as TTabSheet);
      Continue;
    end;
    if (vComp.Name = 'BtnDelete') then
    begin
      (vComp as TButton).Visible := True;
      Continue;
    end;
  end;
  if (vTabAdd <> nil) then
  begin
    SetColorOnEdits(vTabAdd, clInfoBk);
  end;
end;

procedure TGenericForm.GoToNew(const AComponentToFocus: TWinControl);
var
  i: Integer;
  vComp: TComponent;
  vTabAdd: TTabSheet;
begin
  vTabAdd := nil;
  for i := 0 to Self.ComponentCount - 1 do
  begin
    vComp := Self.Components[i];
    if (vComp.Name = 'PgCtrl') then
    begin
      (vComp as TPageControl).TabIndex := 1;
      Continue;
    end;
    if (vComp.Name = 'TbShList') then
    begin
      (vComp as TTabSheet).TabVisible := False;
      Continue;
    end;
    if (vComp.Name = 'TbShAdd') then
    begin
      vTabAdd := (vComp as TTabSheet);
      vTabAdd.TabVisible := True;
      Continue;
    end;
    if (vComp.Name = 'BtnNew') then
    begin
      (vComp as TButton).Visible := False;
      Continue;
    end;
    if (vComp.Name = 'BtnDelete') then
    begin
      (vComp as TButton).Visible := False;
      Continue;
    end;
  end;
  if (vTabAdd <> nil) then
  begin
    SetColorOnEdits(vTabAdd, clWhite);
  end;
  SetFocusOnComponent(AComponentToFocus);
  Self.ClearAllEdits;
end;

procedure TGenericForm.GoToSearch(const AComponentToFocus: TWinControl);
var
  i: Integer;
  vComp: TComponent;
begin
  for i := 0 to Self.ComponentCount - 1 do
  begin
    vComp := Self.Components[i];
    if (vComp.Name = 'PgCtrl') then
    begin
      (vComp as TPageControl).TabIndex := 0;
      Continue;
    end;
    if (vComp.Name = 'TbShList') then
    begin
      (vComp as TTabSheet).TabVisible := True;
      Continue;
    end;
    if (vComp.Name = 'TbShAdd') then
    begin
      (vComp as TTabSheet).TabVisible := False;
      Continue;
    end;
    if (vComp.Name = 'BtnNew') then
    begin
      (vComp as TButton).Visible := True;
      Continue;
    end;
    if (vComp.Name = 'BtnDelete') then
    begin
      (vComp as TButton).Visible := False;
      Continue;
    end;
  end;
  Self.SetFocusOnComponent(AComponentToFocus);
  Self.ClearAllEdits;
end;

procedure TGenericForm.PrepareForm;
var
  i: Integer;
  vComp: TComponent;
begin
  Self.Constraints.MinWidth := 600;
  Self.Constraints.MinHeight := 400;
  Self.OnShow := Self.FormShow;
  Self.OnResize := Self.FormResize;
  for i := 0 to Self.ComponentCount - 1 do
  begin
    vComp := Self.Components[i];
    if (vComp.Name = 'BtnNew') then
    begin
      (vComp as TButton).OnClick := Self.BtnNewClick;
    end;
    if (vComp.Name = 'BtnCancel') then
    begin
      (vComp as TButton).OnClick := Self.BtnCancelClick;
    end;
  end;
  GoToSearch(nil);
end;

procedure TGenericForm.SetColorOnEdits(const AParent: TTabSheet; AColor: TColor);
var
  i: Integer;
  vCtl: TControl;
begin
  for i := 0 to AParent.ControlCount - 1 do
  begin
    vCtl := AParent.Controls[i];
    if (vCtl.ClassName = 'TEdit') then
    begin
      (vCtl as TEdit).color := AColor;
    end;
    if (vCtl.ClassName = 'TLabeledEdit') then
    begin
      (vCtl as TLabeledEdit).color := AColor;
    end;
  end;
end;

procedure TGenericForm.SetFocusOnComponent(const AComponentToFocus: TWinControl);
begin
  if (AComponentToFocus <> nil) then
  begin
    if AComponentToFocus.CanFocus then
      AComponentToFocus.SetFocus;
  end;
end;

end.
