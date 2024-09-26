# ZPL2FTP
Simple example ZPL editor and ZPL file transfer to FTP server
---
2do: LOAD label button

### After compile there should be:
- ZPL_files/              - folder for ZPL files
    lbrly.zpl             - default ZPL
    newlabel.zpl          - edited ZPL
- IR.exe                  - main executable
- IR.INI                  - settings text file
- IR_ZPL.dcu (probably)   - Delphi system file

### Settings file (IR.INI):
```
[FTP]
host=192.168.0.175  ; IP adress of the FTP server
username=ftp-user   ; username for the FTP server
password=1234       ; password for the FTP server (yeah I know)

[LABEL]
template=lbrly.zpl  ; default label which is loaded in editor (DEFAULT button)
final=newlabel.zpl  ; label which is saved after pressing on SAVE button
```
