inherited fmCadProdutor: TfmCadProdutor
  Caption = 'fmCadProdutor'
  ClientHeight = 608
  OnActivate = FormActivate
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel [0]
    Left = 16
    Top = 312
    Width = 96
    Height = 13
    Caption = 'Limite de Cr'#233'dito'
  end
  inherited paTopo: TPanel
    inherited Label1: TLabel
      Width = 230
      Caption = 'Cadastro de Produtor'
      ExplicitWidth = 230
    end
  end
  inherited paMeio: TPanel
    Height = 559
    ExplicitHeight = 559
    inherited paBotoes: TPanel
      inherited bbIncluir: TBitBtn
        Left = 317
        ExplicitLeft = 317
      end
      inherited bbAlterar: TBitBtn
        Left = 398
        ExplicitLeft = 398
      end
      inherited bbGravar: TBitBtn
        Left = 479
        ExplicitLeft = 479
      end
      inherited bbCancelar: TBitBtn
        Left = 560
        ExplicitLeft = 560
      end
      object DBNavigator: TDBNavigator
        Left = 15
        Top = 5
        Width = 210
        Height = 25
        DataSource = DataSource
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
        TabOrder = 4
      end
    end
    inherited bbAjuda: TBitBtn
      Left = 723
      ExplicitLeft = 723
    end
    inherited bbFechar: TBitBtn
      Left = 804
      ExplicitLeft = 804
    end
    inherited bbLocaliza: TBitBtn
      Left = 642
      ExplicitLeft = 642
    end
    object dbgProdutor: TDBGrid
      Left = 1
      Top = 368
      Width = 878
      Height = 190
      Align = alBottom
      DataSource = DataSource
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
    end
    object paPrincipal: TPanel
      Left = 1
      Top = 49
      Width = 878
      Height = 144
      Align = alTop
      TabOrder = 5
      ExplicitTop = 43
      object Label2: TLabel
        Left = 16
        Top = 8
        Width = 40
        Height = 13
        Caption = 'C'#243'digo'
        FocusControl = DBEdit1
      end
      object Label5: TLabel
        Left = 15
        Top = 64
        Width = 33
        Height = 13
        Caption = 'Nome'
      end
      object Label8: TLabel
        Left = 136
        Top = 288
        Width = 97
        Height = 13
        Caption = 'USUARIOALTER'
        FocusControl = DBEdit7
      end
      object Label9: TLabel
        Left = 136
        Top = 328
        Width = 109
        Height = 13
        Caption = 'DATAHORAALTER'
        FocusControl = DBEdit8
      end
      object Label10: TLabel
        Left = 136
        Top = 368
        Width = 58
        Height = 13
        Caption = 'PSTATUS'
        FocusControl = DBEdit9
      end
      object Label3: TLabel
        Left = 391
        Top = 16
        Width = 90
        Height = 13
        Caption = 'Inscri'#231#227'o Fiscal'
      end
      object DBEdit1: TDBEdit
        Left = 16
        Top = 27
        Width = 134
        Height = 21
        DataField = 'PRODUTOR_ID'
        DataSource = DataSource
        TabOrder = 0
      end
      object DBEdit6: TDBEdit
        Left = 136
        Top = 264
        Width = 446
        Height = 21
        DataField = 'DATAHORACAD'
        TabOrder = 1
      end
      object DBEdit7: TDBEdit
        Left = 136
        Top = 304
        Width = 134
        Height = 21
        DataField = 'USUARIOALTER'
        TabOrder = 2
      end
      object DBEdit8: TDBEdit
        Left = 136
        Top = 344
        Width = 446
        Height = 21
        DataField = 'DATAHORAALTER'
        TabOrder = 3
      end
      object DBEdit9: TDBEdit
        Left = 136
        Top = 384
        Width = 134
        Height = 21
        DataField = 'PSTATUS'
        TabOrder = 4
      end
      object dbeInscricaoCPF: TDBEdit
        Left = 389
        Top = 34
        Width = 186
        Height = 21
        DataField = 'P_INSCRICAOFISCAL'
        DataSource = DataSource
        TabOrder = 5
      end
      object dbrgbTipoProdutor: TDBRadioGroup
        Left = 184
        Top = 6
        Width = 185
        Height = 51
        Caption = 'Tipo Pessoa'
        Columns = 2
        DataField = 'P_TIPO'
        DataSource = DataSource
        Items.Strings = (
          'F'#237'sica'
          'Jur'#237'dica')
        TabOrder = 6
        Values.Strings = (
          '1'
          '2')
        OnClick = dbrgbTipoProdutorClick
      end
      object DBEdit4: TDBEdit
        Left = 16
        Top = 80
        Width = 559
        Height = 21
        DataField = 'P_NOME'
        DataSource = DataSource
        TabOrder = 7
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 193
      Width = 878
      Height = 128
      Align = alTop
      Caption = 'Distribuidor/Limite de Cr'#233'dito'
      TabOrder = 6
      object Label4: TLabel
        Left = 536
        Top = 24
        Width = 32
        Height = 13
        Caption = 'CNPJ'
      end
      object DBEdit2: TDBEdit
        Left = 16
        Top = 93
        Width = 134
        Height = 21
        DataSource = dsProdutorDistribuidor
        TabOrder = 0
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 16
        Top = 40
        Width = 511
        Height = 21
        DataSource = DataSource
        ListSource = dsDistribuidor
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 536
        Top = 40
        Width = 185
        Height = 21
        DataSource = dsDistribuidor
        TabOrder = 2
      end
    end
    object BitBtn1: TBitBtn
      Left = 328
      Top = 336
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 7
    end
    object BitBtn2: TBitBtn
      Left = 432
      Top = 337
      Width = 75
      Height = 25
      Caption = 'Remover'
      TabOrder = 8
    end
  end
  inherited DataSource: TDataSource
    DataSet = dmProdutor.fdqyProdutor
    Left = 392
  end
  object dsDistribuidor: TDataSource
    AutoEdit = False
    Left = 720
    Top = 257
  end
  object dsProdutorDistribuidor: TDataSource
    Left = 712
    Top = 441
  end
end
