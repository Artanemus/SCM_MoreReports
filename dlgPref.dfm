object Pref: TPref
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'SCM_MoreReports Preferences'
  ClientHeight = 547
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 57
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 667
  end
  object Panel2: TPanel
    Left = 0
    Top = 489
    Width = 663
    Height = 58
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 490
    ExplicitWidth = 667
    object btnClose: TButton
      Left = 296
      Top = 12
      Width = 75
      Height = 29
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 57
    Width = 663
    Height = 432
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 667
    ExplicitHeight = 433
    object TabSheet1: TTabSheet
      Caption = 'Membership'
      object Label2: TLabel
        Left = 3
        Top = 11
        Width = 196
        Height = 21
        Caption = 'Custom membership report.'
      end
      object Label3: TLabel
        Left = 3
        Top = 83
        Width = 166
        Height = 21
        Alignment = taRightJustify
        Caption = 'Max member pick limit :'
      end
      object edtMembership: TEdit
        Left = 3
        Top = 38
        Width = 590
        Height = 29
        TabOrder = 0
      end
      object sedtMaxAllowToPick: TSpinEdit
        Left = 175
        Top = 80
        Width = 50
        Height = 31
        MaxValue = 99
        MinValue = 0
        TabOrder = 1
        Value = 20
      end
      object btnMembership: TButton
        Left = 599
        Top = 31
        Width = 43
        Height = 43
        ImageIndex = 0
        ImageName = 'outline_folder_black_48dp'
        Images = VirtualImageList1
        TabOrder = 2
        Visible = False
        OnClick = btnMemshipClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Podium Certificates'
      ImageIndex = 1
      object Label1: TLabel
        Left = 3
        Top = 11
        Width = 150
        Height = 21
        Caption = 'Custom GOLD report.'
      end
      object Label4: TLabel
        Left = 8
        Top = 81
        Width = 156
        Height = 21
        Caption = 'Custom SILVER report.'
      end
      object Label5: TLabel
        Left = 8
        Top = 151
        Width = 168
        Height = 21
        Caption = 'Custom BRONZE report.'
      end
      object edtGold: TEdit
        Left = 3
        Top = 38
        Width = 591
        Height = 29
        TabOrder = 0
      end
      object btnGold: TButton
        Tag = 1
        Left = 600
        Top = 31
        Width = 43
        Height = 43
        ImageIndex = 0
        ImageName = 'outline_folder_black_48dp'
        Images = VirtualImageList1
        TabOrder = 1
        Visible = False
        OnClick = btnPodiumCertifClick
      end
      object edtSilver: TEdit
        Left = 3
        Top = 108
        Width = 591
        Height = 29
        TabOrder = 2
      end
      object edtBronze: TEdit
        Left = 3
        Top = 178
        Width = 591
        Height = 29
        TabOrder = 3
      end
      object btnSilver: TButton
        Tag = 2
        Left = 600
        Top = 101
        Width = 43
        Height = 43
        ImageIndex = 0
        ImageName = 'outline_folder_black_48dp'
        Images = VirtualImageList1
        TabOrder = 4
        OnClick = btnPodiumCertifClick
      end
      object btnBronze: TButton
        Tag = 3
        Left = 600
        Top = 171
        Width = 43
        Height = 43
        ImageIndex = 0
        ImageName = 'outline_folder_black_48dp'
        Images = VirtualImageList1
        TabOrder = 5
        OnClick = btnPodiumCertifClick
      end
    end
  end
  object FileOpenDialog: TFileOpenDialog
    DefaultExtension = 'fr3'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'FastReport (*.fr3).'
        FileMask = '*.fr3'
      end
      item
        DisplayName = 'All files'
        FileMask = '*.*'
      end>
    OkButtonLabel = 'Load Report'
    Options = [fdoFileMustExist]
    Title = 'Open a FastReport'
    Left = 544
    Top = 344
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'outline_folder_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001344944415478DAEDDA3D4EC3401086E1AF883B8E41832F4945831423
              E730295C53512777486D89BFC4B0A910522858C73BDE59F97DF702F3486B4B96
              47222222222222BAEC4E6BEDD52B8C3CF71E865FE949A7D1A3BB21ACB4BD7A78
              1784C789E36726DCEA98009091F09064FC8C849764804C8443424016C2EBC508
              B1DDE83929FDE7F4DAAB516D0FB02304050DDAA8B206D81282BA38C2148035A1
              8D19E16D12C0FA22D5F6005B423307C092B09B0760F952FDB7F724807485B1F3
              0000B074C007000000CA067C0200B070C01100000065034E000000281B300000
              B070C017000000CA067C030000A06C40009019D01B2E6BCCF2A37BE71A10B16A
              D0B806442C7BD47FBE08FC9C216EF5AC750B68E39EFB4A9DCBF1BBD8AD39A9D2
              C6D9451AB1F4F7FB2C3457ADDF675FBB2422222222A2A57406BFD299AF8DB491
              950000000049454E44AE426082}
          end>
      end>
    Left = 544
    Top = 408
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'outline_folder_black_48dp'
        Name = 'outline_folder_black_48dp'
      end>
    ImageCollection = ImageCollection1
    Width = 40
    Height = 40
    Left = 544
    Top = 280
  end
end
