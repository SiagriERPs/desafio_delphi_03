inherited frmCadPadrao: TfrmCadPadrao
  Caption = 'Cadastro Padr'#227'o'
  ClientHeight = 471
  ClientWidth = 711
  OnCreate = FormCreate
  ExplicitWidth = 711
  ExplicitHeight = 471
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTopo: TPanel
    Width = 711
    ExplicitWidth = 711
    inherited btnMinimizar: TSpeedButton
      Left = 651
      ExplicitLeft = 651
    end
    inherited btnFechar: TSpeedButton
      Left = 681
      ExplicitLeft = 681
    end
  end
  inherited pnlBotton: TPanel
    Top = 456
    Width = 711
    TabOrder = 3
    ExplicitTop = 456
    ExplicitWidth = 711
  end
  object pnlComandos: TPanel
    Left = 603
    Top = 30
    Width = 108
    Height = 426
    Align = alRight
    BevelOuter = bvNone
    Color = clScrollBar
    ParentBackground = False
    TabOrder = 2
    object btnAlterar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 48
      Width = 102
      Height = 42
      Margins.Top = 2
      Margins.Bottom = 2
      Action = actAlterar
      Align = alTop
      ImageAlignment = iaTop
      ImageMargins.Top = 7
      ImageMargins.Bottom = -3
      Images = DM.ImageList1
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 55
    end
    object btnExcluir: TButton
      AlignWithMargins = True
      Left = 3
      Top = 94
      Width = 102
      Height = 42
      Margins.Top = 2
      Margins.Bottom = 2
      Action = actExcluir
      Align = alTop
      ImageAlignment = iaTop
      ImageMargins.Top = 7
      ImageMargins.Bottom = -3
      Images = DM.ImageList1
      TabOrder = 2
      ExplicitLeft = 2
      ExplicitTop = 101
    end
    object btnGravar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 140
      Width = 102
      Height = 42
      Margins.Top = 2
      Margins.Bottom = 2
      Action = actGravar
      Align = alTop
      ImageAlignment = iaTop
      ImageMargins.Top = 7
      ImageMargins.Bottom = -3
      Images = DM.ImageList1
      TabOrder = 3
      ExplicitLeft = 2
      ExplicitTop = 147
    end
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 186
      Width = 102
      Height = 42
      Margins.Top = 2
      Margins.Bottom = 2
      Action = actCancelar
      Align = alTop
      ImageAlignment = iaTop
      ImageMargins.Top = 7
      ImageMargins.Bottom = -3
      Images = DM.ImageList1
      TabOrder = 4
    end
    object btnVoltar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 232
      Width = 102
      Height = 42
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Voltar Grid'
      ImageAlignment = iaTop
      ImageIndex = 0
      ImageMargins.Top = 7
      ImageMargins.Bottom = -3
      Images = DM.ImageList1
      TabOrder = 5
      Visible = False
      OnClick = btnVoltarClick
      ExplicitLeft = 2
      ExplicitTop = 239
    end
    object btnNovo: TButton
      AlignWithMargins = True
      Left = 3
      Top = 2
      Width = 102
      Height = 42
      Margins.Top = 2
      Margins.Bottom = 2
      Action = actNovo
      Align = alTop
      ImageAlignment = iaTop
      ImageMargins.Top = 7
      ImageMargins.Bottom = -3
      Images = DM.ImageList1
      TabOrder = 0
    end
  end
  object pgGeral: TPageControl
    Left = 0
    Top = 30
    Width = 603
    Height = 426
    ActivePage = tbShtGrid
    Align = alClient
    TabOrder = 1
    object tbShtGrid: TTabSheet
      Caption = 'Grid'
      OnShow = tbShtGridShow
      object Grid1: TDBGrid
        Left = 0
        Top = 0
        Width = 595
        Height = 398
        Align = alClient
        DataSource = dsrCadastro
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDrawColumnCell = Grid1DrawColumnCell
        OnDblClick = Grid1DblClick
        OnKeyDown = Grid1KeyDown
      end
    end
    object tbshtCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      OnHide = tbshtCadastroHide
      OnShow = tbshtCadastroShow
    end
  end
  object actlst: TActionList
    Images = DM.ImageList1
    Left = 324
    Top = 323
    object actNovo: TAction
      Caption = '[F2] - Novo'
      ImageIndex = 6
      ShortCut = 113
      OnExecute = actNovoExecute
    end
    object actAlterar: TAction
      Caption = '[F3] - Alterar'
      ImageIndex = 4
      ShortCut = 114
      OnExecute = actAlterarExecute
    end
    object actExcluir: TAction
      Caption = '[F4] - Excluir'
      ImageIndex = 3
      ShortCut = 115
      OnExecute = actExcluirExecute
    end
    object actGravar: TAction
      Caption = '[F10] - Gravar'
      ImageIndex = 7
      ShortCut = 121
      OnExecute = actGravarExecute
    end
    object actCancelar: TAction
      Caption = '[ESC] - Cancelar'
      ImageIndex = 1
      ShortCut = 27
      OnExecute = actCancelarExecute
    end
  end
  object dsrCadastro: TDataSource
    OnDataChange = dsrCadastroDataChange
    Left = 523
    Top = 336
  end
end
