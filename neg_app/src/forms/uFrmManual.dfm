object FrmManual: TFrmManual
  Left = 0
  Top = 0
  Caption = 'Manual'
  ClientHeight = 361
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PnlFull: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 361
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
    ExplicitLeft = -107
    ExplicitTop = -88
    ExplicitWidth = 554
    ExplicitHeight = 289
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 582
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
      TabOrder = 0
      ExplicitWidth = 552
      object Label1: TLabel
        Left = 16
        Top = 12
        Width = 50
        Height = 19
        Caption = 'Manual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object WebBrowser1: TWebBrowser
      AlignWithMargins = True
      Left = 4
      Top = 52
      Width = 576
      Height = 305
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 56
      ExplicitTop = 88
      ExplicitWidth = 300
      ExplicitHeight = 150
      ControlData = {
        4C000000883B0000861F00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126209000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
