object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FrmLogin'
  ClientHeight = 371
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PnlFull: TPanel
    Left = 0
    Top = 0
    Width = 394
    Height = 371
    Align = alClient
    BevelOuter = bvLowered
    Color = 14149873
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object LblLoginError: TLabel
      Left = 112
      Top = 231
      Width = 160
      Height = 16
      Caption = '*Usu'#225'rio ou senha inv'#225'lidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 806602
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object EdUsername: TLabeledEdit
      Left = 112
      Top = 146
      Width = 169
      Height = 24
      EditLabel.Width = 43
      EditLabel.Height = 16
      EditLabel.Caption = 'Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'admin'
      OnKeyPress = EdUsernameKeyPress
    end
    object EdPassword: TLabeledEdit
      Left = 112
      Top = 201
      Width = 169
      Height = 24
      EditLabel.Width = 36
      EditLabel.Height = 16
      EditLabel.Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
      Text = 'admin'
      OnKeyPress = EdPasswordKeyPress
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 392
      Height = 72
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
      TabOrder = 3
      object Label1: TLabel
        Left = 16
        Top = 12
        Width = 164
        Height = 19
        Caption = 'Sistema de Controle de'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 34
        Width = 224
        Height = 25
        Caption = 'Armazenagem de Gr'#227'os'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object BtnLogin: TButton
      Left = 112
      Top = 253
      Width = 169
      Height = 38
      Caption = 'Entrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BtnLoginClick
    end
    object Panel2: TPanel
      Left = 1
      Top = 348
      Width = 392
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      object LblInfo: TLabel
        AlignWithMargins = True
        Left = 127
        Top = 3
        Width = 262
        Height = 16
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'info'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 130
      end
      object SpBtnAbout: TSpeedButton
        Left = 57
        Top = 0
        Width = 67
        Height = 22
        Align = alLeft
        Caption = 'Sobre'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = SpBtnAboutClick
        ExplicitLeft = 54
      end
      object SpBtnManual: TSpeedButton
        Left = 0
        Top = 0
        Width = 57
        Height = 22
        Align = alLeft
        Caption = 'Manual'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = SpBtnManualClick
      end
    end
  end
end