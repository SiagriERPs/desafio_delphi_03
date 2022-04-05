inherited frmCadProdutores: TfrmCadProdutores
  Caption = ' Aliare - Cadastro de Produtores'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlComandos: TPanel
    inherited btnAlterar: TButton
      ExplicitLeft = 3
      ExplicitTop = 48
    end
    inherited btnExcluir: TButton
      ExplicitLeft = 3
      ExplicitTop = 94
    end
    inherited btnGravar: TButton
      ExplicitLeft = 3
      ExplicitTop = 140
    end
    inherited btnVoltar: TButton
      ExplicitLeft = 3
      ExplicitTop = 232
    end
  end
  inherited pgGeral: TPageControl
    ActivePage = tbshtCadastro
    inherited tbShtGrid: TTabSheet
      inherited Grid1: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Title.Alignment = taCenter
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Alignment = taCenter
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CPF_CNPJ'
            Title.Alignment = taCenter
            Width = 120
            Visible = True
          end>
      end
    end
    inherited tbshtCadastro: TTabSheet
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 38
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel
        Left = 24
        Top = 61
        Width = 30
        Height = 13
        Caption = 'Nome'
      end
      object Label3: TLabel
        Left = 24
        Top = 108
        Width = 47
        Height = 13
        Caption = 'CPF/CNPJ'
      end
      object dbedtID: TDBEdit
        Left = 24
        Top = 35
        Width = 65
        Height = 21
        TabStop = False
        Color = clInfoBk
        DataField = 'ID'
        DataSource = dsrCadastro
        ReadOnly = True
        TabOrder = 0
      end
      object dbedtNOME: TDBEdit
        Left = 24
        Top = 80
        Width = 513
        Height = 21
        CharCase = ecUpperCase
        DataField = 'NOME'
        DataSource = dsrCadastro
        TabOrder = 1
      end
      object dbedtCPF_CNPJ: TDBEdit
        Left = 24
        Top = 128
        Width = 177
        Height = 21
        DataField = 'CPF_CNPJ'
        DataSource = dsrCadastro
        TabOrder = 2
        OnKeyPress = dbedtCPF_CNPJKeyPress
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 209
        Width = 595
        Height = 174
        Align = alBottom
        DataSource = dsrLimites
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        OnKeyDown = DBGrid1KeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_DISTRIBUIDOR'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CL_DISTRIBUIDOR'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Distribuidor'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LIMITE_CREDITO'
            Title.Alignment = taRightJustify
            Title.Caption = 'Limite Cr'#233'dito'
            Width = 100
            Visible = True
          end>
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 155
        Width = 595
        Height = 54
        Align = alBottom
        Caption = 
          '                                                                ' +
          '     Limite(s) de Cr'#233'dito por Distribuidor '
        TabOrder = 4
        object Label4: TLabel
          Left = 10
          Top = 10
          Width = 38
          Height = 13
          Caption = 'C'#243'digo'
        end
        object Label5: TLabel
          Left = 88
          Top = 10
          Width = 95
          Height = 13
          Caption = 'Nome Distribuidor'
        end
        object Label6: TLabel
          Left = 430
          Top = 10
          Width = 59
          Height = 13
          Caption = 'Valor Limite'
        end
        object btnIncluirLimite: TButton
          Left = 516
          Top = 26
          Width = 76
          Height = 22
          Caption = 'Incluir'
          ImageIndex = 8
          ImageMargins.Left = 10
          Images = DM.ImageList1
          TabOrder = 3
          OnClick = btnIncluirLimiteClick
        end
        object edtCodDistribuidor: TEdit
          Tag = 1
          Left = 8
          Top = 27
          Width = 74
          Height = 21
          Alignment = taCenter
          TabOrder = 0
          OnEnter = edtCodDistribuidorEnter
          OnExit = edtCodDistribuidorExit
          OnKeyDown = edtCodDistribuidorKeyDown
          OnKeyPress = edtCodDistribuidorKeyPress
        end
        object edtNomeDistribuidor: TEdit
          Left = 88
          Top = 26
          Width = 336
          Height = 21
          TabStop = False
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 1
        end
        object edtValorLimite: TEdit
          Left = 430
          Top = 26
          Width = 81
          Height = 21
          TabOrder = 2
          OnKeyPress = edtValorLimiteKeyPress
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 383
        Width = 595
        Height = 15
        Align = alBottom
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = ' [Del] - Excluir Limite Selecionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  inherited dsrCadastro: TDataSource
    DataSet = FDQCadastro
  end
  object FDQCadastro: TFDQuery
    AfterOpen = FDQCadastroAfterOpen
    Connection = DM.con
    SQL.Strings = (
      'select'
      '*'
      'from produtores')
    Left = 635
    Top = 374
    object FDQCadastroID: TIntegerField
      Alignment = taCenter
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQCadastroNOME: TStringField
      Tag = 10
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 120
    end
    object FDQCadastroCPF_CNPJ: TStringField
      Tag = 10
      Alignment = taCenter
      DisplayLabel = 'Cpf / Cnpj'
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      Required = True
      OnGetText = FDQCadastroCPF_CNPJGetText
      Size = 14
    end
  end
  object FDQLimite: TFDQuery
    OnCalcFields = FDQLimiteCalcFields
    IndexFieldNames = 'ID_PRODUTOR'
    MasterSource = dsrCadastro
    MasterFields = 'ID'
    Connection = DM.con
    SQL.Strings = (
      'select'
      '*'
      'from PRODUTORES_LIMITES'
      'where id_produtor = :id')
    Left = 124
    Top = 358
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQLimiteID: TIntegerField
      Alignment = taCenter
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQLimiteID_PRODUTOR: TIntegerField
      FieldName = 'ID_PRODUTOR'
      Origin = 'ID_PRODUTOR'
      Required = True
    end
    object FDQLimiteID_DISTRIBUIDOR: TIntegerField
      Alignment = taCenter
      FieldName = 'ID_DISTRIBUIDOR'
      Origin = 'ID_DISTRIBUIDOR'
      Required = True
    end
    object FDQLimiteCL_DISTRIBUIDOR: TStringField
      FieldKind = fkCalculated
      FieldName = 'CL_DISTRIBUIDOR'
      Size = 120
      Calculated = True
    end
    object FDQLimiteLIMITE_CREDITO: TFMTBCDField
      FieldName = 'LIMITE_CREDITO'
      Origin = 'LIMITE_CREDITO'
      Required = True
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
  end
  object dsrLimites: TDataSource
    DataSet = FDQLimite
    Left = 60
    Top = 334
  end
end
