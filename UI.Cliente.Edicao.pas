unit UI.Cliente.Edicao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, API.BuscaCEP.viacep,
  DAO.Cliente, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope;

type
  TfrmClienteEdicao = class(TForm)
    txtNome: TEdit;
    Label1: TLabel;
    txtIdentidade: TEdit;
    Label2: TLabel;
    txtCPF: TEdit;
    Label3: TLabel;
    txtTelefone: TEdit;
    Label4: TLabel;
    txtEmail: TEdit;
    Email: TLabel;
    GroupBox1: TGroupBox;
    grpEndereco: TGroupBox;
    txtCEP: TEdit;
    Label6: TLabel;
    btnBuscarCEP: TButton;
    txtLogradouro: TEdit;
    Label5: TLabel;
    txtNumero: TEdit;
    Label7: TLabel;
    txtComplemento: TEdit;
    Label8: TLabel;
    txtBairro: TEdit;
    Label9: TLabel;
    txtCidade: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    txtPais: TEdit;
    Label12: TLabel;
    cboEstado: TComboBox;
    pnlBotoes: TPanel;
    btnSalvarEnviarEmail: TButton;
    btnCancelar: TButton;
    Panel1: TPanel;
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarEnviarEmailClick(Sender: TObject);
  private
    FClienteUI: TObject;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AClienteUI: TObject);
    { Public declarations }
  end;

var
  frmClienteEdicao: TfrmClienteEdicao;

implementation

{$R *.fmx}

uses UI.Cliente;

procedure TfrmClienteEdicao.btnBuscarCEPClick(Sender: TObject);
begin
  TClienteUI(FClienteUI).BuscarCep;
end;

procedure TfrmClienteEdicao.btnCancelarClick(Sender: TObject);
begin
  TClienteUI(FClienteUI).Fechar;
end;

procedure TfrmClienteEdicao.btnSalvarEnviarEmailClick(Sender: TObject);
begin
  TClienteUI(FClienteUI).Salvar;
end;

constructor TfrmClienteEdicao.Create(AOwner: TComponent; AClienteUI: TObject);
begin
  inherited Create(AOwner);
  FClienteUI := AClienteUI;
end;

end.
