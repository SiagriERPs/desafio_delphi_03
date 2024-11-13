inherited FrmCadProdutor: TFrmCadProdutor
  Caption = 'Cadastro de Produtor'
  ClientHeight = 600
  ClientWidth = 800
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 806
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Height = 600
    ExplicitHeight = 600
    inherited spbSair: TSpeedButton
      Top = 554
      ExplicitTop = 554
    end
  end
  inherited pgcMain: TPageControl
    Width = 671
    Height = 600
    ExplicitWidth = 671
    ExplicitHeight = 600
    inherited tbMain: TTabSheet
      ExplicitWidth = 663
      ExplicitHeight = 572
      object lblId: TLabel
        Left = 22
        Top = 32
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblName: TLabel
        Left = 24
        Top = 80
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object edtId: TEdit
        Left = 24
        Top = 51
        Width = 120
        Height = 21
        Color = clInfoBk
        Enabled = False
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TEdit
        Left = 24
        Top = 101
        Width = 296
        Height = 21
        MaxLength = 255
        TabOrder = 1
      end
      object rdgInformeCpfCnpj: TRadioGroup
        Left = 18
        Top = 140
        Width = 108
        Height = 56
        Caption = ' Informe  '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'CPF'
          'CNPJ')
        TabOrder = 2
        OnClick = rdgInformeCpfCnpjClick
      end
      object edtCPFCNPJ: TMaskEdit
        Left = 133
        Top = 173
        Width = 116
        Height = 21
        EditMask = '000.000.000-00;0;_'
        MaxLength = 14
        TabOrder = 3
        Text = ''
      end
      object pgcBottom: TPageControl
        Left = 0
        Top = 216
        Width = 663
        Height = 356
        ActivePage = tbBottom
        Align = alBottom
        TabOrder = 4
        object tbBottom: TTabSheet
          Caption = 'Distribuidores / Limite de Cr'#233'dito'
          object dbgLimiteCredito: TDBGrid
            Left = 0
            Top = 0
            Width = 544
            Height = 287
            Align = alClient
            DataSource = dsLimiteCredito
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'LIMITE_CREDITO_ID'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -13
                Title.Font.Name = 'Tahoma'
                Title.Font.Style = [fsBold]
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'PRODUTOR_ID'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -13
                Title.Font.Name = 'Tahoma'
                Title.Font.Style = [fsBold]
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'DISTRIBUIDOR_ID'
                Title.Caption = 'C'#243'd. Distribuidor'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -13
                Title.Font.Name = 'Tahoma'
                Title.Font.Style = [fsBold]
                Width = 123
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
                Width = 213
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
                Width = 127
                Visible = True
              end>
          end
          object Panel2: TPanel
            Left = 544
            Top = 0
            Width = 111
            Height = 287
            Align = alRight
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            object spbInserirLimiteCredito: TSpeedButton
              Left = 3
              Top = 1
              Width = 100
              Height = 30
              Caption = 'Inserir'
              Glyph.Data = {
                76060000424D7606000000000000360000002800000014000000140000000100
                20000000000040060000C40E0000C40E00000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FEFEFEFFF0F0F0FFFBFBFBFFF5F5F5FFFFFFFF00B3B3B3FF2D2D
                2DFF000000FF070707FF696969FFEEEEEEFFFFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3F3FF000000FF8181
                81FFFFFFFF007D7D7DFF000000FF010101FF7B7B7BFF3E3E3EFF000000FF2323
                23FFEEEEEEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00F2F2F2FF000000FF7D7D7DFFFFFFFF00070707FF000000FF0D0D
                0DFFFFFFFF00909090FF000000FF000000FF696969FFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AAAAAAFF383838FF000000FF2F2F
                2FFF707070FF000000FF808080FF9F9F9FFFFFFFFF00CFCFCFFF969696FF3535
                35FF000000FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D
                7DFF000000FF000000FF000000FF393939FF606060FF000000FFF2F2F2FFFFFF
                FF00FFFFFF00FFFFFF00FFFFFF006F6F6FFF000000FFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00818181FF000000FF000000FF0B0B0BFFA5A5A5FFFFFF
                FF00B6B6B6FF000000FF000000FF1A1A1AFFFFFFFF00969696FF000000FF0000
                00FF3D3D3DFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A9AFF4E4E
                4EFF2F2F2FFF989898FFFFFFFF00FFFFFF00FFFFFF00444444FF000000FF0C0C
                0CFFFFFFFF00888888FF000000FF000000FFADADADFFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFC
                FCFFEAEAEAFFDDDDDDFF585858FF000000FF000000FF000000FF000000FF8F8F
                8FFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00EAEAEAFF888888FF424242FF0F0F0FFF000000FF1C1C1CFF7D7D7DFF7272
                72FF676767FF868686FFE0E0E0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00B2B2B2FF000000FF000000FF000000FF0000
                00FF0E0E0EFF1A1A1AFF3B3B3BFFBABABAFFFFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D5D5FF2D2D
                2DFF000000FF000000FF656565FFE9E9E9FFFFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00BBBBBBFF0D0D0DFF000000FF0D0D0DFFF2F2F2FFFFFF
                FF00FFFFFF00FFFFFF00C7C7C7FF989898FFC6C6C6FFECECECFFFFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D0D0D0FF2828
                28FF000000FF000000FF7D7D7DFFFDFDFDFFFEFEFEFFA4A4A4FF0A0A0AFF0000
                00FF000000FFBABABAFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF009C9C9CFF000000FF000000FF000000FF0000
                00FF010101FF010101FF000000FF000000FF636363FFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00B6B6B6FF3F3F3FFF000000FF000000FF000000FF000000FF414141FFB0B0
                B0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2FF000000FF9292
                92FF929292FF000000FFF2F2F2FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00F3F3F3FF000000FFA0A0A0FFA0A0A0FF000000FFF3F3F3FFFFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
              OnClick = spbInserirLimiteCreditoClick
            end
            object spbRemoverLimiteCredito: TSpeedButton
              Left = 3
              Top = 35
              Width = 100
              Height = 30
              Caption = 'Remover'
              Glyph.Data = {
                76060000424D7606000000000000360000002800000014000000140000000100
                20000000000040060000C40E0000C40E00000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FEFEFEFFF0F0F0FFFBFBFBFFF5F5F5FFFFFFFF00B3B3B3FF2D2D
                2DFF000000FF070707FF696969FFEEEEEEFFFFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3F3FF000000FF8181
                81FFFFFFFF007D7D7DFF000000FF010101FF7B7B7BFF3E3E3EFF000000FF2323
                23FFEEEEEEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00F2F2F2FF000000FF7D7D7DFFFFFFFF00070707FF000000FF0D0D
                0DFFFFFFFF00909090FF000000FF000000FF696969FFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AAAAAAFF383838FF000000FF2F2F
                2FFF707070FF000000FF808080FF9F9F9FFFFFFFFF00CFCFCFFF969696FF3535
                35FF000000FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D
                7DFF000000FF000000FF000000FF393939FF606060FF000000FFF2F2F2FFFFFF
                FF00FFFFFF00FFFFFF00FFFFFF006F6F6FFF000000FFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00818181FF000000FF000000FF0B0B0BFFA5A5A5FFFFFF
                FF00B6B6B6FF000000FF000000FF1A1A1AFFFFFFFF00969696FF000000FF0000
                00FF3D3D3DFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A9AFF4E4E
                4EFF2F2F2FFF989898FFFFFFFF00FFFFFF00FFFFFF00444444FF000000FF0C0C
                0CFFFFFFFF00888888FF000000FF000000FFADADADFFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFC
                FCFFEAEAEAFFDDDDDDFF585858FF000000FF000000FF000000FF000000FF8F8F
                8FFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00EAEAEAFF888888FF424242FF0F0F0FFF000000FF1C1C1CFF7D7D7DFF7272
                72FF676767FF868686FFE0E0E0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00B2B2B2FF000000FF000000FF000000FF0000
                00FF0E0E0EFF1A1A1AFF3B3B3BFFBABABAFFFFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D5D5FF2D2D
                2DFF000000FF000000FF656565FFE9E9E9FFFFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00BBBBBBFF0D0D0DFF000000FF0D0D0DFFF2F2F2FFFFFF
                FF00FFFFFF00FFFFFF00C7C7C7FF989898FFC6C6C6FFECECECFFFFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D0D0D0FF2828
                28FF000000FF000000FF7D7D7DFFFDFDFDFFFEFEFEFFA4A4A4FF0A0A0AFF0000
                00FF000000FFBABABAFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF009C9C9CFF000000FF000000FF000000FF0000
                00FF010101FF010101FF000000FF000000FF636363FFFFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00B6B6B6FF3F3F3FFF000000FF000000FF000000FF000000FF414141FFB0B0
                B0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2FF000000FF9292
                92FF929292FF000000FFF2F2F2FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00F3F3F3FF000000FFA0A0A0FFA0A0A0FF000000FFF3F3F3FFFFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
              OnClick = spbRemoverLimiteCreditoClick
            end
          end
          object Panel1: TPanel
            Left = 0
            Top = 287
            Width = 655
            Height = 41
            Align = alBottom
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 2
            object lblTotalLimite: TLabel
              Left = 289
              Top = 6
              Width = 105
              Height = 19
              Caption = 'Total Limite:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object edtTotalLimiteCredito: TEdit
              Left = 399
              Top = 6
              Width = 145
              Height = 21
              Alignment = taRightJustify
              Color = clInfoBk
              Enabled = False
              NumbersOnly = True
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object cdsLimiteCredito: TClientDataSet
    PersistDataPacket.Data = {
      C90000009619E0BD010000001800000006000000000003000000C900114C494D
      4954455F4352454449544F5F494404000100000000000B50524F4455544F525F
      494404000100000000000F444953545249425549444F525F4944040001000000
      00000E4C494D4954455F4352454449544F080004000000010007535542545950
      450200490006004D6F6E6579000850524F4455544F5201004900000001000557
      494454480200020014000C444953545249425549444F52010049000000010005
      57494454480200020014000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 368
    object cdsLimiteCreditoLIMITE_CREDITO_ID: TIntegerField
      FieldName = 'LIMITE_CREDITO_ID'
    end
    object cdsLimiteCreditoPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
    end
    object cdsLimiteCreditoDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
    end
    object cdsLimiteCreditoLIMITE_CREDITO: TCurrencyField
      FieldName = 'LIMITE_CREDITO'
    end
    object cdsLimiteCreditoPRODUTOR: TStringField
      FieldName = 'PRODUTOR'
    end
    object cdsLimiteCreditoDISTRIBUIDOR: TStringField
      FieldName = 'DISTRIBUIDOR'
    end
  end
  object dsLimiteCredito: TDataSource
    DataSet = cdsLimiteCredito
    Left = 392
    Top = 416
  end
end
