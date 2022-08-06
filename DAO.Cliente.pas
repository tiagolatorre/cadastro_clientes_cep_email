unit DAO.Cliente;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdtmDaoCliente = class(TDataModule)
    cdsCliente: TClientDataSet;
    cdsClientenome: TStringField;
    cdsClienteidentidade: TStringField;
    cdsClientecpf: TStringField;
    cdsClientetelefone: TStringField;
    cdsClienteemail: TStringField;
    cdsClienteCEP: TStringField;
    cdsClientelogradouro: TStringField;
    cdsClientenumero: TStringField;
    cdsClientecomplemento: TStringField;
    cdsClientebairro: TStringField;
    cdsClientecidade: TStringField;
    cdsClienteestado: TStringField;
    cdsClientepais: TStringField;
    cdsClienteid: TAutoIncField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmDaoCliente: TdtmDaoCliente;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
