inherited FrmPesquisaBasico: TFrmPesquisaBasico
  Caption = 'Pesquisa B'#225'sica'
  ClientHeight = 330
  ClientWidth = 560
  ExplicitWidth = 566
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 560
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblFilter: TLabel
      Left = 13
      Top = 11
      Width = 117
      Height = 19
      Caption = 'Pesquisar por:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object spbPesquisa: TSpeedButton
      Left = 413
      Top = 31
      Width = 23
      Height = 22
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000120B0000120B0000000100000000000000000000E7E7
        E7008181810042424200BFBFBF00181818006A6A6A00A3A3A300FFFFFF00D0D0
        D00030303000585858000A0A0A008E8E8E00B4B4B400F5F5F5006F6F6F002828
        2800DCDCDC00C9C9C900A6A6A600A1A1A100F3F3F30066666600040404007474
        74003A3A3A0048484800ADADAD001111110087878700EEEEEE00D9D9D900F8F8
        F8001E1E1E00C5C5C50060606000E5E5E500EDEDED00D7D7D700101010009494
        94007B7B7B00363636008C8C8C0046464600CCCCCC00FCFCFC00EAEAEA008585
        8500C3C3C30093939300E0E0E0004C4C4C00161616006C6C6C00060606007070
        70004A4A4A00F1F1F100DBDBDB001B1B1B00A7A7A700C7C7C700838383004444
        4400C1C1C10033333300767676003D3D3D00AFAFAF0014141400FFFFFF000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000080808080808
        0808080808080808080808080808080808080808080808080808080808080808
        080808080F2B3108080808080808080808080808080808080808081635000C07
        080808080808080808080808080808080808161B000000181E08080808080808
        080808080808080808213A00000000000B080808080808080808080808080808
        162D000000000039080808080808080808080808080808161B00000000000608
        0808080808080808080808080808213A00000000003708080808080808080808
        2307070742123A000000000037080808080808080808091B0000000000050000
        00000006080808080808080808321D002D070E1C240000000000370808080808
        08080808343D1807080808080823220018100808080808080808080839002908
        0808080808082E00221608080808080808080830364321080808080808080824
        380408080808080808080827002A0808080808080808081C0015080808080808
        0808082E00020808080808080808080E00070808080808080808082000060808
        080808080808081400070808080808080808083B112226080808080808080803
        3813080808080808080808080D00060808080808080807001B2F080808080808
        080808080F450037260808080F33001D09080808080808080808080808251A00
        363940190A00052308080808080808080808080808083B2C1100000047443C08
        080808080808080808080808080808081F3C2E27010808080808080808080808
        0808080808080808080808080808080808080808080808080808}
      OnClick = spbPesquisaClick
    end
    object edtNome: TEdit
      Left = 13
      Top = 31
      Width = 394
      Height = 21
      MaxLength = 255
      TabOrder = 0
    end
  end
end
