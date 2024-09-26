# ZPL2FTP
Simple ZPL editor and send ZPL file to FTP server

### After compile there should be:
- ZPL_files/              - folder for ZPL files
    lbrly.zpl             - default ZPL
    newlabel.zpl          - edited ZPL
- IR.exe                  - main executable
- IR.INI                  - settings text file
- IR_ZPL.dcu (probably)   - Delphi file

### Settings file:
```
{
[FTP]
host=192.168.0.175  ; IP adress of the FTP server
username=ftp-user   ; username for the FTP server
password=1234       ; password for the FTP server (yeah I know)

[LABEL]
template=lbrly.zpl  ; default label which is loaded in editor (DEFAULT button)
final=newlabel.zpl  ; label which is saved after pressing on SAVE button
}
```
