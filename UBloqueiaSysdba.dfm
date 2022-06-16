object frmBloqueiaSysdba: TfrmBloqueiaSysdba
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kyrius - Bloqueia Sysdba'
  ClientHeight = 669
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 19
    Width = 944
    Height = 582
  end
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 70
    Height = 13
    Caption = 'Caminho BD:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labConectado: TLabel
    Left = 72
    Top = 176
    Width = 5
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 32
    Top = 66
    Width = 72
    Height = 13
    Caption = 'Usu'#225'rio ADM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 204
    Top = 66
    Width = 35
    Height = 13
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object editPath: TEdit
    Left = 32
    Top = 37
    Width = 339
    Height = 21
    TabOrder = 0
    Text = 'dsknery/3052:kyrius.top1'
  end
  object Button1: TButton
    Left = 372
    Top = 35
    Width = 48
    Height = 25
    Hint = 'Selecione o Banco de Dados...'
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object btConexao: TButton
    Left = 137
    Top = 125
    Width = 102
    Height = 43
    Cursor = crHandPoint
    Caption = 'Conectar'
    TabOrder = 2
    OnClick = btConexaoClick
  end
  object editUserDBA: TEdit
    Left = 32
    Top = 80
    Width = 159
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 3
    Text = 'SYSDBA'
  end
  object editSenhaDBA: TEdit
    Left = 206
    Top = 80
    Width = 163
    Height = 21
    TabOrder = 4
    Text = 'masterkey'
  end
  object Memo1: TMemo
    Left = 1016
    Top = 398
    Width = 2000
    Height = 403
    TabOrder = 5
    Visible = False
  end
  object MemoResultado: TMemo
    Left = 32
    Top = 217
    Width = 913
    Height = 363
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object panelProcessar: TPanel
    Left = 528
    Top = 26
    Width = 386
    Height = 142
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 7
    Visible = False
    object Label2: TLabel
      Left = 0
      Top = 41
      Width = 74
      Height = 13
      Caption = 'Novo Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 176
      Top = 41
      Width = 35
      Height = 13
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 0
      Top = 0
      Width = 190
      Height = 13
      Caption = 'Caminho da instala'#231#227'o do Firebird'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object editUser: TEdit
      Left = 0
      Top = 55
      Width = 159
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object editPwd: TEdit
      Left = 176
      Top = 55
      Width = 159
      Height = 21
      TabOrder = 1
    end
    object Button2: TButton
      Left = 127
      Top = 99
      Width = 102
      Height = 43
      Cursor = crHandPoint
      Caption = 'Processar'
      TabOrder = 2
      OnClick = Button2Click
    end
    object EditCaminhoFB: TEdit
      Left = 1
      Top = 13
      Width = 331
      Height = 21
      TabOrder = 3
    end
    object Button3: TButton
      Left = 338
      Top = 10
      Width = 48
      Height = 25
      Hint = 'Defina o caminho do Firebird...'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object BitBtn1: TBitBtn
    Left = 856
    Top = 607
    Width = 104
    Height = 45
    Cursor = crHandPoint
    Caption = 'Sair'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 8
    OnClick = BitBtn1Click
  end
  object FDConexao: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Left = 808
    Top = 224
  end
  object FDQuery: TFDQuery
    Connection = FDConexao
    Left = 808
    Top = 352
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = FDConexao
    Params = <>
    Macros = <>
    Left = 808
    Top = 288
  end
  object FDStoredProc1: TFDStoredProc
    Connection = FDConexao
    Left = 808
    Top = 424
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.fdb'
    Left = 440
    Top = 32
  end
end
