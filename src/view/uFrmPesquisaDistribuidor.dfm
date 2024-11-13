inherited FrmPesquisaDistribuidor: TFrmPesquisaDistribuidor
  Caption = 'Pesquisa Distribuidor'
  OnCreate = FormCreate
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
  object dbgDistribuidor: TDBGrid
    Left = 0
    Top = 65
    Width = 560
    Height = 265
    Align = alClient
    DataSource = dsPesquisaDistribuidor
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgDistribuidorDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DISTRIBUIDOR_ID'
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
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object qryPesquisaDistribuidor: TFDQuery
    Left = 192
    Top = 160
    object qryPesquisaDistribuidorDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaDistribuidorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object qryPesquisaDistribuidorCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Required = True
      EditMask = '00.000.000/0000-00;0;_'
    end
  end
  object dsPesquisaDistribuidor: TDataSource
    DataSet = qryPesquisaDistribuidor
    Left = 192
    Top = 224
  end
end
