unit UBloqueiaSysdba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.StdCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, ShellApi, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Comp.Script, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmBloqueiaSysdba = class(TForm)
    Label1: TLabel;
    editPath: TEdit;
    Button1: TButton;
    btConexao: TButton;
    labConectado: TLabel;
    FDConexao: TFDConnection;
    Label4: TLabel;
    editUserDBA: TEdit;
    editSenhaDBA: TEdit;
    Label5: TLabel;
    FDQuery: TFDQuery;
    Memo1: TMemo;
    FDScript1: TFDScript;
    FDStoredProc1: TFDStoredProc;
    MemoResultado: TMemo;
    panelProcessar: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    editUser: TEdit;
    editPwd: TEdit;
    Button2: TButton;
    EditCaminhoFB: TEdit;
    Button3: TButton;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure btConexaoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure buscaCaminhoFb;
    function FindFile(aPath, FileName: string; SubDir: Boolean = True): String;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBloqueiaSysdba: TfrmBloqueiaSysdba;

implementation

{$R *.dfm}

procedure TfrmBloqueiaSysdba.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBloqueiaSysdba.btConexaoClick(Sender: TObject);
begin
  try
    FDConexao.Connected := false;
    FDConexao.Params.Values['Database'] := editPath.text;
    FDConexao.Params.Values['username'] := editUserDBA.text;
    FDConexao.Params.Values['password'] := editSenhaDBA.text;
    FDConexao.LoginPrompt := false;
    FDConexao.Connected := True;
    labConectado.font.Color := clblue;
    labConectado.caption := 'Banco de dados conectado com sucesso!';
    MemoResultado.clear;
    MemoResultado.lines.add('----- Log de operações ------');
    MemoResultado.lines.add('Banco de dados conectado com sucesso!');
    panelProcessar.visible := True;
    buscaCaminhoFb;
  except
    labConectado.font.Color := clred;
    panelProcessar.visible := false;
    labConectado.caption := 'Erro de conexão com o Banco de dados!';
    MemoResultado.lines.add('----- Log de operações ------');
    MemoResultado.lines.add('Erro de conexão com o Banco de dados!');
  end;
end;

procedure TfrmBloqueiaSysdba.buscaCaminhoFb;
var
  CaminhoFb: string;
begin
  CaminhoFb:='';
  if CaminhoFb = '' then
    CaminhoFb := FindFile('C:\Program Files\Firebird\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('C:\Program Files (x86)\Firebird\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('D:\Program Files\Firebird\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('D:\Program Files (x86)\Firebird\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('E:\Program Files\Firebird\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('E:\Program Files (x86)\Firebird\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('C:\Program Files\', 'gsec.exe');
  if CaminhoFb = '' then
    CaminhoFb := FindFile('C:\Program Files (x86)\', 'gsec.exe');

  if caminhofb<>'' then
     EditCaminhoFB.text := ExtractFileDir(caminhofb)
  else
  begin
    Showmessage('Caminho do firebird não encontrado');
    Editcaminhofb.setfocus;
  end;
end;

procedure TfrmBloqueiaSysdba.Button1Click(Sender: TObject);
begin
  if OpenDialog1.execute then
    editPath.text := OpenDialog1.FileName;
end;

procedure TfrmBloqueiaSysdba.Button2Click(Sender: TObject);
var
  msg: String;
  I: Integer;
begin
  if not (DirectoryExists(EditCaminhoFB.text)) then
  begin
    Showmessage('O caminho informado do firebird não existe.');
    EditCaminhoFB.SetFocus;
    MemoResultado.lines.add('Operação abortada!');
    Exit;
  end;

  if (editUser.text = '') or (editPwd.text = '') then
  begin
    Showmessage('Usuário e/ou senha não podem ser vazios.');
    MemoResultado.lines.add('Operação abortada!');
    Exit;
  end;

  if application.MessageBox(pchar('Será criado usuário ' + editUser.text +
    ' com as mesmas permissões do ' + editUserDBA.text + '. O usuário ' +
    editUserDBA.text + ' será bloqueado!' + #13 +
    'Confirma a execução desse procedimento? '), 'Atenção',
    mb_iconquestion + mb_yesno) = idyes then
  begin

    // criacao do usuario
    msg := '"' + EditCaminhoFB.text + '\gsec" -user ' + editUserDBA.text +
      ' -password ' + editSenhaDBA.text + ' -add  ' + editUser.text + '  -pw  '
      + editPwd.text;
    Memo1.lines.clear;
    Memo1.lines.add(msg);
    Memo1.lines.SaveToFile(ExtractFilePath(application.ExeName) +
      'createUser.bat');

    ShellExecute(handle, 'open', pchar(ExtractFilePath(application.ExeName) +
      'createUser.bat'), '', '', SW_HIDE);
    sleep(4000);

    MemoResultado.lines.add('Usuário ' + editUser.text +
      ' criado com sucesso!');

    // aplicacao da procedure de permissoes
    FDScript1.SQLScriptFileName := 'procGrantUser.sql';
    FDScript1.ValidateAll;
    FDScript1.ExecuteAll;

    // execucao da procedure de premissoes para o novousuario
    FDStoredProc1.StoredProcName := 'procGrantUser';
    with FDStoredProc1.Params do
    begin
      clear;
      with add do
      begin
        Name := 'novousuario';
        ParamType := ptInput;
        DataType := ftString;
        Size := 20;
      end;
    end;
    FDStoredProc1.Params.ParamByName('novousuario').value := editUser.text;
    try
      FDStoredProc1.ExecProc;
      MemoResultado.lines.add('==========================');
      MemoResultado.lines.add
        ('Permissões nos objetos do banco de dados dadas com sucesso para ' +
        editUser.text);
      MemoResultado.lines.add('==========================');
      MemoResultado.lines.add
        ('Retirada de Permissões nos objetos do banco de dados para PUBLIC');
    except
      MemoResultado.lines.add
        ('Erro em "Permissões nos objetos do banco dadas com sucesso para ' +
        editUser.text + '"');
      MemoResultado.lines.add
        ('Erro em "Retirada de Permissões nos objetos do banco dadas com sucesso para PUBLIC"');
      MemoResultado.lines.add('Operação abortada!');
      Exit;
    end;

    // aplicacao dos grants nas tabelas de sistemas para o novo usuario e retirada de permissao do usuario public
    Memo1.lines.clear;
    Memo1.lines.LoadFromFile('grants.sql');
    Memo1.lines.text := stringreplace(Memo1.lines.text, '%usuario%',
      editUser.text, [rfReplaceAll]);
    FDConexao.TxOptions.AutoCommit := True;
    MemoResultado.lines.add('==========================');
    MemoResultado.lines.add('Grants e Revokes para ' + editUser.text +
      ', PUBLIC e SYSDBA: ');
    for I := 0 to Memo1.lines.Count - 1 do
    begin
      FDQuery.SQL.clear;
      FDQuery.SQL.add(Memo1.lines[I]);
      try
        FDQuery.ExecSQL;
        Memo1.lines[I] := 'OK - ' + Memo1.lines[I];
        MemoResultado.lines.add(Memo1.lines[I]);
      except
        Memo1.lines[I] := 'Erro - ' + Memo1.lines[I];
        MemoResultado.lines.add(Memo1.lines[I]);
        MemoResultado.lines.add('Operação abortada!');
        Exit;
      end;
    end;

    // Bloqueio do usuario
    MemoResultado.lines.add('==========================');
    FDQuery.SQL.clear;
    FDQuery.SQL.add('CREATE EXCEPTION RESTRITO ' +
      quotedstr('Acesso nao permitido.'));
    try
      FDQuery.ExecSQL;
      MemoResultado.lines.add('Exception criado com sucesso. ');
    except
      MemoResultado.lines.add('Erro criando a Exception');
      MemoResultado.lines.add('Operação abortada!');
    end;

    MemoResultado.lines.add('==========================');
    Memo1.lines.LoadFromFile('triggerBloqueio.sql');
    Memo1.lines.text := stringreplace(Memo1.lines.text, '%usuario%',
      editUser.text, [rfReplaceAll]);
    FDQuery.SQL.clear;
    for I := 0 to Memo1.lines.Count - 1 do
      FDQuery.SQL.add(Memo1.lines[I]);
    try
      FDQuery.ExecSQL;
      MemoResultado.lines.add('Trigger de bloqueio criada com sucesso. ');
    except
      MemoResultado.lines.add('Erro criando a Trigger de bloqueio');
      MemoResultado.lines.add('Operação abortada!');
    end;

    // aplicacao da procedure de permissoes  SYSDBA
    FDScript1.SQLScriptFileName := 'procGrantUserSYSDBA.sql';
    FDScript1.ValidateAll;
    FDScript1.ExecuteAll;
    MemoResultado.lines.add('==========================');
    MemoResultado.lines.add('BLOQUEIOS FINAIS DO SYSDBA:');
    FDScript1.SQLScriptFileName := 'procGrantUserSYSDBA.sql';
    FDScript1.ValidateAll;
    FDScript1.ExecuteAll;
    // execucao da procedure retira grants para o SYSDBA
    FDStoredProc1.StoredProcName := 'procGrantUserSYSDBA';
    try
      FDStoredProc1.ExecProc;
      MemoResultado.lines.add('Sucesso retirada de grants do SYSDBA. ');
      MemoResultado.lines.add('==========================');
      MemoResultado.lines.SaveToFile('log.txt');
      MemoResultado.lines.add('Arquivo de log gerado com sucesso (log.txt).');
      MemoResultado.lines.add('==========================');
      MemoResultado.lines.add('Processo finalizado.');

    except
      MemoResultado.lines.add('Erro retirada de grants do SYSDBA. ');
      MemoResultado.lines.add('Operação abortada!');
    end;

  end;
end;

procedure TfrmBloqueiaSysdba.Button3Click(Sender: TObject);
begin
  if OpenDialog1.execute then
    EditCaminhoFB.text := extractFiledir(OpenDialog1.FileName);
end;

function TfrmBloqueiaSysdba.FindFile(aPath, FileName: string;
  SubDir: Boolean): String;
var
  FD: TWin32findData;

  function _FindDir(wPath: string; var vRes: string): Boolean;
  var
    H: THandle;
  begin
    _FindDir := false;
    H := FindFirstFile(pchar(wPath + FileName), FD);
    if H <> INVALID_HANDLE_VALUE then
      try
        repeat
          if (Copy(FD.cFileName, 1, 1) <> '.') then
          begin
            vRes := wPath + FD.cFileName;
            _FindDir := True;
            Exit;
          end;
        until not(FindNextFile(H, FD));
      finally
        Winapi.Windows.FindClose(H);
      end;

    if not SubDir then
      Exit;

    H := FindFirstFile(pchar(wPath + '*.'), FD);
    if H <> INVALID_HANDLE_VALUE then
      try
        repeat
          if (FD.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
            if Copy(FD.cFileName, 1, 1) <> '.' then
            begin
              if _FindDir(wPath + FD.cFileName + '\', vRes) then
              begin
                Result := True;
                Exit;
              end;
            end;
        until not(FindNextFile(H, FD));
      finally
        Winapi.Windows.FindClose(H);
      end;
  end;

begin
  if not _FindDir(IncludeTrailingBackslash(aPath), Result) then
    Result := '';
end;

end.
