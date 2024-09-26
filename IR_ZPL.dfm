object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Easy ZPL'
  ClientHeight = 602
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = UcitajZPL
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 775
    Height = 602
    Align = alClient
    TabOrder = 0
    object LeftPanel: TPanel
      AlignWithMargins = True
      Left = 383
      Top = 61
      Width = 388
      Height = 496
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 537
      object ZPLCode: TMemo
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 386
        Height = 494
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Lines.Strings = (
          '^XA'
          ''
          '^XZ')
        PopupMenu = PopupMenu2
        TabOrder = 0
        ExplicitHeight = 535
      end
    end
    object RightPanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 61
      Width = 373
      Height = 496
      Align = alLeft
      TabOrder = 1
      ExplicitHeight = 537
      object LabeledEdit1: TLabeledEdit
        Left = 128
        Top = 32
        Width = 185
        Height = 26
        EditLabel.Width = 67
        EditLabel.Height = 26
        EditLabel.Caption = 'Company'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -16
        EditLabel.Font.Name = 'Doppio One'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Doppio One'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 15
        ParentFont = False
        TabOrder = 0
        Text = ''
        OnExit = firma_onExit
      end
      object LabeledEdit2: TLabeledEdit
        Left = 128
        Top = 80
        Width = 185
        Height = 26
        EditLabel.Width = 60
        EditLabel.Height = 26
        EditLabel.Caption = 'Barcode'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -16
        EditLabel.Font.Name = 'Doppio One'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Doppio One'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 15
        ParentFont = False
        TabOrder = 1
        Text = ''
        OnExit = barcode_onExit
      end
      object LabeledEdit3: TLabeledEdit
        Left = 128
        Top = 120
        Width = 185
        Height = 26
        EditLabel.Width = 53
        EditLabel.Height = 26
        EditLabel.Caption = 'Country'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -16
        EditLabel.Font.Name = 'Doppio One'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Doppio One'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 15
        ParentFont = False
        TabOrder = 2
        Text = ''
        OnExit = drzava_onExit
      end
      object posalji: TButton
        Left = 40
        Top = 176
        Width = 75
        Height = 25
        Caption = 'FTP SEND'
        TabOrder = 3
        OnClick = posaljiClick
      end
      object SaveButton: TButton
        Left = 144
        Top = 176
        Width = 75
        Height = 25
        Caption = 'SAVE'
        TabOrder = 4
        OnClick = SaveButtonClick
      end
      object dajTemplate: TButton
        Left = 251
        Top = 176
        Width = 75
        Height = 25
        Caption = 'TEMPLATE'
        TabOrder = 5
        OnClick = UcitajZPL
      end
    end
    object TopPanel: TPanel
      Left = 1
      Top = 1
      Width = 773
      Height = 57
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        773
        57)
      object Label1: TLabel
        Left = 433
        Top = 15
        Width = 307
        Height = 24
        Cursor = crHandPoint
        Caption = 'http://labelary.com/viewer.html'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -21
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        OnClick = Label1Click
        OnMouseEnter = Label1MouseEnter
        OnMouseLeave = Label1MouseLeave
      end
      object Label2: TLabel
        Left = 43
        Top = 19
        Width = 376
        Height = 18
        Anchors = [akTop, akRight]
        Caption = 'For the view of the label, Copy ZPL code then paste to:'
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 560
      Width = 773
      Height = 41
      Align = alBottom
      Alignment = taRightJustify
      Caption = 'Thank you Labelary.com   '
      TabOrder = 3
      ExplicitLeft = 296
      ExplicitTop = 280
      ExplicitWidth = 185
    end
  end
  object FTP: TIdFTP
    OnDisconnected = FTPDisconnected
    ConnectTimeout = 0
    Password = '1234'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    ClientInfo.ClientName = 'IR_ZPL_upload'
    ClientInfo.ClientVersion = 'v0.1'
    Left = 332
    Top = 77
  end
  object PopupMenu1: TPopupMenu
    Left = 548
    Top = 109
    object CopytoClipboard1: TMenuItem
      Caption = 'Copy to Clipboard'
      OnClick = CopytoClipboard1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 420
    Top = 109
    object CopytoClipboard2: TMenuItem
      Caption = 'Copy ZPL to Clipboard'
      OnClick = CopytoClipboard2Click
    end
  end
end
