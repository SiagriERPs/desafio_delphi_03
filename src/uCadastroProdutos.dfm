inherited frmCadProdutos: TfrmCadProdutos
  Caption = ' Aliare - Cadastro de Produtos'
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
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 595
      ExplicitHeight = 398
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
            FieldName = 'DESCRICAO'
            Title.Alignment = taCenter
            Width = 320
            Visible = True
          end
          item
            ButtonStyle = cbsNone
            Expanded = False
            FieldName = 'PRECO_VENDA'
            Title.Alignment = taRightJustify
            Width = 100
            Visible = True
          end>
      end
    end
    inherited tbshtCadastro: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 595
      ExplicitHeight = 398
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 38
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel
        Left = 24
        Top = 80
        Width = 49
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label3: TLabel
        Left = 24
        Top = 143
        Width = 79
        Height = 13
        Caption = 'Pre'#231'o de Venda'
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
      object dbedtDESCRICAO: TDBEdit
        Left = 24
        Top = 99
        Width = 513
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DESCRICAO'
        DataSource = dsrCadastro
        TabOrder = 1
      end
      object dbedtPRECO_VENDA: TDBEdit
        Left = 24
        Top = 162
        Width = 105
        Height = 21
        DataField = 'PRECO_VENDA'
        DataSource = dsrCadastro
        TabOrder = 2
        OnKeyPress = dbedtPRECO_VENDAKeyPress
      end
    end
  end
  inherited dsrCadastro: TDataSource
    DataSet = FDQCadastro
  end
  object FDQCadastro: TFDQuery
    IndexFieldNames = 'ID'
    Connection = DM.con
    SQL.Strings = (
      'select'
      '*'
      'from produtos')
    Left = 635
    Top = 382
    object FDQCadastroID: TIntegerField
      Alignment = taCenter
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQCadastroDESCRICAO: TStringField
      Tag = 10
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 80
    end
    object FDQCadastroPRECO_VENDA: TFMTBCDField
      Tag = 10
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Required = True
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 7
    end
  end
end
