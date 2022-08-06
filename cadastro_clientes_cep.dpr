program cadastro_clientes_cep;

uses
  System.StartUpCopy,
  FMX.Forms,
  UI.Principal in 'UI.Principal.pas' {frmPrincipal},
  UI.Cliente.Pesquisa in 'UI.Cliente.Pesquisa.pas' {frmClientePesquisa},
  UI.Cliente.Edicao in 'UI.Cliente.Edicao.pas' {frmClienteEdicao},
  Model.Cliente in 'Model.Cliente.pas',
  API.BuscaCEP.viacep in 'API.BuscaCEP.viacep.pas',
  UI.Cliente in 'UI.Cliente.pas',
  API.Cliente.EnviaEmail in 'API.Cliente.EnviaEmail.pas',
  DAO.Cliente in 'DAO.Cliente.pas' {dtmDaoCliente: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
