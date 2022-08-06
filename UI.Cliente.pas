unit UI.Cliente;

interface

uses Model.Cliente, API.BuscaCEP.viacep, UI.Cliente.Edicao,
  API.Cliente.EnviaEmail, DAO.Cliente;

type
  TClienteUI = class
  private
    FForm: TfrmClienteEdicao;
    FAPIBuscaCEP: TAPIBuscaCEP;
    FAPIEnviaEmail: TAPIEnviaEmail;
    FDaoCliente: TdtmDaoCliente;
    FCliente: TCliente;

    procedure JSONparaEndereco(const JSON: String; const Endereco: TEndereco);
    procedure PopulaEnderecoParaUI(const Endereco: TEndereco);
    procedure PopulaUIparaCliente(const Cliente: TCliente);
    function gerarArquivoXML(const Cliente: TCliente): String;
    procedure SalvarBDMemoria(const Cliente: TCliente);
    procedure EnviarEmail(const Cliente: TCliente);
    function ValidaCamposUI: Boolean;
    procedure LimpaCampos;

  public
    procedure BuscarCep;
    constructor Create;
    destructor Destroy; override;

    procedure Abrir;
    procedure Fechar;
    procedure Salvar;
  end;

implementation

uses
  FMX.Dialogs, System.SysUtils, System.JSON;


{ TClienteUI }

procedure TClienteUI.BuscarCep;
begin
  var RespostaJSON: String := '';
  var Endereco := TEndereco.Create;
  try
    RespostaJSON := FAPIBuscaCEP.BuscaCepJSON(FForm.txtCep.Text);
    JSONparaEndereco(RespostaJSON,Endereco);
    PopulaEnderecoParaUI(Endereco);
  except
    on E:Exception do
      ShowMessage('Erro ao buscar CEP. Motivo: ' + E.Message);
  end;
  Endereco.Free;
end;

constructor TClienteUI.Create;
begin
  inherited;
  FForm := TfrmClienteEdicao.Create(nil, Self);
  FAPIBuscaCEP := TAPIBuscaCEP.Create;
  FAPIEnviaEmail := TAPIEnviaEmail.Create;
  FDaoCliente := TdtmDaoCliente.Create(nil);
  FDaoCliente.cdsCliente.CreateDataSet;
  FDaoCliente.cdsCliente.LogChanges := False;

  FForm.BindSourceDB1.DataSet := FDaoCliente.cdsCliente;
end;

destructor TClienteUI.Destroy;
begin
  FForm.Free;
  FAPIBuscaCEP.Free;
  FAPIEnviaEmail.Free;
  FDaoCliente.Free;
  inherited;
end;

procedure TClienteUI.EnviarEmail(const Cliente: TCliente);
begin
  // Altere os dados para seu provedor de preferência
  FAPIEnviaEmail.Porta := 587;
  FAPIEnviaEmail.Host := 'smtp.seuhost.com';
  FAPIEnviaEmail.Senha := 'suasenha';
  FAPIEnviaEmail.Usuario := 'seuusuario@email.com.br';
  FAPIEnviaEmail.Email := 'seuemail@email.com.br';
  FAPIEnviaEmail.Nome := 'Seu Nome';
  var XMLdoCLiente := gerarArquivoXML(Cliente);
  FAPIEnviaEmail.EnviaEmail(Cliente.Email,XMLdoCLiente);
end;

procedure TClienteUI.Fechar;
begin
  FForm.Close;
end;

function TClienteUI.gerarArquivoXML(const Cliente: TCliente): String;
begin
  var XML := '<?xml version="1.0" encoding="UTF-8"?>';
  XML := XML + '<cliente>';
  XML := XML + '<nome>'+Cliente.Nome+'</nome>';
  XML := XML + '<identidade>'+Cliente.Identidade+'</identidade>';
  XML := XML + '<cpf>'+Cliente.CPF+'</cpf>';
  XML := XML + '<telefone>'+Cliente.Telefone+'</telefone>';
  XML := XML + '<email>'+Cliente.Email+'</email>';
  XML := XML + '<cep>'+Cliente.Endereco.CEP+'</cep>';
  XML := XML + '<logradouro>'+Cliente.Endereco.Logradouro+'</logradouro>';
  XML := XML + '<numero>'+Cliente.Endereco.Numero+'</numero>';
  XML := XML + '<complemento>'+Cliente.Endereco.Complemento+'</complemento>';
  XML := XML + '<bairro>'+Cliente.Endereco.Bairro+'</bairro>';
  XML := XML + '<cidade>'+Cliente.Endereco.Cidade+'</cidade>';
  XML := XML + '<estado>'+Cliente.Endereco.Estado+'</estado>';
  XML := XML + '<pais>'+Cliente.Endereco.Pais+'</pais>';
  XML := XML + '</cliente>';
  result := xml;
end;

procedure TClienteUI.Abrir;
begin
  FForm.ShowModal;
end;

procedure TClienteUI.JSONparaEndereco(const JSON: String;
  const Endereco: TEndereco);
begin
// Estrutura esperada
//{
//    "cep": "01001-000",
//    "logradouro": "Praça da Sé",
//    "complemento": "lado ímpar",
//    "bairro": "Sé",
//    "localidade": "São Paulo",
//    "uf": "SP",
//    "ibge": "3550308",
//    "gia": "1004",
//    "ddd": "11",
//    "siafi": "7107"
//}
  var jsonObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSON), 0) as TJSONObject;
  Endereco.CEP := jsonObject.GetValue('cep').Value;
  Endereco.Logradouro := jsonObject.GetValue('logradouro').Value;
  Endereco.Complemento := jsonObject.GetValue('complemento').Value;
  Endereco.Bairro := jsonObject.GetValue('bairro').Value;
  Endereco.Cidade := jsonObject.GetValue('localidade').Value;
  Endereco.Estado := jsonObject.GetValue('uf').Value;
end;

procedure TClienteUI.LimpaCampos;
begin
  FForm.txtNome.Text := EmptyStr;
  FForm.txtIdentidade.Text := EmptyStr;
  FForm.txtCPF.Text := EmptyStr;
  FForm.txtTelefone.Text := EmptyStr;
  FForm.txtEmail.Text := EmptyStr;
  FForm.txtCep.Text := EmptyStr;
  FForm.txtLogradouro.Text := EmptyStr;
  FForm.txtNumero.Text := EmptyStr;
  FForm.txtComplemento.Text := EmptyStr;
  FForm.txtBairro.Text := EmptyStr;
  FForm.txtCidade.Text := EmptyStr;
  FForm.cboEstado.ItemIndex := -1;
  FForm.txtPais.Text := EmptyStr;
end;

procedure TClienteUI.PopulaEnderecoParaUI(const Endereco: TEndereco);
begin
  FForm.txtCEP.Text := Endereco.CEP;
  FForm.txtLogradouro.Text := Endereco.Logradouro;
  FForm.txtNumero.Text := Endereco.Numero;
  FForm.txtComplemento.Text := Endereco.Complemento;
  FForm.txtBairro.Text := Endereco.Bairro;
  FForm.txtCidade.Text := Endereco.Cidade;
  FForm.cboEstado.ItemIndex := FForm.cboEstado.Items.IndexOf(Endereco.Estado);
  FForm.txtPais.Text := Endereco.Pais;
end;

procedure TClienteUI.PopulaUIparaCliente(const Cliente: TCliente);
begin
  Cliente.Nome := FForm.txtNome.Text;
  Cliente.Identidade := FForm.txtIdentidade.Text;
  Cliente.CPF := FForm.txtCPF.Text;
  Cliente.Telefone := FForm.txtTelefone.Text;
  Cliente.Email := FForm.txtEmail.Text;
  Cliente.Endereco.CEP := FForm.txtCep.Text;
  Cliente.Endereco.Logradouro := FForm.txtLogradouro.Text;
  Cliente.Endereco.Numero := FForm.txtNumero.Text;
  Cliente.Endereco.Complemento := FForm.txtComplemento.Text;
  Cliente.Endereco.Bairro := FForm.txtBairro.Text;
  Cliente.Endereco.Cidade := FForm.txtCidade.Text;
  if FForm.cboEstado.ItemIndex >=0 then
    Cliente.Endereco.Estado := FForm.cboEstado.Items[FForm.cboEstado.ItemIndex]
  else
    Cliente.Endereco.Estado := EmptyStr;
  Cliente.Endereco.Pais := FForm.txtPais.Text;
end;

procedure TClienteUI.Salvar;
begin
  if ValidaCamposUI then
  begin
    FCliente := TCliente.Create;
    FCliente.Endereco := TEndereco.Create;
    try
      try
        PopulaUIparaCliente(FCliente);
        EnviarEmail(FCliente);
        SalvarBDMemoria(FCliente);
        ShowMessage('Cliente salvo e email enviado com sucesso.');
        LimpaCampos;
      finally
        FCliente.Endereco.Free;
        FCliente.Free;
      end;
    except
      on e:exception do
      begin
        ShowMessage('Erro ao Salvar/Enviar Email. Motivo: ' + e.Message);
      end;
    end;
  end;
end;

procedure TClienteUI.SalvarBDMemoria(const Cliente: TCliente);
begin
  FDaoCliente.cdsCliente.Append;
  FDaoCliente.cdsCliente.FieldByName('nome').AsString := Cliente.Nome;
  FDaoCliente.cdsCliente.FieldByName('identidade').AsString := Cliente.Identidade;
  FDaoCliente.cdsCliente.FieldByName('cpf').AsString := Cliente.CPF;
  FDaoCliente.cdsCliente.FieldByName('telefone').AsString := Cliente.Telefone;
  FDaoCliente.cdsCliente.FieldByName('email').AsString := Cliente.Email;
  FDaoCliente.cdsCliente.FieldByName('CEP').AsString := Cliente.Endereco.CEP;
  FDaoCliente.cdsCliente.FieldByName('logradouro').AsString := Cliente.Endereco.Logradouro;
  FDaoCliente.cdsCliente.FieldByName('numero').AsString := Cliente.Endereco.Numero;
  FDaoCliente.cdsCliente.FieldByName('complemento').AsString := Cliente.Endereco.Complemento;
  FDaoCliente.cdsCliente.FieldByName('bairro').AsString := Cliente.Endereco.Bairro;
  FDaoCliente.cdsCliente.FieldByName('cidade').AsString := Cliente.Endereco.Cidade;
  FDaoCliente.cdsCliente.FieldByName('estado').AsString := Cliente.Endereco.Estado;
  FDaoCliente.cdsCliente.FieldByName('pais').AsString := Cliente.Endereco.Pais;
  FDaoCliente.cdsCliente.Post;
end;

function TClienteUI.ValidaCamposUI: Boolean;
begin
  result := False;
  if FForm.txtNome.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Nome".');
    FForm.txtNome.SetFocus;
  end
  else if FForm.txtIdentidade.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Identidade".');
    FForm.txtIdentidade.SetFocus;
  end
  else if FForm.txtCPF.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "CPF".');
    FForm.txtCPF.SetFocus;
  end
  else if FForm.txtTelefone.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Telefone".');
    FForm.txtTelefone.SetFocus;
  end
  else if FForm.txtEmail.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Email".');
    FForm.txtEmail.SetFocus;
  end
  else if FForm.txtCEP.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "CEP".');
    FForm.txtCEP.SetFocus;
  end
  else if FForm.txtLogradouro.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Logradouro".');
    FForm.txtLogradouro.SetFocus;
  end
  else if FForm.txtNumero.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Número".');
    FForm.txtNumero.SetFocus;
  end
  else if FForm.txtBairro.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Bairro".');
    FForm.txtBairro.SetFocus;
  end
  else if FForm.txtCidade.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "Cidade".');
    FForm.txtCidade.SetFocus;
  end
  else if FForm.txtPais.Text.Trim() = EmptyStr then
  begin
    ShowMessage('Informe o campo "País".');
    FForm.txtPais.SetFocus;
  end
  else
    result := True;
end;

end.
