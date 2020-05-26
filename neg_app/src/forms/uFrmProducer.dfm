object FrmProducer: TFrmProducer
  Left = 0
  Top = 0
  Caption = 'FrmProducer'
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
      DesignSize = (
        582
        48)
      object Label1: TLabel
        Left = 16
        Top = 13
        Width = 62
        Height = 19
        Caption = 'Produtor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object BtnNew: TButton
        Left = 485
        Top = 7
        Width = 90
        Height = 34
        Anchors = [akTop, akRight]
        Caption = 'Novo'
        TabOrder = 0
      end
    end
    object PgCtrl: TPageControl
      AlignWithMargins = True
      Left = 4
      Top = 52
      Width = 576
      Height = 305
      ActivePage = TbShList
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object TbShList: TTabSheet
        Caption = 'Listagem'
        object LblTotal: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 255
          Width = 562
          Height = 16
          Align = alBottom
          Alignment = taRightJustify
          Caption = '0'
          ExplicitLeft = 558
          ExplicitWidth = 7
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 568
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          DesignSize = (
            568
            41)
          object EdSearch: TEdit
            Left = 3
            Top = 8
            Width = 473
            Height = 24
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnKeyPress = EdSearchKeyPress
          end
          object BtnSearch: TBitBtn
            Left = 482
            Top = 7
            Width = 83
            Height = 26
            Anchors = [akTop, akRight]
            Caption = 'Pesquisar'
            TabOrder = 1
            OnClick = BtnSearchClick
          end
        end
        object DBGrid: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 44
          Width = 562
          Height = 205
          Align = alClient
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = DBGridDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Title.Caption = '#'
              Width = 32
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Caption = 'NOME'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOCUMENT'
              Title.Caption = 'DOCUMENTO'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMAIL'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONE'
              Title.Caption = 'TELEFONE'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CREATED_AT'
              Title.Caption = 'DTHR CRIA'#199#195'O'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CREATED_BY_NAME'
              Title.Caption = 'CRIADO POR'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CHANGED_AT'
              Title.Caption = 'DTHR ULT. ALTERA'#199#195'O'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CHANGED_BY_NAME'
              Title.Caption = 'ALTERADO POR'
              Width = 100
              Visible = True
            end>
        end
      end
      object TbShAdd: TTabSheet
        Caption = 'Cadastro'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          568
          274)
        object EdName: TLabeledEdit
          Left = 6
          Top = 46
          Width = 556
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 41
          EditLabel.Height = 16
          EditLabel.Caption = 'Nome*'
          MaxLength = 255
          TabOrder = 0
        end
        object PnlControls: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 231
          Width = 562
          Height = 40
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 4
          object BtnDelete: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 90
            Height = 34
            Align = alLeft
            Caption = 'Excluir'
            TabOrder = 2
            Visible = False
            OnClick = BtnDeleteClick
          end
          object BtnCancel: TButton
            AlignWithMargins = True
            Left = 469
            Top = 3
            Width = 90
            Height = 34
            Align = alRight
            Caption = 'Cancelar'
            TabOrder = 1
          end
          object BtnSave: TButton
            AlignWithMargins = True
            Left = 373
            Top = 3
            Width = 90
            Height = 34
            Align = alRight
            Caption = 'Salvar'
            TabOrder = 0
            OnClick = BtnSaveClick
          end
        end
        object EdDoc: TLabeledEdit
          Left = 6
          Top = 111
          Width = 200
          Height = 24
          EditLabel.Width = 72
          EditLabel.Height = 16
          EditLabel.Caption = 'Documento*'
          MaxLength = 25
          TabOrder = 1
        end
        object EdPhone: TLabeledEdit
          Left = 254
          Top = 176
          Width = 200
          Height = 24
          EditLabel.Width = 50
          EditLabel.Height = 16
          EditLabel.Caption = 'Telefone'
          MaxLength = 25
          NumbersOnly = True
          TabOrder = 3
        end
        object EdEmail: TLabeledEdit
          Left = 6
          Top = 176
          Width = 200
          Height = 24
          EditLabel.Width = 31
          EditLabel.Height = 16
          EditLabel.Caption = 'Email'
          MaxLength = 255
          TabOrder = 2
        end
      end
    end
  end
end
