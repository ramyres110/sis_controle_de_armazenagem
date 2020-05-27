unit uFrmUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls,
  uMdlUser, uUtlForm, uUtlAlert, uEntUser;

type
  TFrmUser = class(TGenericForm)
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
    EdUsername: TLabeledEdit;
    PnlControls: TPanel;
    BtnDelete: TButton;
    BtnCancel: TButton;
    BtnSave: TButton;
    EdPass: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FUserModel: TUserModel;

    procedure clear;
    procedure search;
    procedure save;
    procedure update;
    procedure delete;
  public
    { Public declarations }
  end;

var
  FrmUser: TFrmUser;

implementation

{$R *.dfm}
{ TFrmUser }

procedure TFrmUser.BtnDeleteClick(Sender: TObject);
begin
  Self.delete;
end;

procedure TFrmUser.BtnSaveClick(Sender: TObject);
begin
  if (EdUsername.Text = EmptyStr) then
  begin
    showWarning('Informe o nome de usuário!');
    EdUsername.SetFocus;
    Exit;
  end;
  if (EdPass.Text = EmptyStr) then
  begin
    showWarning('Informe a senha do usuário!');
    EdPass.SetFocus;
    Exit;
  end;

  if (Self.Tag = 0) then
  begin
    Self.save
  end
  else
    Self.update;
end;

procedure TFrmUser.BtnSearchClick(Sender: TObject);
begin
  Self.search;
end;

procedure TFrmUser.clear;
begin
  Self.GoToSearch(nil);
  Self.ClearAllEdits;
  Self.search;
end;

procedure TFrmUser.DBGridDblClick(Sender: TObject);
var
  vId: Integer;
begin
  Self.GoToEdit(EdUsername);

  vId := DBGrid.Fields[0].AsInteger;
  FUserModel.getById(vId);
  if (FUserModel.user <> nil) then
  begin
    EdUsername.Text := FUserModel.user.username;
  end;
end;

procedure TFrmUser.delete;
begin
  if (FUserModel.user = nil) then
    Exit;
  if (showQuestion('Excluir usuário ' + FUserModel.user.username + '?')) then
  begin
    FUserModel.delete;
    FUserModel.freeUser;
    Self.clear;
  end;
end;

procedure TFrmUser.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Self.search;
end;

procedure TFrmUser.FormCreate(Sender: TObject);
begin
  FUserModel := TUserModel.Create;
  DBGrid.DataSource := Self.FUserModel.ds;
  Self.search;

  SetLength(FDinamicGridColumIndexes, 1);
  FDinamicGridColumIndexes[0] := 1; // username

  PrepareForm;
end;

procedure TFrmUser.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FUserModel);
end;

procedure TFrmUser.save;
begin
  FUserModel.user := TUser.Create;
  try
    FUserModel.user.username := EdUsername.Text;
    FUserModel.user.password := EdPass.Text;
    FUserModel.user.createdBy := TUser.Create;
    FUserModel.user.createdBy.id := userLogged.id;
    try
      FUserModel.save();
      showInformation('Usuário salvo com sucesso!');
    except
      on err: Exception do
        showError(err.Message);
    end;
  finally
    FUserModel.freeUser;
    Self.clear;
  end;
end;

procedure TFrmUser.search;
begin
  FUserModel.findAll(EdSearch.Text);
  LblTotal.Caption := IntToStr(FUserModel.qry.RecordCount);
end;

procedure TFrmUser.update;
begin
  if (FUserModel.user = nil) then
    Exit;

  if (showQuestion('Salvar alterações?')) then
  begin
    FUserModel.user.username := EdUsername.Text;
    FUserModel.user.password := EdPass.Text;
    FUserModel.user.changedBy.id := FUserLogged.id;

    FUserModel.update;

    FUserModel.freeUser;

    Self.clear;
  end;
end;

end.
