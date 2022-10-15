object Membership: TMembership
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Membership Cards'
  ClientHeight = 475
  ClientWidth = 478
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 21
  object Panel2: TPanel
    Left = 0
    Top = 421
    Width = 478
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOk: TButton
      Left = 202
      Top = 11
      Width = 75
      Height = 32
      Caption = 'Ok'
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 478
    Height = 328
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label8: TLabel
      Left = 68
      Top = 79
      Width = 79
      Height = 21
      Alignment = taRightJustify
      Caption = 'Date from...'
    end
    object Label9: TLabel
      Left = 68
      Top = 142
      Width = 59
      Height = 21
      Alignment = taRightJustify
      Caption = 'Date to...'
    end
    object imgDateFrom: TVirtualImage
      Left = 218
      Top = 104
      Width = 32
      Height = 32
      ImageCollection = ImageCollection1
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = 0
      ImageName = 'outline_date_range_black_48dp'
    end
    object imgDateTo: TVirtualImage
      Left = 218
      Top = 167
      Width = 32
      Height = 32
      ImageCollection = ImageCollection1
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = 0
      ImageName = 'outline_date_range_black_48dp'
    end
    object GroupBox: TGroupBox
      Left = 16
      Top = 16
      Width = 417
      Height = 297
      Caption = 'Select the members for the report ...'
      TabOrder = 5
      OnClick = RadioBtnGenericClick
      object RadioButton1: TRadioButton
        Tag = 1
        Left = 39
        Top = 37
        Width = 337
        Height = 24
        Caption = 'New members created within a date range ...'
        TabOrder = 0
        OnClick = RadioBtnGenericClick
      end
      object RadioButton2: TRadioButton
        Tag = 2
        Left = 39
        Top = 224
        Width = 282
        Height = 17
        Caption = 'Let me pick members from a list ...'
        TabOrder = 1
        OnClick = RadioBtnGenericClick
      end
      object RadioButton3: TRadioButton
        Tag = 3
        Left = 39
        Top = 263
        Width = 176
        Height = 17
        Caption = 'All active swimmers ...'
        TabOrder = 2
      end
    end
    object calDateFrom: TCalendarPicker
      Left = 68
      Top = 104
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TextHint = 'select a date'
    end
    object calDateTo: TCalendarPicker
      Left = 68
      Top = 167
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'select a date'
    end
    object btnToday: TButton
      Left = 301
      Top = 94
      Width = 115
      Height = 29
      Caption = 'Today'
      ImageIndex = 0
      ImageName = 'ic_action_keyboard_arrow_left'
      Images = VirtualImageList1
      TabOrder = 2
    end
    object btnThisWeek: TButton
      Left = 301
      Top = 129
      Width = 115
      Height = 29
      Caption = 'This Week'
      ImageIndex = 0
      ImageName = 'ic_action_keyboard_arrow_left'
      Images = VirtualImageList1
      TabOrder = 3
    end
    object btnThisSeason: TButton
      Left = 301
      Top = 164
      Width = 115
      Height = 29
      Caption = 'This Season'
      ImageIndex = 0
      ImageName = 'ic_action_keyboard_arrow_left'
      Images = VirtualImageList1
      TabOrder = 4
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 478
    Height = 93
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object chkboxGenerateNum: TCheckBox
      Left = 16
      Top = 25
      Width = 369
      Height = 17
      Caption = 'Generate a membership number if none available.'
      TabOrder = 0
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'outline_date_range_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001184944415478DAEDDB3B0EC2400C45D157003BA1817DD20122623320
              B1025AD8037510FFC0502121285032F9D8E13E9791323EC5C8CD5822841042F2
              247C94B5FF0100000000807233D4545BEDBF0EAABA526D35D120AEF98E1265B5
              B7FE5E9912758BB7BF68B4F9572D8B12C626DA0F0A9A1569BFAFAB194056E42E
              8CCCB41F1434C90F589B026CF20376A600697EC0A1EE0959F680030020F2FC23
              0000004CD5FF014E000000F00D38B70DE06E90010050312034FCFD672E000000
              F00DB802300E303FC80000883CFF06000000DF800C000000001A05DC010000E0
              1BF0000000806F40000020EEFCD4FBC3D78DF7A7C753EF8FBF870DEF6E443FBF
              97E6BE1720A49E56BE5750A49EE69E97805E77C1F11A16218490B6E709CDA0BC
              2B579CFE700000000049454E44AE426082}
          end>
      end
      item
        Name = 'ic_action_keyboard_arrow_left'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              38000001F949444154785EEDDCD149C4501085E1D90E6CC80E2CD122044B10AC
              C33A7C9208011191BD24E1CC39F3FBBC7B07FE2FC33EC4E456FC490BDCA4D319
              5E00882F0200001017108F6703001017108F6703001017108F6703001017108F
              6703001017108F6703001017108F6703001017108F6703001017108F67030010
              17108F6703001017108F670300B8B4C063553D54D5EBA5530E1C9EBC015BFCA7
              AAEF7FBD79EB8A900AF033FE7E7DB6444804F82B7E5B843480FFE2B7444802B8
              27FE8EF05255EF077E3B4FFB6A0AC04AFC8FAA7AAEAACFD32A1E382801C036FE
              E6E60E601DDF1DC03EBE3340447C578098F88E0051F1DD00E2E23B0144C67701
              888DEF00101DBF3B407CFCCE0023E277051813BF23C0A8F8DD00C6C5EF043032
              7E1780B1F101387027EBACAF76B92133760BBA006C17D448844E002311BA018C
              43E808300AA12BC01884CE002310BA03C42338004423B800C42238014422B801
              C42138024421B802C42038034420B803D82324005823A400AC22F090DE59B7F4
              7E9D73CF4D9D560F6C276DC06EC183DA175DDD2BC7F2AA82955A177D9697755C
              1476E5585E57B3526BE267137F84AD1C011073010080B880783C1B0080B88078
              3C1B0080B880783C1B0080B880783C1B0080B880783C1B0080B880783C1B0080
              B880783C1B0080B880783C1B0080B880783C1B0080B880783C1B2006F8023623
              826114C621D10000000049454E44AE426082}
          end>
      end>
    Left = 416
    Top = 352
  end
  object VirtualImageList1: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'ic_action_keyboard_arrow_left'
        Disabled = False
        Name = 'ic_action_keyboard_arrow_left'
      end>
    ImageCollection = ImageCollection1
    Left = 408
    Top = 400
  end
end
