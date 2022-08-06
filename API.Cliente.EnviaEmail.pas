unit API.Cliente.EnviaEmail;

interface

type
  TAPIEnviaEmail = class
  private
    FPorta: Word;
    FHost: String;
    FUsuario: String;
    FSenha: String;
    FEmail: String;
    FNome: String;
    procedure SetPorta(const Value: Word);
    procedure SetHost(const Value: String);
    procedure SetUsuario(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetNome(const Value: String);
  public
    property Porta: Word read FPorta write SetPorta;
    property Host: String read FHost write SetHost;
    property Usuario: String read FUsuario write SetUsuario;
    property Senha: String read FSenha write SetSenha;

    property Email: String read FEmail write SetEmail;
    property Nome: String read FNome write SetNome;
    function EnviaEmail(const EmailDestinatario: String; const XMLdoCliente: String): Boolean;
  end;

implementation

uses System.Classes, System.SysUtils, IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase;

{ TAPIEnviaEmail }

function TAPIEnviaEmail.EnviaEmail(const EmailDestinatario,
  XMLdoCliente: String): Boolean;
var
  // variáveis e objetos necessários para o envio
  sAnexo: string;
begin
  var IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  var IdSMTP: TIdSMTP;
  var IdMessage: TIdMessage;
  var IdText: TIdText;

    // instanciação dos objetos
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create();
  IdSMTP := TIdSMTP.Create();
  IdMessage := TIdMessage.Create();

    try
      // Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
  //    IdSSLIOHandlerSocket.SSLOptions.Method := TIdSSLVersion.sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Method := TIdSSLVersion.sslvTLSv1_2;
      IdSSLIOHandlerSocket.SSLOptions.Mode := TIdSSLMode.sslmClient;

      // Configuração do servidor SMTP (TIdSMTP)
      IdSMTP.IOHandler := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS := TIdUseTLS.utUseExplicitTLS;
      IdSMTP.AuthType := TIdSMTPAuthenticationType.satDefault;
      IdSMTP.Port := Self.Porta;
      IdSMTP.Host := Self.Host;
      IdSMTP.Username := Self.Usuario;
      IdSMTP.Password := Self.Senha;

      // Configuração da mensagem (TIdMessage)
      IdMessage.From.Address := Self.Email;
      IdMessage.From.Name := Self.Nome;
      IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
      IdMessage.Recipients.Add.Text := EmailDestinatario;

      IdMessage.Subject := 'Cliente registrado com sucesso.';
      IdMessage.Encoding := meMIME;

      // Configuração do corpo do email (TIdText)
      IdText := TIdText.Create(IdMessage.MessageParts);
      IdText.ContentType := 'text/html; charset=iso-8859-1';
      IdText.Body.Add('<html>');
      IdText.Body.Add('Obrigado por registrar-se!<br>');
      IdText.Body.Add('Segue em anexo os dados do cliente em <b>XML</b>');
      IdText.Body.Add('</html>');


      var Anexo := 'xmlcliente.xml';
      var XMLFile := TStringList.Create();
      XMLFile.Text := XMLdoCliente;
      XMLFile.SaveToFile('xmlcliente.xml');
      XMLFile.Free;

      // Anexo da mensagem (TIdAttachmentFile)
      if FileExists(Anexo) then
      begin
        TIdAttachmentFile.Create(IdMessage.MessageParts, Anexo);
      end;

      // Conexão e autenticação
      try
        IdSMTP.Connect;
        IdSMTP.Authenticate;
      except
        on E:Exception do
        begin
          raise exception.Create('Erro na conexão ou autenticação: ' + E.Message)
        end;
      end;

      // Envio da mensagem
      try
        IdSMTP.Send(IdMessage);
        result := true;
      except
        On E:Exception do
        begin
          raise exception.Create('Erro ao enviar a mensagem: ' + E.Message);
        end;
      end;
    finally
      // desconecta do servidor
      IdSMTP.Disconnect;
      // liberação da DLL
      UnLoadOpenSSLLibrary;
      // liberação dos objetos da memória
      FreeAndNil(IdMessage);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(IdSMTP);
    end;
  end;
procedure TAPIEnviaEmail.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TAPIEnviaEmail.SetHost(const Value: String);
begin
  FHost := Value;
end;

procedure TAPIEnviaEmail.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TAPIEnviaEmail.SetPorta(const Value: Word);
begin
  FPorta := Value;
end;

procedure TAPIEnviaEmail.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TAPIEnviaEmail.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;


end.
