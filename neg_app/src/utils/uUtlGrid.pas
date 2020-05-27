unit uUtlGrid;

interface

uses
  Vcl.DBGrids;

procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid); overload;
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid; AIndexOfResizeables: array of Integer); overload;

implementation

// REF: https://www.thoughtco.com/auto-fix-dbgrid-column-widths-4077417
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
var
  i: Integer;
  TotWidth: Integer;
  VarWidth: Integer;
  ResizableColumnCount: Integer;
  AColumn: TColumn;
begin
  TotWidth := 0;
  VarWidth := 0;

  ResizableColumnCount := 0;
  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    TotWidth := TotWidth + DBGrid.Columns[i].Width;
    if DBGrid.Columns[i].Field.Tag <> 0 then
      Inc(ResizableColumnCount);
  end;

  // if dont have auto-resize collumn broke with div by zero
  if (ResizableColumnCount = 0) then
    exit;

  TotWidth := TotWidth + DBGrid.Columns.Count;
  // TotWidth := TotWidth + IndicatorWidth;
  VarWidth := DBGrid.ClientWidth - TotWidth;

  // Equally distribute VarWidth to all auto-resizable columnsif ResizableColumnCount > 0 then
  VarWidth := VarWidth div ResizableColumnCount;
  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    AColumn := DBGrid.Columns[i];
    if AColumn.Field.Tag <> 0 then
    begin
      AColumn.Width := AColumn.Width + VarWidth;
      if AColumn.Width < 0 then
        AColumn.Width := AColumn.Field.Tag;
    end;
  end;
end;

procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid; AIndexOfResizeables: array of Integer);
var
  vTotalResizeable, vCurrIndex: Integer;
  i: Integer;
begin
  vTotalResizeable := High(AIndexOfResizeables);
  for i := 0 to vTotalResizeable do
  begin
    vCurrIndex := AIndexOfResizeables[i];
    if (vCurrIndex < 0) or (vCurrIndex > (DBGrid.Columns.Count - 1)) then
      Continue;

    try
      if (DBGrid.Columns[vCurrIndex].Field.Tag = 0) then
        DBGrid.Columns[vCurrIndex].Field.Tag := DBGrid.Columns[vCurrIndex].Width;
    except
    end;
  end;
  FixDBGridColumnsWidth(DBGrid);
end;

end.
