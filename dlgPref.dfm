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
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 667
    Height = 41
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 657
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
    ExplicitTop = 492
    object Button3: TButton
      Left = 296
      Top = 12
      Width = 75
      Height = 29
      Caption = 'Close'
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 667
    Height = 449
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 657
    ExplicitHeight = 456
    object TabSheet1: TTabSheet
      Caption = 'Custom Reports'
      object Label2: TLabel
        Left = 16
        Top = 13
        Width = 230
        Height = 21
        Caption = 'Custom membership card report.'
      end
      object Label1: TLabel
        Left = 16
        Top = 93
        Width = 233
        Height = 21
        Caption = 'Custom podium certificate report.'
      end
      object Edit1: TEdit
        Left = 16
        Top = 40
        Width = 513
        Height = 29
        TabOrder = 0
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 16
        Top = 120
        Width = 513
        Height = 29
        TabOrder = 1
        Text = 'Edit1'
      end
      object Button1: TButton
        Left = 544
        Top = 40
        Width = 75
        Height = 29
        Caption = 'Browse'
        TabOrder = 2
      end
      object Button2: TButton
        Left = 544
        Top = 120
        Width = 75
        Height = 29
        Caption = 'Browse'
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Options'
      ImageIndex = 1
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    DefaultExtension = 'frx'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'FastReport (*.frx).'
        FileMask = '*.frx'
      end
      item
        DisplayName = 'All files'
        FileMask = '*.*'
      end>
    OkButtonLabel = 'Load Report'
    Options = [fdoFileMustExist]
    Title = 'Open a FastReport'
    Left = 504
    Top = 280
  end
end
