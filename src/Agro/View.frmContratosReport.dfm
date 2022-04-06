object frmContratosReport: TfrmContratosReport
  Left = 0
  Top = 165
  ClientHeight = 441
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object rltContratos: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 67
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object Label1: TLabel
        Left = 3
        Top = 50
        Width = 9
        Height = 14
        Caption = 'ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 283
        Top = 13
        Width = 176
        Height = 19
        Caption = 'LISTA DE CONTRATOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 55
        Top = 50
        Width = 56
        Height = 14
        Caption = 'PRODUTOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 213
        Top = 50
        Width = 69
        Height = 14
        Caption = 'DISTRIBUIDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 371
        Top = 50
        Width = 27
        Height = 14
        Caption = 'DATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 662
        Top = 50
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'VL. TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 438
        Top = 50
        Width = 59
        Height = 14
        Caption = 'APROVADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 505
        Top = 50
        Width = 59
        Height = 14
        Caption = 'CONCLUIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 572
        Top = 50
        Width = 64
        Height = 14
        Caption = 'CANCELADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 105
      Width = 718
      Height = 18
      object RLDBText1: TRLDBText
        Left = 3
        Top = 1
        Width = 46
        Height = 14
        DataField = 'CONTRATO'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 55
        Top = 1
        Width = 152
        Height = 16
        AutoSize = False
        DataField = 'NM_PRODUTOR'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 213
        Top = 1
        Width = 152
        Height = 16
        AutoSize = False
        DataField = 'NM_DISTRIBUIDOR'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 371
        Top = 1
        Width = 61
        Height = 16
        AutoSize = False
        DataField = 'DT'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 651
        Top = 1
        Width = 64
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'TOTAL'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 438
        Top = 1
        Width = 61
        Height = 16
        AutoSize = False
        DataField = 'APROVADO'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText7: TRLDBText
        Left = 572
        Top = 1
        Width = 61
        Height = 16
        AutoSize = False
        DataField = 'CANCELADO'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 505
        Top = 1
        Width = 61
        Height = 16
        AutoSize = False
        DataField = 'CONCLUIDO'
        DataSource = dsReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 123
      Width = 718
      Height = 48
      BandType = btFooter
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLSystemInfo1: TRLSystemInfo
        Left = 676
        Top = 6
        Width = 87
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 3
        Top = 6
        Width = 118
        Height = 16
        Text = 'Impresso em '
      end
    end
  end
  object qyReport: TFDQuery
    Active = True
    Connection = DM.conexao
    SQL.Strings = (
      
        'SELECT C.ID AS CONTRATO, P.NOME AS NM_PRODUTOR, D.nome AS NM_DIS' +
        'TRIBUIDOR, C.total, C.DT,'
      
        '        coalesce(C.dt_aprovado,'#39#39') as APROVADO, coalesce(C.dt_co' +
        'ncluido, '#39#39') AS CONCLUIDO, coalesce(C.dt_cancelado, '#39#39') AS CANCE' +
        'LADO'
      'FROM CONTRATOS C'
      'INNER JOIN PRODUTOR P ON P.id = C.produtorid'
      'INNER JOIN DISTRIBUIDOR D ON D.id = C.distribuidorid')
    Left = 624
    Top = 272
    object qyReportCONTRATO: TIntegerField
      FieldName = 'CONTRATO'
      Origin = 'ID'
      Required = True
    end
    object qyReportNM_PRODUTOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NM_PRODUTOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qyReportNM_DISTRIBUIDOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NM_DISTRIBUIDOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qyReportTOTAL: TFMTBCDField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      Precision = 18
      Size = 2
    end
    object qyReportDT: TDateField
      FieldName = 'DT'
      Origin = 'DT'
    end
    object qyReportAPROVADO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'APROVADO'
      Origin = 'APROVADO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qyReportCONCLUIDO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONCLUIDO'
      Origin = 'CONCLUIDO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qyReportCANCELADO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CANCELADO'
      Origin = 'CANCELADO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
  end
  object dsReport: TDataSource
    DataSet = qyReport
    Left = 664
    Top = 272
  end
end
