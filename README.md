# ZPL2FTP
Simple example ZPL editor and ZPL file transfer to FTP server
---
To edit the ZPL code in the right panel, you can do it manually or through the edit boxes (if you use template code).  
Template ZPL is copy from Laberly online viewer [Laberly viewer](https://labelary.com/viewer.html)  
2do: 'LOAD/SAVE AS label' button  

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
; IP adress of the FTP server
host=192.168.0.175  
; username for the FTP server
username=ftp-user   
; password for the FTP server (yeah I know)
password=1234       

[LABEL]
; default label which is loaded in editor (DEFAULT button)
template=lbrly.zpl  
; label which is saved after pressing on SAVE button
final=newlabel.zpl  
```

