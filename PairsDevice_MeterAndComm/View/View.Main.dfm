object ViewMainForm: TViewMainForm
  Left = 0
  Top = 0
  Caption = 'Pair device - Power meter and communicator'
  ClientHeight = 653
  ClientWidth = 1162
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 1126
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    AlignWithMargins = True
    Left = 3
    Top = 124
    Width = 1156
    Height = 507
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088' '#1060#1048#1054
        MinWidth = 250
      end
      item
        Caption = #1044#1072#1090#1072
        MinWidth = 90
        Width = 90
      end
      item
        Caption = ' '#1042#1088#1077#1084#1103
        MinWidth = 80
        Width = 80
      end
      item
        Caption = #1058#1080#1087' '#1089#1095#1105#1090#1095#1080#1082#1072
        MinWidth = 95
        Width = 95
      end
      item
        Caption = #1057#1077#1088' '#8470' '#1089#1095#1105#1090#1095#1080#1082#1072
        MinWidth = 110
        Width = 110
      end
      item
        Caption = #1042#1077#1088#1089#1080#1103' '#1089#1095#1105#1090#1095#1080#1082#1072
        MinWidth = 110
        Width = 110
      end
      item
        Caption = #1058#1080#1087' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1090#1086#1088#1072
        MinWidth = 127
        Width = 127
      end
      item
        Caption = #1057#1077#1088' '#8470' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1090#1086#1088#1072
        MinWidth = 145
        Width = 145
      end
      item
        Caption = #1042#1077#1088#1089#1080#1103' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1090#1086#1088#1072
        MinWidth = 146
        Width = 146
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    RowSelect = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    ViewStyle = vsReport
    OnData = ListView1Data
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1162
    Height = 121
    Align = alTop
    TabOrder = 1
    object LbFrom: TLabel
      Left = 16
      Top = 9
      Width = 20
      Height = 19
      Caption = #1054#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LbTo: TLabel
      Left = 224
      Top = 9
      Width = 18
      Height = 19
      Caption = #1076#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LbNumberMeter: TLabel
      Left = 464
      Top = 9
      Width = 118
      Height = 19
      Caption = #1053#1086#1084#1077#1088' '#1089#1095#1105#1090#1095#1080#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edNumberMeter: TEdit
      Left = 588
      Top = 6
      Width = 173
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edNumberMeterChange
    end
    object ToDateTimePicker: TDateTimePicker
      Left = 248
      Top = 6
      Width = 144
      Height = 24
      Date = 43300.603998645830000000
      Time = 43300.603998645830000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = ToDateTimePickerChange
    end
    object FromDateTimePicker: TDateTimePicker
      Left = 42
      Top = 6
      Width = 144
      Height = 24
      Date = 43300.000000000000000000
      Time = 43300.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = FromDateTimePickerChange
    end
    object cbRiM189_2x: TCheckBox
      Left = 588
      Top = 48
      Width = 114
      Height = 17
      Caption = #1056#1080#1052' 189.2x'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
      OnClick = cbRiM189_2xClick
    end
    object cbRiM289_2x: TCheckBox
      Left = 588
      Top = 71
      Width = 114
      Height = 17
      Caption = #1056#1080#1052' 289.2'#1093
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      OnClick = cbRiM289_2xClick
    end
    object cbRiM489_2x: TCheckBox
      Left = 588
      Top = 94
      Width = 149
      Height = 17
      Caption = #1056#1080#1052' 489.2x (3x)'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
      OnClick = cbRiM489_2xClick
    end
    object CheckBox4: TCheckBox
      Left = 896
      Top = 80
      Width = 97
      Height = 17
      Caption = 'CheckBox4'
      TabOrder = 6
      Visible = False
    end
    object ActivityIndicatorWait: TActivityIndicator
      Left = 194
      Top = 49
      IndicatorSize = aisLarge
      IndicatorType = aitRotatingSector
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 634
    Width = 1162
    Height = 19
    Panels = <
      item
        Text = '- - -'
        Width = 300
      end
      item
        Width = 650
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1087#1080#1089#1077#1081':'
        Width = 250
      end>
    SimpleText = 'rrrrrrr'
  end
end
