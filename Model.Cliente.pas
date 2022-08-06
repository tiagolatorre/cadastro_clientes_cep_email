unit Model.Cliente;

interface

uses System.Generics.Collections;

type
  TEndereco = class;

  TCliente = class
  private
    FId: Int64;
    FNome: String;
    FIdentidade: String;
    FCPF: String;
    FTelefone: String;
    FEmail: String;
    FEndereco: TEndereco;
    procedure SetId(const Value: Int64);
    procedure SetNome(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetIdentidade(const Value: String);
  public
    property Id: Int64 read FId write SetId;
    property Nome: String read FNome write SetNome;
    property Identidade: String read FIdentidade write SetIdentidade;
    property CPF: String read FCPF write SetCPF;
    property Telefone: String read FTelefone write SetTelefone;
    property Email: String read FEmail write SetEmail;
    property Endereco: TEndereco read FEndereco write SetEndereco;
  end;

  TEndereco = class
  private
    FId: Int64;
    FCEP: String;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FPais: String;
    procedure SetId(const Value: Int64);
    procedure SetCEP(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetPais(const Value: String);
  public
    property Id: Int64 read FId write SetId;
    property CEP: String read FCEP write SetCEP;
    property Logradouro: String read FLogradouro write SetLogradouro;
    property Numero: String read FNumero write SetNumero;
    property Complemento: String read FComplemento write SetComplemento;
    property Bairro: String read FBairro write SetBairro;
    property Cidade: String read FCidade write SetCidade;
    property Estado: String read FEstado write SetEstado;
    property Pais: String read FPais write SetPais;
  end;

  TListCliente = class(TObjectList<TCliente>);

implementation

{ TCliente }

procedure TCliente.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCliente.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TCliente.SetId(const Value: Int64);
begin
  FId := Value;
end;

procedure TCliente.SetIdentidade(const Value: String);
begin
  FIdentidade := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

{ TEndereco }

procedure TEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TEndereco.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TEndereco.SetId(const Value: Int64);
begin
  FId := Value;
end;

procedure TEndereco.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TEndereco.SetPais(const Value: String);
begin
  FPais := Value;
end;

end.
