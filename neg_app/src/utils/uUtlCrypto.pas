unit uUtlCrypto;

interface

uses IdHashMessageDigest;

function MD5(const texto: string): string;

implementation

/// REF: https://gmdasilva.blogspot.com/2018/01/delphi-criptografia-md5.html
function MD5(const texto: string): string;
var
  md5: TIdHashMessageDigest5;
begin
  md5 := TIdHashMessageDigest5.Create;
  try
    Result := md5.HashStringAsHex(texto);
  finally
    md5.Free;
  end;
end;

end.
