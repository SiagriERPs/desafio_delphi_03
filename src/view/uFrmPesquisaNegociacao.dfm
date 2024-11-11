inherited FrmPesquisaNegociacao: TFrmPesquisaNegociacao
  Caption = 'Pesquisa Negocia'#231#227'o'
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFilter: TPanel
    inherited edtNome: TEdit
      OnKeyPress = edtNomeKeyPress
    end
    object rbCodigo: TRadioButton
      Left = 354
      Top = 11
      Width = 52
      Height = 17
      Caption = 'C'#243'digo'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object dbgNegociacao: TDBGrid
    Left = 0
    Top = 65
    Width = 560
    Height = 265
    Align = alClient
    DataSource = dsPesquisaNegociacao
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgNegociacaoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NEGOCIACAO_ID'
        Title.Caption = 'C'#243'd. Contrato'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = 'Status'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Caption = 'Total Negocia'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRODUTOR'
        Title.Caption = 'Produtor'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISTRIBUIDOR'
        Title.Caption = 'Distribuidor'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end>
  end
  object qryPesquisaNegociacao: TFDQuery
    Connection = DM.FDConnection
    SQL.Strings = (
      ''
      'select neg.negociacao_id'
      '     , neg.status'
      '     , neg.valor_total'
      '     , neg.produtor_id'
      '     , pro.nome produtor'
      '     , neg.distribuidor_id'
      '     , dis.nome distribuidor'
      ''
      '  from tab_negociacao neg'
      ''
      'left join tab_produtor pro'
      'on neg.produtor_id = pro.produtor_id'
      ''
      'left join tab_distribuidor dis'
      'on neg.distribuidor_id = dis.distribuidor_id'
      ''
      'where'
      '  neg.negociacao_id = :negociacao_id'
      ''
      ''
      ''
      '')
    Left = 192
    Top = 160
    ParamData = <
      item
        Name = 'NEGOCIACAO_ID'
        ParamType = ptInput
      end>
    object qryPesquisaNegociacaoNEGOCIACAO_ID: TIntegerField
      FieldName = 'NEGOCIACAO_ID'
      Origin = 'NEGOCIACAO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaNegociacaoSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
    end
    object qryPesquisaNegociacaoVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object qryPesquisaNegociacaoPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      Required = True
    end
    object qryPesquisaNegociacaoPRODUTOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qryPesquisaNegociacaoDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      Required = True
    end
    object qryPesquisaNegociacaoDISTRIBUIDOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DISTRIBUIDOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object dsPesquisaNegociacao: TDataSource
    DataSet = qryPesquisaNegociacao
    Left = 192
    Top = 224
  end
end
