unit UI.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  UI.Cliente.Edicao, UI.Cliente;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuCadastro: TMenuItem;
    mnuCadastroClientes: TMenuItem;
    procedure mnuCadastroClientesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClienteUI: TClienteUI;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.CaFree;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FClienteUI := TClienteUI.Create;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FClienteUI.Free;
end;

procedure TfrmPrincipal.mnuCadastroClientesClick(Sender: TObject);
begin
  FClienteUI.Abrir;
end;

end.
