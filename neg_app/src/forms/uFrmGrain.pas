unit uFrmGrain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.DB, uUtlAlert, uUtlGrid, uUtlForm, uEntUser, uEntGrain, uMdlGrain;

type

  TFrmGrain = class(TGenericForm)
    PnlFull: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    PgCtrl: TPageControl;
    TbShList: TTabSheet;
    Panel2: TPanel;
    DBGrid: TDBGrid;
    EdSearch: TEdit;
    BtnSearch: TBitBtn;
    TbShAdd: TTabSheet;
    EdDesc: TLabeledEdit;
    EdPrice: TLabeledEdit;
    PnlControls: TPanel;
    BtnDelete: TButton;
    BtnCancel: TButton;
    BtnSave: TButton;
    BtnNew: TButton;
    LblTotal: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FGrainModel: TGrainModel;

    procedure clear;
    procedure search;
    procedure save;
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

procedure TFrmGrain.BtnSaveClick(Sender: TObject);
begin
  if (EdDesc.Text = EmptyStr) then
  begin
    showWarning('Informe a descrição!');
    EdDesc.SetFocus;
    Exit;
  end;

  if (EdPrice.Text = EmptyStr) then
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

procedure TFrmGrain.BtnSearchClick(Sender: TObject);
begin
  Self.search;
end;

procedure TFrmGrain.BtnDeleteClick(Sender: TObject);
begin
  Self.delete;
end;

procedure TFrmGrain.update;
begin
  if (FGrainModel.grain = nil) then
    Exit;

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
  Self.GoToSearch(nil);
  Self.ClearAllEdits;
  Self.search;
end;

procedure TFrmGrain.DBGridDblClick(Sender: TObject);
var
  vId: Integer;
begin
  Self.GoToEdit(EdDesc);

  vId := DBGrid.Fields[0].AsInteger;
  FGrainModel.getById(vId);
  if (FGrainModel.grain <> nil) then
  begin
    EdDesc.Text := FGrainModel.grain.description;
    EdPrice.Text := FloatToStr(FGrainModel.grain.priceKG);
  end;
end;

procedure TFrmGrain.delete;
begin
  if (FGrainModel.grain = nil) then
    Exit;
  if (showQuestion('Excluir Grão ' + FGrainModel.grain.description + '?')) then
  begin
    FGrainModel.delete;
    FGrainModel.freeGrain;
    Self.clear;
  end;
end;

procedure TFrmGrain.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    search;
end;

procedure TFrmGrain.FormCreate(Sender: TObject);
begin
  Self.FGrainModel := TGrainModel.Create;
  DBGrid.DataSource := Self.FGrainModel.ds;

  SetLength(FDinamicGridColumIndexes,1);
  FDinamicGridColumIndexes[0] := 1;

  PrepareForm;

  Self.search;
end;

procedure TFrmGrain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGrainModel);
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
