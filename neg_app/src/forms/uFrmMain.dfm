object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 524
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MmMain
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PnlFull: TPanel
    Left = 0
    Top = 48
    Width = 862
    Height = 476
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object GridPanel1: TGridPanel
      Left = 0
      Top = 0
      Width = 862
      Height = 454
      Align = alClient
      Color = clWhite
      ColumnCollection = <
        item
          Value = 25.424748373471880000
        end
        item
          Value = 24.700887910502930000
        end
        item
          Value = 24.994301352803220000
        end
        item
          Value = 24.880062363221970000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = ScBxInitialScale
          Row = 1
        end
        item
          Column = 1
          Control = ScBxMoisture
          Row = 1
        end
        item
          Column = 2
          Control = ScBxFinalScale
          Row = 1
        end
        item
          Column = 3
          Control = ScBxFinalized
          Row = 1
        end
        item
          Column = 0
          Control = Panel1
          Row = 0
        end
        item
          Column = 1
          Control = Panel3
          Row = 0
        end
        item
          Column = 2
          Control = Panel4
          Row = 0
        end
        item
          Column = 3
          Control = Panel5
          Row = 0
        end
        item
          Column = 0
          Control = PnlTotalInitialScale
          Row = 2
        end
        item
          Column = 1
          Control = PnlTotalMoisture
          Row = 2
        end
        item
          Column = 2
          Control = PnlTotalFinalScale
          Row = 2
        end
        item
          Column = 3
          Control = PnlTotalFinalized
          Row = 2
        end>
      DoubleBuffered = True
      ExpandStyle = emAddColumns
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentDoubleBuffered = False
      ParentFont = False
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 48.000000000000000000
        end
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 24.000000000000000000
        end>
      TabOrder = 0
      object ScBxInitialScale: TScrollBox
        Left = 1
        Top = 49
        Width = 218
        Height = 380
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '\'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnMouseWheelDown = scrollBoxWheelDown
        OnMouseWheelUp = scrollBoxWheelUp
      end
      object ScBxMoisture: TScrollBox
        Left = 219
        Top = 49
        Width = 212
        Height = 380
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 14209987
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        OnMouseWheelDown = scrollBoxWheelDown
        OnMouseWheelUp = scrollBoxWheelUp
      end
      object ScBxFinalScale: TScrollBox
        Left = 431
        Top = 49
        Width = 214
        Height = 380
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 14149873
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        OnMouseWheelDown = scrollBoxWheelDown
        OnMouseWheelUp = scrollBoxWheelUp
      end
      object ScBxFinalized: TScrollBox
        Left = 645
        Top = 49
        Width = 216
        Height = 380
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 9690068
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 3
        OnMouseWheelDown = scrollBoxWheelDown
        OnMouseWheelUp = scrollBoxWheelUp
      end
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 218
        Height = 48
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Balan'#231'a 1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
      end
      object Panel3: TPanel
        Left = 219
        Top = 1
        Width = 212
        Height = 48
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Umidade'
        Color = 14209987
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
      end
      object Panel4: TPanel
        Left = 431
        Top = 1
        Width = 214
        Height = 48
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Balan'#231'a 2'
        Color = 14149873
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 6
      end
      object Panel5: TPanel
        Left = 645
        Top = 1
        Width = 216
        Height = 48
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Finalizados'
        Color = 9690068
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 7
      end
      object PnlTotalInitialScale: TPanel
        Left = 1
        Top = 429
        Width = 218
        Height = 24
        Align = alClient
        BevelOuter = bvNone
        Caption = '0'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 8
      end
      object PnlTotalMoisture: TPanel
        Left = 219
        Top = 429
        Width = 212
        Height = 24
        Align = alClient
        BevelOuter = bvNone
        Caption = '0'
        Color = 14209987
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 9
      end
      object PnlTotalFinalScale: TPanel
        Left = 431
        Top = 429
        Width = 214
        Height = 24
        Align = alClient
        BevelOuter = bvNone
        Caption = '0'
        Color = 14149873
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 10
      end
      object PnlTotalFinalized: TPanel
        Left = 645
        Top = 429
        Width = 216
        Height = 24
        Align = alClient
        BevelOuter = bvNone
        Caption = '1'
        Color = 9690068
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 11
      end
    end
    object Panel12: TPanel
      Left = 0
      Top = 454
      Width = 862
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object LblUserInfo: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 64
        Height = 16
        Align = alLeft
        Caption = 'LblUserInfo'
      end
      object LblFooterMsg: TLabel
        AlignWithMargins = True
        Left = 783
        Top = 3
        Width = 76
        Height = 16
        Align = alRight
        Caption = 'LblFooterMsg'
        Layout = tlCenter
        ExplicitLeft = 416
        ExplicitTop = 8
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Color = 2716773
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      862
      48)
    object Label2: TLabel
      AlignWithMargins = True
      Left = 53
      Top = 3
      Width = 339
      Height = 42
      Align = alLeft
      Caption = 'Sistema de Controle de Armazenagem de Gr'#227'os'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 19
    end
    object BtnFilterDone: TSpeedButton
      Left = 822
      Top = 8
      Width = 32
      Height = 34
      Anchors = [akTop, akRight, akBottom]
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000710000
        0087000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000073000000FF0000
        00B4000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000006A000000FF000000FF0000
        00B4000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000B8000000FF000000FF0000
        00B4000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000B8000000FF000000FF0000
        00B4000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000B8000000FF000000FF0000
        00B4000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000B8000000FF000000FF0000
        00B4000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000012000000DE000000FF000000FF0000
        00DB000000110000000000000000000000000000000000000000000000000000
        0000000000000000000000000012000000CE000000FF000000FF000000FF0000
        00FF000000CC0000001100000000000000000000000000000000000000000000
        00000000000000000012000000CE000000FF000000FF000000FF000000FF0000
        00FF000000FF000000CC00000011000000000000000000000000000000000000
        000000000012000000CE000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000CC000000110000000000000000000000000000
        0011000000CE000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000CC0000000F00000000000000000000
        0027000000B7000000B8000000B8000000B8000000B8000000B8000000B80000
        00B8000000B8000000B8000000B8000000B70000002400000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      OnClick = BtnFilterDoneClick
    end
    object Image1: TImage
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 40
      Height = 38
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000080
        000000800806000000C33E61CB0000000467414D410000B18F0BFC6105000013
        3149444154785EED9D097454D779C747A2B42727A735C186A6B66BD03212025C
        BBA4272727A735A6761D17DB6591D02E010E6EE2E434AED3C5B55DD39E2639A9
        B7A48090D8D182F6D182000B6DECAB0163BB8E4D59C42A16B108EDD26C5FBFFF
        9DF7E419E9499A4DA3F766DEE7F3F70C6FB9D2FDFEBF7BDF7DF72D321091AAD5
        D7DF6F28282937E4169618F28A4ABDD2CEFA3D13F61C3A66683A78145AC4CA65
        35371E38D20FE13B2B4F5A67C0B6D847A92C6F955F5C66D85C5064B8DFDE2EEA
        65B7DB87D4753CA4B8504DF20580ADDB8A0D953B6BD9FCE3307E26AB8E45109B
        4C7B0F1F17C27779B9B4CD4CEC837D518652D99E4A07C04B790B00B62F2CAB08
        6FDC7F98CD3F36974D6D910CB6B1E1D6DD7B0ED86B6A1B08C2772CC33A691BDE
        F6D853D81765F8D2FBC8D201F0523E00105EB9A3D6C02D7C161B7A5732D6C2C6
        52F5AE3A5B7E71B98D5BB71DC2772CC33AC73662DBBBD81765A02CA59FE18974
        00BC1400D8566A1A48A29B0AE3EDC37735ECFD7D6ED972B76F4157BFB3BEC9CE
        86521E5454EA107FC732AC930E070202ECCB65FC01CA4299837E864702C45BF8
        70A203E0A100405E518961737EA1612BB72037C5C7EE2243FDBE43CF4986A27B
        87B9F6D2CA1A987D9B4DFD37D6E392DEC032ACC336D816FB605F9481B24499CA
        3FCB2DE516161B36E416E8008CA03025F59BCD613BEA9AC2F8581D56B3DB6D4D
        C0278FF0B3D1925968D10280C2B2AA5B6CF6136CBA4B178D65BCEEA61300A217
        4019CE657AAFC6B0AA5D75611D9D5DA25E3A00AE9AA0B04CC862B51AF61DF918
        C7728FC5067E02135918DC61F04765D53BDE62B361FA44168EEDD0442CC33A6C
        236F2FEDFB8952D9DE88CB3274F7F48A7AD9EDC3D73990525C186085A33598CD
        96708BC532C96CB14C76564F6FEF644EDC646E899E6A0AEFD72A9988162D00A8
        6DDAF7244C67C3070676D2F7705E37C70900EC83EFAD286B50D91EAB89D5B0FF
        F0E4FB1D9D9350579B4DF400E183721170292E0CA0C2708C3F72E2F4D38D078E
        36702BE96403CC83C526782B18284BB4682EEF3B3BEBF7841796558AD33B08DF
        B18CD77DD7795B272995ED95F61E3ED689BAA2CEA83B723028270195E2425936
        BB2D8C15EE907D827F659BC8DD7BF8D153A7E7EEDE7BB08F93438DAE49F7B764
        537FC1461BB8354EAC6DDA3F01C2772CE375FF3568DB3113EA8CBA2307C88572
        8E7C123C83D843FBB0834EC58576B21B2C362BBAA731EFA2B845344849410B19
        92283F4A1EDCDD63FD254B4CF94AC6435886F902793BA532FC255157AE7BBD52
        4EFCAC117D1CB200C4F0A7D8E14CFB55C367F79A1FF95DDBA5C77F7274D59CBF
        DEFDCF735E6C7C7BCEFC86B77CD5779E6F7873CE82C677BE5F77F050FB9E8303
        236FA5648D85BA58BF66C1F4BF92BE6399D2B663213BEACC75EF400E900BE464
        508E7CD54CD6C32F34BE6D78B6EE5F0DCB0FBE2F7A03346E67BF5DFE61B5DBC4
        E7F59EBB86B74F6D9967ACC82C79B834F1DAA365C9F458590A3D569ECAC2A7EF
        7AB43C998CA64CAA3D7090F63A66E002A591400B1884A833EA8E1C20174A39F2
        5176D6D569A6B4D2A9C509F3E67EF473E1AD8D1C1ECB1AF8C2C708D1F25B7BDB
        7EEFA98F5EFFE5A4C20596B8AA9769268B3FED7155CBADFE546CD532EB13D5AF
        58C701000846E3388F0922F91A40207BA001009003E44229473E8A7D5B2EFC33
        562CB57C77C74FDF85B7F058F2FA6B00B0805B7FD895AE5B86A76A5FFFF0D1B2
        24FAB3EDAF506CE5320BCBC6C277BFCA58B9941EAF5A311E3D802A2403801C20
        174A39F2517616BC130D19BD027BFB9BCBEC31BC96211000F028544C4AA4EEFF
        D5E2A9C5F134BB7A8535C6518052C17E910E80040037346395728EFC28FB2CF6
        14DEC26367CF1D34903DACBEE5D484E88A8C93DC6DC8E42815E437853C00878E
        D347FB0FD0CCDC748A2A4EA319DC5D2BE5C98FB2C15B780CAFE139BCC7E99E20
        61E3D98FBE3FA968411FB77E6CECD7D68F2E6856F50F5D1457FD32FDF9F61F85
        3000C70400B37352296A6D02C56DCBA0D9DB57D0AC2ACECDD8C06087B7F0185E
        C373788FFF4DC43FF22F34BC3C85BB0836C7AAB0B3579A51B95CE84FF90C0265
        3F54BC7840938B17D1232549B48B9310AA3DC0AE7DFB69CA87CFD337DF9B477F
        F4DE33F460EEDFD1D4D22514614A138D4629A7BE08DEC207782D0130710080BC
        F3F53F8331BC915969674F05E3F93492224DE9F4F2E10F68F59795B4EECC8E01
        E59CA9A1755FEEA05D4DFB06DF921512429D7735EDA5B51F9B28EB24EB848972
        3EAFA2F7BF28A3979ADE118D063954CAADB782B7F098BD7E4D0980D7FC05806C
        3E4E412A2F1F221E70F08F500ED3F69DD4B0FF08ED397C5C3151C1A8BD5C57D4
        D954B34BCA826B74597AE9179F16D0B4F254BF8E0D0206401C0380D38EF79866
        040F38C862B712FF2C17F559CD545E554345A66AAA6DDA4F8DFB0FE3FA7B708B
        EB88BA1699AAC8545D43FD16B34B4EAC9C273967C9FB7E49D3CBFD7738081800
        B17C5A33A362199D6F6FE1D66F1FB1073879FA335AB7398FF28BCB685BA9890A
        CB2A825AA823EA8A3A9F3CFDA99405D790212869DE4BDFE631017A52C53C7BA8
        B107808D8F316552C4E6448A599F44ED7D5DA222A079B8E8EF3753C3DE03B439
        BF9036E416D0FA2DF9412DD41175459D5177A5E0D333F1D974FD139A5A9220CE
        0C14F3EDA1C61C8018D3528A5C9F40D3562D24E3DA2574BFAF535464240010DC
        49D085E64B74ECC4293A72FC44500B75445D51E7E14206A0F1FA290D01C08395
        E8FC148A58BD98A6672D2263B6FB00E8E11A9A05206A532245ACF10E003BC60A
        365B4808751D294212003DBE0EED02B0355907C00FA1DD31401E8F0174007C0E
        CD02602C48D301F043681780220980353A00BE84760128491F73005056B003A5
        590062CA32C7148060375E0E8D02B08C62CA3329323B9EA68D01007CF62C3E3B
        CC3DE2C212225871D02600908901580700167A0D80D2C5233921D7BA6FD3DF36
        BC496F9CDC48669B556C3BB86CEC8B755C2F55CA9D5C6817808AA514B57E094D
        5BED3D0072C05C84B3F92F36BE2D9E4FC025D25BBDF7C4726FCA567B68170056
        D4C6440980448F0090A7474FDD394BFB6E7E26BE9B6D16F179A5EB16BDD0F016
        1B9F2AEE307A66F7BF50A7A547AC934B967B8D7A4EDAEB1F67D3CAD3B9F4EF9F
        6C558DDE61A1E76AED6D13BFE748D3C1DA0580C701519B933C06404EC6CD9EBB
        F4173B5E15374034B49C12CBAE74B5D27CEEF623B8D5C3FCA76AFF917ED77649
        AC734E22D7437CFEEAF3420ACB7D961E2E4BE2E4C5AB46DF2E4DA03FDCF612FD
        5FFB55F17BCA3D9C5268168019D5CB297A6BB2E372708EFB00C8C938D7718DFE
        A43451DC4E36A7E6C7B4F55C1D2D6C5A296E8D8A3465E0C106FAEAFE15B1AD3C
        2894430660F597558447D9E6ECF8B178B8452D7AB2E6EF29A672295DE8B82E7E
        CFE003A04202202FC56300B01EFFF55AFBB9FBCE1106E25E3874F9481A5ABFB3
        F972829C4306E0D79F17D3C4BC1F885BD200935A84A7ADBE55B490CE06730F10
        CB00180B52BD1A04CADBE03EC1578FAE12097BA2FA1531E09B5BFB733A239B6F
        1B6A3E42DEBFA5FB0E1D6BFD8A4EDD3D27C6136AD289DB6704E4A385B601284A
        F7FA34503EA6E3AED8570EFF463C3F306FF73FF171F39A58AED4F28331B40B00
        66038BD37DBA1824778D8000A3E72FDA2E8A7FBB6B3E20C2B66A953B216FA741
        0096514C69264D5FBBD86B001083B71FE978198CA16D00CA7D0700817D706EEF
        CDBE5A0FED0220697A3603E0C15DC17AB886B601C0E9DBBA781D001F42F30044
        6C48F01A00ABD53AB286390D0CA6D0340098C089DCB4C42B00CC66335DB87485
        9A2F5F55D4795ED772E396B4F5F0813301B5CA9DD03E005B12C71500AD87E601
        88CA4B0E380072EBEAE9EDA53BF7DAE8DEFD76BAD7765F55BACBC2616CB4D03E
        0005A9E306C05D36FFCCB9663A7FF10A9D6BBEAC2A9DBD7051D471B4D03600B8
        20549446C6AC847101A08D5B3ECCBF74B5852E5EB9A62AA10EA10140493AF700
        E30380A307B828B63D77915B9E8A74B6F9520800C08780E8D20CC7E5E0DEC00F
        02514657770F75F7F4B2F0A91EE1F7C2C3A1A385E60130966550CCBA446AF302
        80F3DC52008192D08AAE5DBF296D1DBCA16900C40322E59914B321D963002C16
        0B5DBE769DAEB4DC5014D6DD6CBD236D3D7CC8A7DBF8509BDC096D03C0329A32
        29761300E810157117003D1CA17900701B57EC96146AEBD101F026B40F40158F
        0572537500BC8CE000202F4D07C0CB080E000A32BC0200E7F3C3097706E133D8
        232800882B62003C1C04E23410E7FB4AB36810D65DBFD92A6D3D7C0C06474D72
        278262101857B2745C2682822106006861008A19806A0D0230B36CD9B85C0EEE
        EBEBA3B6F60E6AEFE8549DEEF3EFE5DE4CA0E38A211E8F9B5A245EE1AF98674F
        15500066552CA7FBFDA3BF2AD6397C0140EE5E83E36AA004C0D59334A55078A2
        98674F155800F8B8351E0004C7D5400980CB27684AC1229AB55D6B005430004C
        ADDE03B8CAE31EE0D2C734257F210320FE8C8FCF0A6A00E4E8EBEF17C7DB8EAE
        2EEAE8549FDC1A03480FBAD6371FA7877217841600A35D0D1C0D80608801002E
        30005B430C001C2B71FC565233AFBB71EBB6B4F5F0E138E7963FD525774206A0
        EEFC317A68F34B34AB264400402825CD59A110CE003CB8910108951E400F4738
        033079FD0B3A00A1162E0064CFD70108B5701E047E2BEB79914BA53C7B2A1D00
        8D840B00AB7E103A00E02C00A37DDCFBA7A48BBCEEA6BB6701E2537D72275C00
        F8ED73A105807E57B02B00933EFC1B9AA5B53F1CE90B00305A69161072672610
        7F8B0F336E5DDDDDD4D9A53E793413280130B3420740C8A36B01E83114E6E3C7
        53672FB8F964900C403303F0010350CE79AD1A9A674F15120004C5D5406700DE
        7F9666962C15CF5B28E5DA13850400417135D00980071880B8A24C1D00C89D31
        406F6F1FDD6B6B1777DFE0CE2055897B274FAF063EF01E03B02D5DBC845329D7
        9E28240008867005E0199A919F163A00C068A5E3277481D7B90380980750A9DC
        89C100C4E6A68AC7EE9572ED89540F00025DE4680AF61802C096D4D01803E8E1
        88C16380984DC9E275FC4AB9F6443A001A091700F82C2066230360E25341855C
        7B221D008DC41000D627897730FB3A19A403A0911802C0BA44F14739831E00BC
        21E46ACB0DBA7AFDA6A2F096905BB7EF4A5B076F380380A960BC793DA634C3E7
        81A0EA01C069A07E35500180AC04F18738420200183D780248963B134166EE45
        F086B09EDE3EF1D650B5C99DB90025008C85693A006E5F0B387F519483DE444D
        3AE7EE7B020703B03681A2F37D9F0B08090082EE6AA00C406E8A0E80DB3D4090
        DD0F0000A2B6243100CAF976572101008EFFB7EFDC136FE6C65BC3D526B7DE16
        3E04802514B529510760240082299400885C9F101A0060B0040894E4380D1C1D
        00F4066A953BE10AC0B30E00721800855C7B22D503800461326838E114CF9D2E
        54EBA1084076BCCFD703540F801E8E180240F6128A581BEFF374B00E80466238
        008C25BE4D07EB0068241401C85A4CC622DF6603750034128A00AC5944C66DA9
        3EDD1BA803A091500460F522C774B00E40F0C7703D40342E08E900047F0C0120
        2B8122D725502CE75529DFEE2AE000B4EB007815CE00883B823624514CA9EF4F
        07050E00E94DA1ADBD6D8E19301D008F022F8BC6ABF1775C3CE2784F201E0FF7
        711A180A1800332A975384299D765E3D262AC43F4340E03C253AAE52F37FFCFB
        59EC8E1E60E5E95C7AB43C85E2B4F67E8038EEAAA697A7D1F30D6FD2EDBEFBA2
        327A7816876F7D215A3E0EA768504A79F654010300C22F0D089EAB7F832A2F1D
        A4ABDDAD74ABFB9E435D6E48DED6533997D179F76B75489FCEE5F7B4512BC487
        2AB5E87C470BADFD6A3B3DB9FD471465CAF09BF950400180D0134498D284700C
        8BDA9C44D3572F14B35AEE6A3AC4A740A38ACF93A1882C56F662316A8E5CBF84
        223726F2CF656D4DA6E83CD6B654717F9DB1389D8CA51914E387072EFC2923B7
        F8C7CA5329BA22D3AFE6430107000204A2220C006E6DC69CB6C328C9E4354E06
        4B260E98C9EBC4366B59D9F11491E3381D8ADCB044981A0D53F3531CA616A551
        4C091B8ABF5A8A3F5CC9C6A2FB14BF070650387F863092C6BF650DFA7DD5A081
        9C29ACF345E302808BB86230298A5B65249B1AC93044E6C45314B7542C430F21
        4CCD4B2123FE043DB7D4986236142DB59CCDC4F371C2407734E867EB52010010
        CCE14FD14A612ABA60E796CAEBC5A3D02E2D16722A4397571A1180DCB375AF3D
        54B468EC0190A5E22E38582500608FE1F55000CEEC7EEDC1C245343B5000E80A
        B8E02D3C86D74300D8F2D9CE7F78306F01CDDEBE42072048056FE1317BFD3327
        002C8E1EE0D39D199373E6D3EC9A1536A59D75695FF0161EC36B070016014038
        FE917DB2E2F16FBCFB74D7ECB2E5761E7CD9950AD0A561552DB7C35B780CAF25
        00C20D36BBCD60277BF8C91B670CC6EC250D984489294EB73946E04E05E0144C
        977634603C8BBDE4D36F1BBC85C7F01A9EC37B0348E02FA217F8E9EE0FBEF7CD
        77E759627392EC51B9C95671172A0AE102706AA64B3B120D98BD8387D1ECA531
        27D1066FE1B1B3E702003BCB6CB384755BFA0C29552B5F7DE0FD6728363B11B3
        7696A88D89F6A82DC98E091A5D9A113C8377C2C3AC78FAE3DFCE27F6F627DDE6
        5EE1353C1F00C001811D9F136C76BB21BDFA3F53BEF1DF732F474A53B5B81F4D
        9706B56691986D7D64D54B97BFB7F58719F0161E4B5E0B0D7C81A40DC2FAAC66
        43E1FFD645CC5E9FBA72DA9A852722B3E2BBC47CBC2EED286B7117EB0403F01F
        0FFFCF8B114F17BC2ABCB591CDC97332FC3F093E8E4C7F58FFC4000000004945
        4E44AE426082}
      Proportional = True
      Stretch = True
    end
    object BtnNew: TButton
      Left = 709
      Top = 8
      Width = 107
      Height = 34
      Anchors = [akTop, akRight]
      Caption = 'Novo Contrato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnNewClick
    end
  end
  object MmMain: TMainMenu
    Left = 600
    Top = 8
    object Sistema1: TMenuItem
      Caption = 'Sistema'
      object NovoContrato1: TMenuItem
        Caption = 'Novo Contrato'
        OnClick = NovoContrato1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
    object Registros1: TMenuItem
      Caption = 'Registros'
      object RegistrodeProdutor1: TMenuItem
        Caption = 'Produtores'
        OnClick = RegistrodeProdutor1Click
      end
      object RegistrodeGros1: TMenuItem
        Caption = ' Gr'#227'os'
        OnClick = RegistrodeGros1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Contratos1: TMenuItem
        Caption = 'Contratos'
        OnClick = Contratos1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ArmazmSilo1: TMenuItem
        Caption = 'Armaz'#233'ns/Silos'
        OnClick = ArmazmSilo1Click
      end
      object Usurio1: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = Usurio1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Manual1: TMenuItem
        Caption = 'Manual'
        OnClick = Manual1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Sobre1: TMenuItem
        Caption = 'Sobre'
        OnClick = Sobre1Click
      end
    end
  end
  object PpMnFilter: TPopupMenu
    Left = 544
    Top = 8
    object btnFilterToday: TMenuItem
      AutoCheck = True
      Caption = 'De Hoje'
      Checked = True
      RadioItem = True
    end
    object btnFilterWeek: TMenuItem
      AutoCheck = True
      Caption = 'Da Semana'
      RadioItem = True
    end
    object btnFilterMonth: TMenuItem
      AutoCheck = True
      Caption = 'Do M'#234's'
      RadioItem = True
    end
    object btnFilterAll: TMenuItem
      AutoCheck = True
      Caption = 'Todos'
      RadioItem = True
    end
  end
  object TimerCheckValidation: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerCheckValidationTimer
    Left = 448
    Top = 16
  end
end
