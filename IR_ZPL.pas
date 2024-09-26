unit IR_ZPL;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IniFiles,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  IdUDPBase,
  IdUDPClient,
  IdTrivialFTP,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdFTP,
  Vcl.Menus,
  Clipbrd,
  ShellAPI, Vcl.Mask;

type
  TForm1 = class( TForm )
    LeftPanel : TPanel;
    RightPanel : TPanel;
    TopPanel : TPanel;
    MainPanel : TPanel;
    ZPLCode : TMemo;
    LabeledEdit1 : TLabeledEdit;
    LabeledEdit2 : TLabeledEdit;
    LabeledEdit3 : TLabeledEdit;
    posalji : TButton;
    SaveButton : TButton;
    FTP : TIdFTP;
    dajTemplate : TButton;
    Label1 : TLabel;
    PopupMenu1 : TPopupMenu;
    CopytoClipboard1 : TMenuItem;
    PopupMenu2 : TPopupMenu;
    CopytoClipboard2 : TMenuItem;
    Label2: TLabel;
    procedure UcitajZPL( Sender : TObject );
    procedure posaljiClick( Sender : TObject );
    procedure FormCreate( Sender : TObject );
    procedure firma_onExit( Sender : TObject );
    procedure barcode_onExit( Sender : TObject );
    procedure drzava_onExit( Sender : TObject );
    procedure SaveButtonClick( Sender : TObject );
    procedure FTPDisconnected( Sender : TObject );
    procedure Label1MouseEnter( Sender : TObject );
    procedure Label1MouseLeave( Sender : TObject );
    procedure CopytoClipboard1Click( Sender : TObject );
    procedure Label1Click( Sender : TObject );
    procedure CopytoClipboard2Click( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
      label_dir, template_label, novi_label : string;
  end;

var
  Form1 : TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate( Sender : TObject );
  var
    Ini : TIniFile;
  begin
    Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
    try
      FTP.Host := Ini.ReadString( 'FTP', 'host', '' );
      FTP.Username := Ini.ReadString( 'FTP', 'username', '' );
      FTP.Password := Ini.ReadString( 'FTP', 'password', '' );

      template_label := Ini.ReadString( 'LABEL', 'template', '' );
      novi_label := Ini.ReadString( 'LABEL', 'final', '' );
      // ShowMessage(template_label +' '+novi_label);
    finally
      Ini.Free;
    end;

    label_dir := ExtractFilePath( Application.ExeName ) + 'ZPL_files\';
  end;

procedure TForm1.FTPDisconnected( Sender : TObject );
  begin
    ShowMessage( 'Poslano na FTP. Možda :-)');
  end;

procedure TForm1.Label1Click( Sender : TObject );
  begin
    ShellExecute( Handle, 'OPEN', PChar( ( Sender as TLabel ).Caption ), nil,
      nil, SW_SHOWNORMAL );
  end;

procedure TForm1.Label1MouseEnter( Sender : TObject );
  begin
    ( Sender as TLabel ).Font.Style := ( Sender as TLabel ).Font.Style +
      [ fsUnderline ];

  end;

procedure TForm1.Label1MouseLeave( Sender : TObject );
  begin
    ( Sender as TLabel ).Font.Style := ( Sender as TLabel ).Font.Style -
      [ fsUnderline ];
  end;

procedure TForm1.posaljiClick( Sender : TObject );
  begin
    // snimi fajl prije slanja na FTP
    SaveButtonClick( Sender );

    FTP.Connect;
    FTP.Put( label_dir + novi_label, novi_label, false );
    FTP.Disconnect;
  end;

procedure TForm1.SaveButtonClick( Sender : TObject );
  var
    ime_fajla : string;
    MyFile : TFileStream;
  begin
    ime_fajla := label_dir + novi_label;

    try
      if not FileExists( ime_fajla )
      then
      begin
        MyFile := TFileStream.Create( ime_fajla, fmCreate );
        FreeAndNil( MyFile );
      end;

    except
      ShowMessage( 'Greška prilikom snimanja labele' );
    end;

    ZPLCode.Lines.SaveToFile( ime_fajla );
  end;

procedure TForm1.firma_onExit( Sender : TObject );
  begin
    // popuni naziv firme sa tekstom iz labela
    ZPLCode.Lines[ 7 ] := '^FO220,50^FD' + ( Sender as TLabeledEdit )
      .Text + '^FS';
  end;

procedure TForm1.barcode_onExit( Sender : TObject );
  begin
    // popuni barkodsa tekstom iz labela
    ZPLCode.Lines[ 28 ] := '^FO100,550^BC^FD' + ( Sender as TLabeledEdit )
      .Text + '^FS';
  end;

procedure TForm1.CopytoClipboard1Click( Sender : TObject );
  begin
    Clipboard.AsText := ( PopupMenu1.PopupComponent as TLabel ).Caption;
  end;

procedure TForm1.CopytoClipboard2Click( Sender : TObject );
  begin
    with ( PopupMenu2.PopupComponent as TMemo ) do
    begin
      SelectAll;
      CopyToClipboard;
      SelLength := 0;
    end;
  end;

procedure TForm1.drzava_onExit( Sender : TObject );
  begin
    // popuni naziv države sa tekstom iz labela
    ZPLCode.Lines[ 38 ] := '^FO470,955^FD' + ( Sender as TLabeledEdit )
      .Text + '^FS';
  end;

procedure TForm1.UcitajZPL( Sender : TObject );
  var
    default_file, temp : string;

  begin
    default_file := label_dir + template_label;

    try
      if FileExists( default_file )
      then
        ZPLCode.Lines.LoadFromFile( default_file );
    except
      ShowMessage( 'Greška prilikom učitavanja template labele' );
    end;

    // izbaci ZPL kodove iz linije sa nazivom firme i popuni label
    temp := ZPLCode.Lines[ 7 ];
    temp := StringReplace( temp, '^FO220,50^FD', '',
      [ rfReplaceAll, rfIgnoreCase ] );
    temp := StringReplace( temp, '^FS', '', [ rfReplaceAll, rfIgnoreCase ] );
    LabeledEdit1.Text := temp;

    // izbaci ZPL kodove iz linije sa barkodom i popuni label
    temp := ZPLCode.Lines[ 28 ];
    temp := StringReplace( temp, '^FO100,550^BC^FD', '',
      [ rfReplaceAll, rfIgnoreCase ] );
    temp := StringReplace( temp, '^FS', '', [ rfReplaceAll, rfIgnoreCase ] );
    LabeledEdit2.Text := temp;

    // izbaci ZPL kodove iz linije sa oznakom države i popuni label
    temp := ZPLCode.Lines[ 38 ];
    temp := StringReplace( temp, '^FO470,955^FD', '',
      [ rfReplaceAll, rfIgnoreCase ] );
    temp := StringReplace( temp, '^FS', '', [ rfReplaceAll, rfIgnoreCase ] );
    LabeledEdit3.Text := temp;

  end;

end.
