unit uFrmProducer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls,
  uMdlProducer, uUtlForm, uUtlAlert;

type
  TFrmProducer = class(TGenericForm)
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
    EdDoc: TLabeledEdit;
    EdPhone: TLabeledEdit;
    EdEmail: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FProducerModel: TProducerModel;

    procedure clear;
    procedure search;
    procedure save;
    procedure update;
    procedure delete;
  public
    { Public declarations }
  end;

var
  FrmProducer: TFrmProducer;

implementation

uses
  uEntProducer, uEntUser;

{$R *.dfm}

procedure TFrmProducer.BtnSearchClick(Sender: TObject);
begin
  search;
end;

procedure TFrmProducer.BtnDeleteClick(Sender: TObject);
begin
  Self.delete;
end;

procedure TFrmProducer.BtnSaveClick(Sender: TObject);
begin
  if (EdName.Text = EmptyStr) then
  begin
    showWarning('Informe o nome!');
    EdName.SetFocus;
    Exit;
  end;

  if (EdDoc.Text = EmptyStr) then
  begin
    showWarning('Informe o documento!');
    EdDoc.SetFocus;
    Exit;
  end;

  if (Self.Tag = 0) then
    Self.save
  else
    Self.update;
end;

procedure TFrmProducer.clear;
begin
  Self.GoToSearch(nil);
  Self.ClearAllEdits;
  Self.search;
end;

procedure TFrmProducer.DBGridDblClick(Sender: TObject);
var
  vId: Integer;
begin
  Self.GoToEdit(EdName);

  vId := DBGrid.Fields[0].AsInteger;
  FProducerModel.getById(vId);
  if (FProducerModel.producer <> nil) then
  begin
    EdName.Text := FProducerModel.producer.name;
    EdDoc.Text := FProducerModel.producer.document;
    EdEmail.Text := FProducerModel.producer.email;
    EdPhone.Text := FProducerModel.producer.phone;
  end;
end;

procedure TFrmProducer.delete;
begin
  if (FProducerModel.producer = nil) then
    Exit;
  if (showQuestion('Excluir produtor ' + FProducerModel.producer.name + '?')) then
  begin
    FProducerModel.delete;
    FProducerModel.freeProducer;
    Self.clear;
  end;
end;

procedure TFrmProducer.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    search;
end;

procedure TFrmProducer.FormCreate(Sender: TObject);
begin
  FProducerModel := TProducerModel.Create;
  DBGrid.DataSource := Self.FProducerModel.ds;

  SetLength(FDinamicGridColumIndexes, 4);

  FDinamicGridColumIndexes[0] := 1; // name
  FDinamicGridColumIndexes[1] := 2; // doc
  FDinamicGridColumIndexes[2] := 3; // email
  FDinamicGridColumIndexes[3] := 4; // phone

  PrepareForm;

  Self.search;
end;

procedure TFrmProducer.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProducerModel);
end;

procedure TFrmProducer.save;
begin
  FProducerModel.producer := TProducer.Create;
  try
    FProducerModel.producer.name := EdName.Text;
    FProducerModel.producer.document := EdDoc.Text;
    FProducerModel.producer.email := EdEmail.Text;
    FProducerModel.producer.phone := EdPhone.Text;
    FProducerModel.producer.createdBy := TUser.Create;
    FProducerModel.producer.createdBy.id := userLogged.id;
    try
      FProducerModel.save();
      showInformation('Produtor salvo com sucesso!');
    except
      on err: Exception do
        showError(err.Message);
    end;
  finally
    FProducerModel.freeProducer;
    Self.clear;
  end;
end;

procedure TFrmProducer.search;
begin
  FProducerModel.findAll(EdSearch.Text);
  LblTotal.Caption := IntToStr(FProducerModel.qry.RecordCount);
end;

procedure TFrmProducer.update;
begin
  if (FProducerModel.producer = nil) then
    Exit;

  if (showQuestion('Salvar alterações?')) then
  begin
    FProducerModel.producer.name := EdName.Text;
    FProducerModel.producer.document := EdDoc.Text;
    FProducerModel.producer.email := EdEmail.Text;
    FProducerModel.producer.phone := EdPhone.Text;
    FProducerModel.producer.changedBy.id := FUserLogged.id;

    FProducerModel.update;

    FProducerModel.freeProducer;

    Self.clear;
  end;
end;

end.
