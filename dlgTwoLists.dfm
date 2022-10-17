object TwoLists: TTwoLists
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TwoLists'
  ClientHeight = 587
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 21
  object lboxL: TListBox
    Left = 32
    Top = 56
    Width = 241
    Height = 433
    Style = lbVirtualOwnerDraw
    DragMode = dmAutomatic
    MultiSelect = True
    TabOrder = 0
    OnData = lboxLData
    OnDataFind = lboxLDataFind
    OnDataObject = lboxLDataObject
    OnDragDrop = lboxLDragDrop
    OnDragOver = lboxLDragOver
    OnDrawItem = lboxLDrawItem
  end
  object lboxR: TListBox
    Left = 464
    Top = 56
    Width = 241
    Height = 433
    DragMode = dmAutomatic
    ItemHeight = 21
    MultiSelect = True
    TabOrder = 1
    OnDragDrop = lboxRDragDrop
    OnDragOver = lboxRDragOver
  end
  object Button1: TButton
    Left = 320
    Top = 56
    Width = 99
    Height = 30
    Caption = '>'
    TabOrder = 2
  end
  object Button2: TButton
    Left = 320
    Top = 106
    Width = 99
    Height = 30
    Caption = '>>'
    TabOrder = 3
  end
  object Button3: TButton
    Left = 320
    Top = 156
    Width = 99
    Height = 30
    Caption = '<'
    TabOrder = 4
  end
  object Button4: TButton
    Left = 320
    Top = 206
    Width = 99
    Height = 30
    Caption = '<<'
    TabOrder = 5
  end
  object Button5: TButton
    Left = 320
    Top = 254
    Width = 99
    Height = 30
    Caption = '^'
    TabOrder = 6
  end
  object Button6: TButton
    Left = 320
    Top = 302
    Width = 99
    Height = 30
    Caption = '6'
    TabOrder = 7
  end
  object Button7: TButton
    Left = 336
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 198
    Top = 528
    Width = 75
    Height = 25
    Caption = 'refresh'
    TabOrder = 9
    OnClick = Button8Click
  end
  object qryMemberList: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = SCM.scmConnection
    SQL.Strings = (
      'Use SwimClubMeet;'
      ''
      'SELECT '
      #9#9' [MemberID]'
      #9#9',[MembershipNum]'
      
        #9#9',Substring( Concat(FirstName, '#39' '#39', Upper(LastName)), 0, 50) AS' +
        ' FName'
      'FROM [SwimClubMeet].[dbo].[Member]'
      'WHERE IsArchived <> 1'
      '      AND IsActive = 1'
      '      AND Member.IsSwimmer = 1'
      '      AND MembershipNum IS NOT NULL; ')
    Left = 352
    Top = 376
  end
end
