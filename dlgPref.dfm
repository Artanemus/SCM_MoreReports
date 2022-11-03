object Pref: TPref
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'SCM_MoreReports Preferences'
  ClientHeight = 548
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 667
    Height = 57
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 490
    Width = 667
    Height = 58
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
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
    Width = 667
    Height = 433
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 2
    ExplicitTop = 41
    ExplicitHeight = 449
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
      object edtCustRptMemShip: TEdit
        Left = 3
        Top = 38
        Width = 653
        Height = 29
        TabOrder = 0
      end
      object btnBrowseCustRptMemShip: TButton
        Left = 581
        Top = 3
        Width = 75
        Height = 29
        Caption = 'Browse'
        TabOrder = 1
        OnClick = btnBrowseCustRptMemShipClick
      end
      object sedtMaxAllowToPick: TSpinEdit
        Left = 175
        Top = 80
        Width = 50
        Height = 31
        MaxValue = 99
        MinValue = 0
        TabOrder = 2
        Value = 20
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
      object edtCustRptCertifGOLD: TEdit
        Left = 3
        Top = 38
        Width = 653
        Height = 29
        TabOrder = 0
      end
      object btnBrowseCertifGOLD: TButton
        Left = 581
        Top = 3
        Width = 75
        Height = 29
        Caption = 'Browse'
        TabOrder = 1
        OnClick = btnBrowseCertifGOLDClick
      end
      object edtCustRptCertifSILVER: TEdit
        Left = 3
        Top = 108
        Width = 653
        Height = 29
        TabOrder = 2
      end
      object edtCustRptCertifBRONZE: TEdit
        Left = 3
        Top = 178
        Width = 653
        Height = 29
        TabOrder = 3
      end
      object btnBrowseCertifSILVER: TButton
        Left = 581
        Top = 73
        Width = 75
        Height = 29
        Caption = 'Browse'
        TabOrder = 4
        OnClick = btnBrowseCertifGOLDClick
      end
      object btnBrowseCertifBRONZE: TButton
        Left = 581
        Top = 143
        Width = 75
        Height = 29
        Caption = 'Browse'
        TabOrder = 5
        OnClick = btnBrowseCertifGOLDClick
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
    Top = 360
  end
end
