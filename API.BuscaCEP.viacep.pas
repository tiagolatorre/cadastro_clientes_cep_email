unit API.BuscaCEP.viacep;

interface

type
  TAPIBuscaCEP = class
  private
  public
    function BuscaCepJSON(const CEP: String): String;
  end;

implementation

uses
 System.Classes, System.SysUtils, System.JSON,
 System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

{ TAPIBuscaCEP }

function TAPIBuscaCEP.BuscaCepJSON(const CEP: String): String;
begin
  var LHTTP: TNetHTTPClient;
  var LResponse: IHTTPResponse;
  var url := 'https://viacep.com.br/ws/'+cep+'/json';

  LHTTP := TNetHTTPClient.Create(Nil);
  LHTTP.SecureProtocols := [THTTPSecureProtocol.TLS12];


  try
    LResponse := LHTTP.Get(url);
    if LResponse.StatusCode = 200 then
    begin
      result := LResponse.ContentAsString();

      var jsonObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(result), 0) as TJSONObject;
      if jsonObject.FindValue('erro') <> nil then
        raise exception.Create('CEP informado não existe.');
    end
    else
      raise exception.Create('CEP informado inválido.');
  finally
    LHTTP.Free;
  end;
end;

end.
