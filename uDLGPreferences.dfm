object DLGPreferences: TDLGPreferences
  Left = 0
  Top = 0
  Caption = 'Life - Preferences'
  ClientHeight = 463
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    460
    463)
  PixelsPerInch = 96
  TextHeight = 13
  object pages: TsPageControl
    AlignWithMargins = True
    Left = 159
    Top = 3
    Width = 298
    Height = 457
    ActivePage = TSVideo
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    ExplicitHeight = 341
    object TSVideo: TsTabSheet
      Caption = 'Video Recording'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitHeight = 331
      object sGroupBox2: TsGroupBox
        Left = 0
        Top = 0
        Width = 290
        Height = 447
        Align = alClient
        Caption = 'Video Recording Settings'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        ExplicitHeight = 331
        DesignSize = (
          290
          447)
        object sLabel1: TsLabel
          Left = 8
          Top = 80
          Width = 278
          Height = 52
          Caption = 
            'Every n-th state in the sequence of state is recorded as a new f' +
            'rame, where n is the frameskip'#13#10'Then the avi file is formed so t' +
            'hat it will be played at the FPS framerate'
          ParentFont = False
          WordWrap = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8542779
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel2: TsLabel
          Left = 91
          Top = 167
          Width = 194
          Height = 17
          Caption = 'If empty, asks for a filename every time'
          ParentFont = False
          WordWrap = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8542779
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object RBCaptureScreen: TsRadioButton
          Left = 11
          Top = 264
          Width = 119
          Height = 19
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Record from screen'
          TabOrder = 0
          OnClick = RBCaptureFullStateClick
          SkinData.SkinSection = 'RADIOBUTTON'
        end
        object RBCaptureFullState: TsRadioButton
          Left = 149
          Top = 264
          Width = 104
          Height = 19
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Record full state'
          TabOrder = 1
          OnClick = RBCaptureFullStateClick
          SkinData.SkinSection = 'RADIOBUTTON'
          ExplicitTop = 148
        end
        object GBRecordFromScreen: TsGroupBox
          Left = 11
          Top = 282
          Width = 134
          Height = 125
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 2
          SkinData.SkinSection = 'WEBBUTTON'
        end
        object GBRecordFullState: TsGroupBox
          Left = 149
          Top = 282
          Width = 134
          Height = 125
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 3
          SkinData.SkinSection = 'WEBBUTTON'
          ExplicitTop = 166
          object EDDeadCellColor: TsColorSelect
            Left = 3
            Top = 100
            Width = 128
            Height = 22
            Caption = 'Min value cell color'
            Layout = blGlyphRight
            Margin = 0
            Spacing = 9
            SkinData.SkinSection = 'SPEEDBUTTON'
            TextAlignment = taRightJustify
            OnChange = CBFullStateRendererChange
            ColorValue = clBlack
          end
          object EDAliveCellColor: TsColorSelect
            Left = 3
            Top = 73
            Width = 128
            Height = 22
            Caption = 'Max value cell color'
            Layout = blGlyphRight
            Margin = 0
            Spacing = 5
            SkinData.SkinSection = 'SPEEDBUTTON'
            TextAlignment = taRightJustify
            OnChange = CBFullStateRendererChange
            ColorValue = clBlack
          end
          object CBFullStateRenderer: TsComboBox
            Left = 3
            Top = 19
            Width = 128
            Height = 21
            Alignment = taLeftJustify
            BoundLabel.Active = True
            BoundLabel.Caption = 'Renderer'
            BoundLabel.Indent = 0
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = 8542779
            BoundLabel.Font.Height = -11
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
            BoundLabel.Layout = sclTopLeft
            BoundLabel.MaxWidth = 0
            BoundLabel.UseSkinColor = True
            SkinData.SkinSection = 'COMBOBOX'
            Style = csDropDownList
            Color = 16511722
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 13
            ItemIndex = 1
            ParentFont = False
            TabOrder = 0
            Text = 'Software Renderer'
            OnChange = CBFullStateRendererChange
            Items.Strings = (
              'OpenGL Mem. Buffer'
              'Software Renderer')
          end
          object sSpinEdit3: TsSpinEdit
            Left = 70
            Top = 46
            Width = 62
            Height = 21
            Color = 16511722
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '4'
            OnChange = CBFullStateRendererChange
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Active = True
            BoundLabel.Caption = 'Cell size (px)'
            BoundLabel.Indent = 0
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = 8542779
            BoundLabel.Font.Height = -11
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
            BoundLabel.Layout = sclLeft
            BoundLabel.MaxWidth = 0
            BoundLabel.UseSkinColor = True
            MaxValue = 0
            MinValue = 0
            Value = 4
          end
        end
        object EDFPS: TsSpinEdit
          Left = 216
          Top = 24
          Width = 65
          Height = 21
          Color = 16511722
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = '0'
          OnChange = CBFullStateRendererChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'FPS (frames per second)'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = 8542779
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          MaxValue = 0
          MinValue = 0
          Value = 0
        end
        object EDFrameSkip: TsSpinEdit
          Left = 216
          Top = 51
          Width = 65
          Height = 21
          Color = 16511722
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          Text = '0'
          OnChange = CBFullStateRendererChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Frameskip (record every n-th frame)'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = 8542779
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          MaxValue = 0
          MinValue = 0
          Value = 0
        end
        object EDFileName: TsFilenameEdit
          Left = 160
          Top = 142
          Width = 121
          Height = 21
          AutoSize = False
          MaxLength = 255
          TabOrder = 6
          BoundLabel.Active = True
          BoundLabel.Caption = 'AVI File Name'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = 8542779
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Grayed = False
        end
        object CBCompressor: TsComboBox
          Left = 160
          Top = 190
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Video Compressor'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = 8542779
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'COMBOBOX'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = -1
          TabOrder = 7
          OnChange = CBCompressorChange
          Items.Strings = (
            'MS Video 1'
            'DivX'
            '<Ask every time>'
            '<Specify FourCC...>')
        end
        object EDFourCC: TsMaskEdit
          Left = 160
          Top = 217
          Width = 114
          Height = 21
          EditMask = '!aaaa;1;_'
          MaxLength = 4
          TabOrder = 8
          Text = '    '
          BoundLabel.Active = True
          BoundLabel.Caption = 'FourCC'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = 8542779
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object sTabSheet1: TsTabSheet
      Caption = 'Appearance'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitHeight = 331
      DesignSize = (
        290
        447)
      object sBitBtn1: TsBitBtn
        Left = 8
        Top = 12
        Width = 277
        Height = 387
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'A really big '#13#10'button that '#13#10'does '#13#10'NOTHING '#13#10'yet :)))'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON_HUGE'
        ExplicitHeight = 271
      end
    end
  end
  object sGroupBox1: TsGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 150
    Height = 457
    Align = alLeft
    Caption = 'Preferences'
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    ExplicitHeight = 341
    object categoriesTreeView: TsTreeView
      AlignWithMargins = True
      Left = 5
      Top = 16
      Width = 140
      Height = 436
      Margins.Top = 1
      Align = alClient
      Color = 16511722
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Indent = 19
      ParentFont = False
      TabOrder = 0
      OnClick = categoriesTreeViewClick
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      ExplicitHeight = 320
    end
  end
  object BTNApply: TsButton
    Left = 215
    Top = 427
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Apply'
    Enabled = False
    TabOrder = 2
    OnClick = BTNApplyClick
    SkinData.SkinSection = 'BUTTON'
    ExplicitTop = 311
  end
  object sButton2: TsButton
    Left = 294
    Top = 427
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = BTNApplyClick
    SkinData.SkinSection = 'BUTTON'
    ExplicitTop = 311
  end
  object sButton1: TsButton
    Left = 374
    Top = 427
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    SkinData.SkinSection = 'BUTTON'
    ExplicitTop = 311
  end
  object sSkinProvider1: TsSkinProvider
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 152
    Top = 8
  end
end
