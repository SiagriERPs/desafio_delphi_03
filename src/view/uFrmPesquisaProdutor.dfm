inherited FrmPesquisaProdutor: TFrmPesquisaProdutor
  Caption = 'Pesquisa Produtor'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFilter: TPanel
    inherited edtNome: TEdit
      OnKeyPress = edtNomeKeyPress
    end
    object rbNome: TRadioButton
      Left = 359
      Top = 11
      Width = 47
      Height = 17
      Caption = 'Nome'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbCodigo: TRadioButton
      Left = 287
      Top = 11
      Width = 59
      Height = 17
      Caption = 'C'#243'digo'
      TabOrder = 2
    end
  end
  object dbgProdutor: TDBGrid
    Left = 0
    Top = 65
    Width = 560
    Height = 265
    Align = alClient
    DataSource = dsPesquisaProdutor
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgProdutorDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PRODUTOR_ID'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF_CNPJ'
        Title.Caption = 'CPF/CNPJ'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LIMITE_CREDITO'
        Title.Caption = 'Limite de Cr'#233'dito'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object dsPesquisaProdutor: TDataSource
    DataSet = qryPesquisaProdutor
    Left = 192
    Top = 224
  end
  object qryPesquisaProdutor: TFDQuery
    Connection = DM.FDConnection
    SQL.Strings = (
      'SELECT'
      '  produtor_id,'
      '  nome,'
      '  cpf_cnpj,'
      '  limite_credito'
      'FROM'
      '  tab_produtor')
    Left = 192
    Top = 160
    object qryPesquisaProdutorPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaProdutorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object qryPesquisaProdutorCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      Required = True
    end
    object qryPesquisaProdutorLIMITE_CREDITO: TBCDField
      FieldName = 'LIMITE_CREDITO'
      Origin = 'LIMITE_CREDITO'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
end
