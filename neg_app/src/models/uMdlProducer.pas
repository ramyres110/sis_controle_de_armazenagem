unit uMdlProducer;

interface

uses uSrvDatabase;

type

  TModelProducer = class
  private
    fName: string;
    fDocument: string;
  public
    constructor Create;
    destructor Destroy;
    function getName: string;
    procedure setName(pName: string);
    function getDocument: string;
    procedure setDocument(pDoc: string);
  protected
    property name: string read getName write setName;
    property document: string read getDocument write setDocument;
  end;

implementation

{ TModelProducer }

constructor TModelProducer.Create;
begin

end;

destructor TModelProducer.Destroy;
begin

end;

function TModelProducer.getDocument: string;
begin

end;

function TModelProducer.getName: string;
begin

end;

procedure TModelProducer.setDocument(pDoc: string);
begin

end;

procedure TModelProducer.setName(pName: string);
begin

end;

end.
