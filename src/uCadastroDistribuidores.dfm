inherited frmCadDistribuidores: TfrmCadDistribuidores
  Caption = ' Aliare - Cadastro de Distribuidores'
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
            FieldName = 'NOME'
            Title.Alignment = taCenter
            Width = 360
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CNPJ'
            Title.Alignment = taCenter
            Width = 120
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
        Width = 30
        Height = 13
        Caption = 'Nome'
      end
      object Label3: TLabel
        Left = 24
        Top = 143
        Width = 24
        Height = 13
        Caption = 'CNPJ'
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
        Top = 99
        Width = 513
        Height = 21
        CharCase = ecUpperCase
        DataField = 'NOME'
        DataSource = dsrCadastro
        TabOrder = 1
      end
      object dbedtCNPJ: TDBEdit
        Left = 24
        Top = 162
        Width = 177
        Height = 21
        DataField = 'CNPJ'
        DataSource = dsrCadastro
        TabOrder = 2
        OnKeyPress = dbedtCNPJKeyPress
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
      'from distribuidores')
    Left = 651
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
    object FDQCadastroCNPJ: TStringField
      Tag = 10
      Alignment = taCenter
      DisplayLabel = 'Cnpj'
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Required = True
      OnGetText = FDQCadastroCNPJGetText
      Size = 14
    end
  end
end
