object FrmContract: TFrmContract
  Left = 0
  Top = 0
  Caption = 'Contratos'
  ClientHeight = 561
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
    Height = 561
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
    ExplicitHeight = 361
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
        Width = 68
        Height = 19
        Caption = 'Contratos'
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
      Height = 505
      ActivePage = TbShAdd
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitHeight = 305
      object TbShList: TTabSheet
        Caption = 'Listagem'
        ExplicitHeight = 274
        object LblTotal: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 455
          Width = 562
          Height = 16
          Align = alBottom
          Alignment = taRightJustify
          Caption = '0'
          ExplicitLeft = 558
          ExplicitTop = 255
          ExplicitWidth = 7
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 568
          Height = 88
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          DesignSize = (
            568
            88)
          object Label5: TLabel
            Left = 154
            Top = 40
            Width = 49
            Height = 16
            Caption = 'Produtor'
          end
          object Label6: TLabel
            Left = 3
            Top = 40
            Width = 81
            Height = 16
            Caption = 'Armaz'#233'm/Silo'
          end
          object Label7: TLabel
            Left = 305
            Top = 40
            Width = 27
            Height = 16
            Caption = 'Gr'#227'o'
          end
          object Label4: TLabel
            Left = 456
            Top = 40
            Width = 49
            Height = 16
            Caption = 'Validado'
          end
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
          object CboxSearchStorage: TComboBox
            Left = 3
            Top = 62
            Width = 145
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 2
          end
          object CBoxSearchProducer: TComboBox
            Left = 154
            Top = 62
            Width = 145
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 3
          end
          object CBoxSearchGrain: TComboBox
            Left = 305
            Top = 62
            Width = 145
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 4
          end
          object CBoxSearchValidated: TComboBox
            Left = 456
            Top = 62
            Width = 109
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 5
          end
        end
        object DBGrid: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 91
          Width = 562
          Height = 358
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleHotTrack]
          ParentFont = False
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
              Width = 24
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRODUCER_NAME'
              Title.Caption = 'PRODUTOR'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GRAIN_DESC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = 'GR'#195'O'
              Width = 75
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'VALIDATED'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Title.Caption = 'VALIDA'#199#195'O'
              Width = 50
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'INITIAL_WEIGHT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Title.Caption = 'PESO INICIAL'
              Width = 75
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'MOISTURE_PERCENT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Title.Caption = 'HUMIDADE %'
              Width = 75
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'FINAL_WEIGHT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Title.Caption = 'PESO FINAL'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'INITIAL_WEIGHTED_BY_NAME'
              Title.Caption = 'PESADO INI. POR'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STORAGE_NAME'
              Title.Caption = 'ARMAZ'#201'M'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'INITIAL_WEIGHTED_AT'
              Title.Caption = 'PESADO INI. EM'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MOISTURE_BY_NAME'
              Title.Caption = 'REG. UMIDADE POR'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MOISTURE_AT'
              Title.Caption = 'REG. UMIDADE EM'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FINAL_WEIGHTED_BY_NAME'
              Title.Caption = 'PESADO FIN. POR'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FINAL_WEIGHTED_AT'
              Title.Caption = 'PESADO FIN. EM'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALIDATED_BY'
              Title.Caption = 'VALIDADO POR'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALIDATED_AT'
              Title.Caption = 'VALIDADO EM'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CREATED_AT'
              Title.Caption = 'DTHR CRIA'#199#195'O'
              Width = 100
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
            end
            item
              Expanded = False
              FieldName = 'EXTERNAL_ID'
              Title.Caption = 'ID EXTERNO'
              Width = 100
              Visible = True
            end>
        end
      end
      object TbShAdd: TTabSheet
        Caption = 'Cadastro'
        ImageIndex = 1
        ExplicitHeight = 274
        object PnlControls: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 431
          Width = 562
          Height = 40
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitTop = 231
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
        object ScBoxForm: TScrollBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 562
          Height = 422
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          ParentColor = False
          TabOrder = 0
          DesignSize = (
            562
            422)
          object Produtor: TLabel
            Left = 3
            Top = 81
            Width = 61
            Height = 16
            Caption = 'Produtor *'
          end
          object Label2: TLabel
            Left = 3
            Top = 18
            Width = 93
            Height = 16
            Caption = 'Armaz'#233'm/Silo *'
          end
          object Label3: TLabel
            Left = 3
            Top = 145
            Width = 39
            Height = 16
            Caption = 'Gr'#227'o *'
          end
          object CboxStorage: TComboBox
            Left = 3
            Top = 40
            Width = 556
            Height = 22
            Style = csOwnerDrawFixed
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object CboxProducer: TComboBox
            Left = 3
            Top = 103
            Width = 556
            Height = 22
            Style = csOwnerDrawFixed
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
          end
          object CboxGrain: TComboBox
            Left = 3
            Top = 167
            Width = 556
            Height = 22
            Style = csOwnerDrawFixed
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 2
            OnChange = CboxGrainChange
          end
          object EdInitialWeight: TLabeledEdit
            Left = 3
            Top = 241
            Width = 150
            Height = 24
            EditLabel.Width = 118
            EditLabel.Height = 16
            EditLabel.Caption = 'Pesagem Inicial (KG)'
            TabOrder = 3
            OnChange = EdInitialWeightChange
          end
          object EdMoisturePercent: TLabeledEdit
            Left = 206
            Top = 241
            Width = 150
            Height = 24
            EditLabel.Width = 95
            EditLabel.Height = 16
            EditLabel.Caption = 'Humidade (% U)'
            TabOrder = 4
            OnChange = EdMoisturePercentChange
          end
          object EdFinalWeight: TLabeledEdit
            Left = 409
            Top = 241
            Width = 150
            Height = 24
            EditLabel.Width = 87
            EditLabel.Height = 16
            EditLabel.Caption = 'Peso Final (KG)'
            TabOrder = 5
            OnChange = EdFinalWeightChange
          end
          object EdGrainPrice: TLabeledEdit
            Left = 3
            Top = 313
            Width = 150
            Height = 24
            Color = clInactiveCaption
            EditLabel.Width = 111
            EditLabel.Height = 16
            EditLabel.Caption = 'Pre'#231'o Gr'#227'o (R$/Kg)'
            ReadOnly = True
            TabOrder = 6
          end
          object EdTotalWeighted: TLabeledEdit
            Left = 206
            Top = 313
            Width = 150
            Height = 24
            Color = clInactiveCaption
            EditLabel.Width = 132
            EditLabel.Height = 16
            EditLabel.Caption = 'Peso Armazenado (KG)'
            ReadOnly = True
            TabOrder = 7
          end
          object EdTotalPrice: TLabeledEdit
            Left = 409
            Top = 313
            Width = 150
            Height = 24
            Color = clMoneyGreen
            EditLabel.Width = 92
            EditLabel.Height = 16
            EditLabel.Caption = 'Valor Total (R$)'
            ReadOnly = True
            TabOrder = 8
          end
          object RdGrValidated: TRadioGroup
            Left = 3
            Top = 354
            Width = 150
            Height = 59
            Caption = 'Validado'
            ItemIndex = 0
            Items.Strings = (
              'N'#195'O'
              'SIM')
            TabOrder = 9
            OnClick = RdGrValidatedClick
          end
          object EdValidatedBy: TLabeledEdit
            Left = 206
            Top = 375
            Width = 353
            Height = 24
            EditLabel.Width = 72
            EditLabel.Height = 16
            EditLabel.Caption = 'Validado Por'
            TabOrder = 10
            Visible = False
          end
        end
      end
    end
  end
end
