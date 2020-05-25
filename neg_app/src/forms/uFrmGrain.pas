unit uFrmGrain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, uEntGrain, uMdlGrain, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.Buttons, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, uUtlAlert, uUtlGrid, uEntUser;

type
  TFrmGrain = class(TForm)
    PnlFull: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    PgCtrl: TPageControl;
    TbShList: TTabSheet;
    Panel2: TPanel;
    DBGrid: TDBGrid;
    EdSearch: TEdit;
    BitBtn1: TBitBtn;
    TbShAdd: TTabSheet;
    EdDesc: TLabeledEdit;
    EdPrice: TLabeledEdit;
    PnlControls: TPanel;
    BtnDelete: TButton;
    BtnCancel: TButton;
    BtnSave: TButton;
    BtnNew: TButton;
    LblTotal: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FGrainModel: TGrainModel;
    FUserLogged: TUser;

    procedure clear;
    procedure search;
    procedure new;
    procedure save;
    procedure edit;
    procedure update;
    procedure delete;
  public
    { Public declarations }
    property userLogged: TUser read FUserLogged write FUserLogged;
  end;

var
  FrmGrain: TFrmGrain;

implementation

{$R *.dfm}

procedure TFrmGrain.BtnNewClick(Sender: TObject);
begin
  Self.new;
end;

procedure TFrmGrain.BtnSaveClick(Sender: TObject);
begin
  if(EdDesc.Text = EmptyStr)then
  begin
    showWarning('Informe a descrição!');
    EdDesc.SetFocus;
    Exit;
  end;

    if(EdPrice.Text = EmptyStr)then
  begin
    showWarning('Informe a o preço!');
    EdDesc.SetFocus;
    Exit;
  end;

  if (Self.Tag = 0) then
    Self.save
  else
    Self.update;
end;

procedure TFrmGrain.BitBtn1Click(Sender: TObject);
begin
  Self.search;
end;

procedure TFrmGrain.BtnCancelClick(Sender: TObject);
begin
  Self.clear;
end;

procedure TFrmGrain.BtnDeleteClick(Sender: TObject);
begin
  Self.delete;
end;

procedure TFrmGrain.update;
begin
  if (FGrainModel.grain = nil) then
    exit;

  if (showQuestion('Salvar alterações?')) then
  begin
    FGrainModel.grain.description := EdDesc.Text;
    FGrainModel.grain.priceKG := StrToFloat(EdPrice.Text);
    FGrainModel.grain.changedBy.id := FUserLogged.id;
    FGrainModel.update;
    FGrainModel.freeGrain;
    Self.clear;
  end;
end;

procedure TFrmGrain.clear;
begin
  Self.Tag := 0;
  PgCtrl.TabIndex := 0;
  TbShList.TabVisible := True;
  TbShAdd.TabVisible := False;
  BtnNew.Visible := True;
  EdDesc.Text := '';
  EdPrice.Text := '';
  EdDesc.Color := clWindow;
  EdPrice.Color := clWindow;
  BtnDelete.Visible := False;
  EdSearch.SetFocus;

  Self.search;
end;

procedure TFrmGrain.DBGridDblClick(Sender: TObject);
begin
  Self.edit;
end;

procedure TFrmGrain.delete;
begin
  if (FGrainModel.grain = nil) then
    exit;
  if (showQuestion('Excluir Grão ' + FGrainModel.grain.description + '?')) then
  begin
    FGrainModel.delete;
    FGrainModel.freeGrain;
    Self.clear;
  end;
end;

procedure TFrmGrain.edit;
var
  vId: integer;
begin
  Self.Tag := 1;

  vId := DBGrid.Fields[0].AsInteger;
  FGrainModel.getById(vId);
  if (FGrainModel.grain <> nil) then
  begin
    EdDesc.Text := FGrainModel.grain.description;
    EdPrice.Text := FloatToStr(FGrainModel.grain.priceKG);
    EdDesc.Color := clInfoBk;
    EdPrice.Color := clInfoBk;
    BtnDelete.Visible := True;
    Self.new;
  end;
end;

procedure TFrmGrain.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if(key = #13)then
    search;
end;

procedure TFrmGrain.FormCreate(Sender: TObject);
begin
  Self.FGrainModel := TGrainModel.Create;
  DBGrid.DataSource := Self.FGrainModel.ds;
end;

procedure TFrmGrain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGrainModel);
end;

procedure TFrmGrain.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(DBGrid, [1]);
end;

procedure TFrmGrain.FormShow(Sender: TObject);
begin
  Self.clear;
  if Self.FUserLogged = nil then
    Self.Close;
end;

procedure TFrmGrain.new;
begin
  PgCtrl.TabIndex := 1;
  TbShList.TabVisible := False;
  TbShAdd.TabVisible := True;
  BtnNew.Visible := False;
  EdDesc.SetFocus;
end;

procedure TFrmGrain.save;
begin
  FGrainModel.grain := TGrain.Create;
  try
    FGrainModel.grain.description := EdDesc.Text;
    FGrainModel.grain.priceKG := StrToFloat(EdPrice.Text);
    FGrainModel.grain.createdBy := TUser.Create;
    FGrainModel.grain.createdBy.id := userLogged.id;
    try
      FGrainModel.save();
      showInformation('Grão salvo com sucesso!');
    except
      on err: Exception do
        showError(err.Message);
    end;
  finally
    FGrainModel.freeGrain;
    Self.clear;
  end;
end;

procedure TFrmGrain.search;
begin
  FGrainModel.findAll(EdSearch.Text);
  LblTotal.Caption := IntToStr(FGrainModel.qry.RecordCount);
end;

end.
