unit uFrmStorage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls,
  uMdlStorage, uUtlForm, uUtlAlert, uEntStorage;

type
  TFrmStorage = class(TGenericForm)
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
    EdName: TLabeledEdit;
    PnlControls: TPanel;
    BtnDelete: TButton;
    BtnCancel: TButton;
    BtnSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FStorageModel: TStorageModel;

    procedure clear;
    procedure search;
    procedure save;
    procedure update;
    procedure delete;
  public
    { Public declarations }
  end;

var
  FrmStorage: TFrmStorage;

implementation

uses
  uEntUser;

{$R *.dfm}
{ TFrmStorage }

procedure TFrmStorage.BtnDeleteClick(Sender: TObject);
begin
  Self.delete;
end;

procedure TFrmStorage.BtnSaveClick(Sender: TObject);
begin
  if (EdName.Text = EmptyStr) then
  begin
    showWarning('Informe o nome!');
    EdName.SetFocus;
    Exit;
  end;

  if (Self.Tag = 0) then
    Self.save
  else
    Self.update;
end;

procedure TFrmStorage.BtnSearchClick(Sender: TObject);
begin
  Self.search;
end;

procedure TFrmStorage.clear;
begin
  Self.GoToSearch(nil);
  Self.ClearAllEdits;
  Self.search;
end;

procedure TFrmStorage.DBGridDblClick(Sender: TObject);
var
  vId: Integer;
begin
  Self.GoToEdit(EdName);

  vId := DBGrid.Fields[0].AsInteger;
  FStorageModel.getById(vId);
  if (FStorageModel.storage <> nil) then
  begin
    EdName.Text := FStorageModel.storage.name;
  end;
end;

procedure TFrmStorage.delete;
begin
  if (FStorageModel.storage = nil) then
    Exit;
  if (showQuestion('Excluir armazém ' + FStorageModel.storage.name + '?')) then
  begin
    FStorageModel.delete;
    FStorageModel.freeStorage;
    Self.clear;
  end;
end;

procedure TFrmStorage.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Self.search;
end;

procedure TFrmStorage.FormCreate(Sender: TObject);
begin
  FStorageModel := TStorageModel.Create;
  DBGrid.DataSource := Self.FStorageModel.ds;
  Self.search;

  SetLength(FDinamicGridColumIndexes, 1);
  FDinamicGridColumIndexes[0] := 1; // name

  PrepareForm;
end;

procedure TFrmStorage.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FStorageModel);
end;

procedure TFrmStorage.save;
begin
  FStorageModel.storage := TStorage.Create;
  try
    FStorageModel.storage.name := EdName.Text;
    FStorageModel.storage.createdBy := TUser.Create;
    FStorageModel.storage.createdBy.id := userLogged.id;
    try
      FStorageModel.save();
      showInformation('Armazém salvo com sucesso!');
    except
      on err: Exception do
        showError(err.Message);
    end;
  finally
    FStorageModel.freeStorage;
    Self.clear;
  end;
end;

procedure TFrmStorage.search;
begin
  FStorageModel.findAll(EdSearch.Text);
  LblTotal.Caption := IntToStr(FStorageModel.qry.RecordCount);
end;

procedure TFrmStorage.update;
begin
  if (FStorageModel.storage = nil) then
    Exit;

  if (showQuestion('Salvar alterações?')) then
  begin
    FStorageModel.storage.name := EdName.Text;
    FStorageModel.storage.changedBy.id := FUserLogged.id;

    FStorageModel.update;

    FStorageModel.freeStorage;

    Self.clear;
  end;
end;

end.
