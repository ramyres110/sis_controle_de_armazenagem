object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 385
  ClientWidth = 769
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object MainMenu1: TMainMenu
    Left = 528
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
        Caption = 'Produtor'
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
end
