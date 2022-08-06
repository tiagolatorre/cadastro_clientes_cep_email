object dtmDaoCliente: TdtmDaoCliente
  OldCreateOrder = False
  Height = 380
  Width = 480
  object cdsCliente: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'identidade'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'cpf'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'telefone'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'email'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CEP'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'logradouro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'numero'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'complemento'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'estado'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'pais'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 96
    object cdsClienteid: TAutoIncField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object cdsClientenome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 50
    end
    object cdsClienteidentidade: TStringField
      DisplayLabel = 'Identidade'
      FieldName = 'identidade'
      Size = 10
    end
    object cdsClientecpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
      Size = 14
    end
    object cdsClientetelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 15
    end
    object cdsClienteemail: TStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
    end
    object cdsClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsClientelogradouro: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'logradouro'
      Size = 50
    end
    object cdsClientenumero: TStringField
      DisplayLabel = 'Numero'
      FieldName = 'numero'
      Size = 10
    end
    object cdsClientecomplemento: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'complemento'
      Size = 30
    end
    object cdsClientebairro: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 50
    end
    object cdsClientecidade: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 50
    end
    object cdsClienteestado: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object cdsClientepais: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'pais'
      Size = 50
    end
  end
end
