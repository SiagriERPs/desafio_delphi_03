inherited FrmManutencaoNegociacao: TFrmManutencaoNegociacao
  Caption = 'Manuten'#231#227'o da Negocia'#231#227'o'
  ClientHeight = 320
  ClientWidth = 970
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 976
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 970
    Height = 121
    Align = alTop
    TabOrder = 0
    object lblId: TLabel
      Left = 13
      Top = 64
      Width = 110
      Height = 13
      Caption = 'C'#243'digo da Negocia'#231#227'o:'
    end
    object lblTitulo: TLabel
      Left = 20
      Top = 11
      Width = 222
      Height = 19
      Caption = 'Manuten'#231#227'o de Negocia'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object spbPesquisar: TSpeedButton
      Left = 148
      Top = 70
      Width = 110
      Height = 30
      BiDiMode = bdLeftToRight
      Caption = 'Pesquisar'
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
      ParentBiDiMode = False
      OnClick = spbPesquisarClick
    end
    object edtNegociacaoId: TEdit
      Left = 13
      Top = 79
      Width = 121
      Height = 21
      MaxLength = 255
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 121
    Width = 128
    Height = 199
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object spbConcluir: TSpeedButton
      Left = 10
      Top = 40
      Width = 110
      Height = 30
      BiDiMode = bdLeftToRight
      Caption = 'Concluir'
      Glyph.Data = {
        9E050000424D9E05000000000000360400002800000012000000120000000100
        08000000000068010000120B0000120B00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF07FFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFF700F7FFFFFFFFFFFFFFFFFF0000FFFFFFFFFF0700490008
        FFFFFFFFFFFFFFFF0000FFFFFFFF08524949495AF6FFFFFFFFFFFFFF0000FFFF
        FFFF5B4949494949A4FFFFFFFFFFFFFF0000FFFFFF9B49494951495149F7FFFF
        FFFFFFFF0000FFFFF7494949070752494951F6FFFFFFFFFF0000FF0752494907
        FFFF070052499BFFFFFFFFFF0000F6524952F6FFFFFFFF07495249A4FFFFFFFF
        0000F74952F6FFFFFFFFFFFFF749525207FFFFFF0000529BF6FFFFFFFFFFFFFF
        FF07005252FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFF74949A4FFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFFFFF74952F7FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F74952F60000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4499B0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF75B0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6
        0000}
      ParentBiDiMode = False
      OnClick = spbConcluirClick
    end
    object spbAprovar: TSpeedButton
      Left = 10
      Top = 5
      Width = 110
      Height = 30
      BiDiMode = bdLeftToRight
      Caption = 'Aprovar'
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000120B0000120B0000000100000000000000000000FFFF
        FF008A8A8A004B4B4B0099999900000000000000000000000000000000000000
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
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000010101010101
        0101010101010101010101010101010101010101010101010101010200000000
        0002010101010101010101010101010101010102000000000002010101010101
        0101010101010101010101020000000000020101010101010101010101010101
        0101010200000000000201010101010101010101010101010101010200000000
        0002010101010101010101010101010101010102000000000002010101010101
        0101010101010101010101040000000000040101010101010101010102020202
        0202020300000000000302020202020202010101000000000000000000000000
        0000000000000000000101010000000000000000000000000000000000000000
        0001010100000000000000000000000000000000000000000001010100000000
        0000000000000000000000000000000000010101000000000000000000000000
        0000000000000000000101010202020202020203000000000003020202020202
        0201010101010101010101040000000000040101010101010101010101010101
        0101010200000000000201010101010101010101010101010101010200000000
        0002010101010101010101010101010101010102000000000002010101010101
        0101010101010101010101020000000000020101010101010101010101010101
        0101010200000000000201010101010101010101010101010101010200000000
        0002010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101}
      ParentBiDiMode = False
      OnClick = spbAprovarClick
    end
    object spbCancelar: TSpeedButton
      Left = 10
      Top = 76
      Width = 110
      Height = 30
      BiDiMode = bdLeftToRight
      Caption = 'Cancelar'
      Glyph.Data = {
        C6050000424DC605000000000000360400002800000014000000140000000100
        08000000000090010000120B0000120B00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        079B000000009B07FFFFFFFFFFFFFFFFFFFF075200000000000000005207FFFF
        FFFFFFFFFFF70000495BA4F7F7A45B000000F7FFFFFFFFFFF7000000A4FFFFFF
        FFFFF607520000F7FFFFFF07000000004907FFFFFFFFFFFFFF52000007FFFF5B
        00000000000007FFFFFFFFFFFFFF52005BFF080049A4490000004907FFFFFFFF
        FFFF07000008A4005BFF07000000000007FFFFFFFFFFF65B00A44900A4FFFF07
        490000004907FFFFFFFFFFA400490049F7FFFFFF07490049004907FFFFFFFFF7
        49000049F7FFFFFFFF07490049004907FFFFFFF749004900F7FFFFFFFFFF0752
        0049004907FFFFA40049A4009BF6FFFFFFFFFF07494949004907FF9B00A40849
        4907FFFFFFFFFFFF074949494952A4524908FF9B005BFFFFFFFFFFFFFF074949
        494949009BFFFF0849005BFFFFFFFFFFFFFF08524949494908FFFFFFF749009B
        08F6FFFFFFFFFFF7494949F7FFFFFFFFFFF75249529BF70707F79B524952F7FF
        FFFFFFFFFFFF089B49494952524949499B08FFFFFFFFFFFFFFFFFFFF08A45249
        5252A408FFFFFFFFFFFF}
      ParentBiDiMode = False
      OnClick = spbCancelarClick
    end
    object spbSair: TSpeedButton
      Left = 8
      Top = 155
      Width = 110
      Height = 30
      Caption = 'Sair'
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        080000000000400200009B0E00009B0E0000000100000000000000000000D7D7
        D7007D7D7D0033333300C3C3C300FFFFFF004C4C4C00A0A0A000181818007777
        7700EDEDED0099999900BCBCBC00444444006666660041414100CCCCCC00DEDE
        DE0026262600F0F0F000A5A5A500030303005252520037373700FBFBFB00ADAD
        AD00DDDDDD00E5E5E500828282003D3D3D00C7C7C7009C9C9C00575757004E4E
        4E00C1C1C100E3E3E3000909090047474700000000001A1A1A00A3A3A300EFEF
        EF005050500049494900C5C5C500C9C9C9000000000000000000000000000000
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
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000005050505130D
        0000000000000000000000000024090505050505050A06000000000000000000
        000000000000001C05050505050E00212D1010101010101010101010100C0800
        0A050505051D0007050505050505050505050505050525001A050505050F000B
        05050505050505050505050505050D001A050505050F000B0505050505050505
        050505050505170011050505050F000B0505050505050505052D061B05051415
        01050505050F000B0505050505050505051F00271E05050423050505050F000B
        0505050505050505051900001528050505050505050F000B0505050B16161616
        160300000000020505050505050F000B05050527000000000000000000000020
        18050505050F000B0505051200000000000000000000000003220505050F000B
        0505051200000000000000000000000003220505050F000B0505052700000000
        000000000000002018050505050F000B0505050B161616161603000000000205
        05050505050F000B0505050505050505051900001528050505050505050F000B
        0505050505050505051F00271E05050423050505050F000B0505050505050505
        052C2B1B0505141501050505050F000B05050505050505050505050505051700
        11050505050F000B05050505050505050505050505050D001A050505051D0007
        050505050505050505050505050525001A050505050E00212D10101010101010
        10101010100C08000A050505050A06000000000000000000000000000000001C
        050505050505130D000000000000000000000000002409050505}
      OnClick = spbSairClick
    end
  end
  object dbgNegociacao: TDBGrid
    Left = 128
    Top = 121
    Width = 842
    Height = 199
    Align = alClient
    DataSource = dsPesquisaNegociacao
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NEGOCIACAO_ID'
        Title.Caption = 'C'#243'd. Negociacao'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 121
        Visible = True
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Caption = 'Vlr. Total'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = 'Status'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CADASTRO'
        Title.Caption = 'Data Cadastro'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_APROVACAO'
        Title.Caption = 'Data Aprova'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CONCLUSAO'
        Title.Caption = 'Data Conclus'#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 109
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CANCELAMENTO'
        Title.Caption = 'Data Cancelamento'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 140
        Visible = True
      end>
  end
  object qryPesquisaNegociacao: TFDQuery
    Connection = DM.FDConnection
    SQL.Strings = (
      'SELECT tn.negociacao_id'
      '     , tn.produtor_id'
      '     , tn.distribuidor_id'
      '     , tn.data_cadastro'
      '     , tn.status'
      '     , tn.valor_total'
      '     , tn.data_aprovacao'
      '     , tn.data_conclusao'
      '     , tn.data_cancelamento'
      '  FROM tab_negociacao tn'
      ''
      ' WHERE tn.status        = '#39'Pendente'#39
      '   AND tn.negociacao_id = 1')
    Left = 440
    Top = 208
    object qryPesquisaNegociacaoNEGOCIACAO_ID: TIntegerField
      FieldName = 'NEGOCIACAO_ID'
      Origin = 'NEGOCIACAO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaNegociacaoPRODUTOR_ID: TIntegerField
      FieldName = 'PRODUTOR_ID'
      Origin = 'PRODUTOR_ID'
      Required = True
    end
    object qryPesquisaNegociacaoDISTRIBUIDOR_ID: TIntegerField
      FieldName = 'DISTRIBUIDOR_ID'
      Origin = 'DISTRIBUIDOR_ID'
      Required = True
    end
    object qryPesquisaNegociacaoDATA_CADASTRO: TSQLTimeStampField
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
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
    object qryPesquisaNegociacaoDATA_APROVACAO: TSQLTimeStampField
      FieldName = 'DATA_APROVACAO'
      Origin = 'DATA_APROVACAO'
    end
    object qryPesquisaNegociacaoDATA_CONCLUSAO: TSQLTimeStampField
      FieldName = 'DATA_CONCLUSAO'
      Origin = 'DATA_CONCLUSAO'
    end
    object qryPesquisaNegociacaoDATA_CANCELAMENTO: TSQLTimeStampField
      FieldName = 'DATA_CANCELAMENTO'
      Origin = 'DATA_CANCELAMENTO'
    end
  end
  object dsPesquisaNegociacao: TDataSource
    DataSet = qryPesquisaNegociacao
    Left = 552
    Top = 208
  end
end
