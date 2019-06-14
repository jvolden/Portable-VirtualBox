Func UpdateXML()

  local $xml_prev = @ScriptDir & "\data\.VirtualBox\VirtualBox.xml-prev"
  If FileExists ($xml_prev) Then
    _Debug("Removing " & $xml_prev, 1)
    FileDelete ($xml_prev)
  EndIf

  local $xml_tmp = @ScriptDir & "\data\.VirtualBox\VirtualBox.xml-tmp"
  If FileExists ($xml_tmp) Then
    _Debug("Removing " & $xml_tmp, 1)
    FileDelete ($xml_tmp)
  EndIf

  If FileExists (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml") OR _
    (FileExists (@ScriptDir&"\data\.VirtualBox\Machines\") AND _
     FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\")) Then
    Local $values0, $values1, $values2, $values3, $values4, $values5, _
          $values6, $values7, $values8, $values9, $values10, $values11, _
          $values12, $values13
    Local $line, $content, $i, $j, $k, $l, $m, $n
    Local $file = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128)
    If $file <> -1 Then
      $line    = FileRead ($file)
      $values0 = _StringBetween ($line, '<MachineRegistry>', '</MachineRegistry>')
      If $values0 = 0 Then
        $values1 = 0
      Else
        $values1 = _StringBetween ($values0[0], 'src="', '"')
      EndIf
      $values2 = _StringBetween ($line, '<HardDisks>', '</HardDisks>')
      If $values2 = 0 Then
        $values3 = 0
      Else
        $values3 = _StringBetween ($values2[0], 'location="', '"')
      EndIf
      $values4 = _StringBetween ($line, '<DVDImages>', '</DVDImages>')
      If $values4 = 0 Then
        $values5 = 0
      Else
        $values5 = _StringBetween ($values4[0], '<Image', '/>')
      EndIf
      $values10 = _StringBetween ($line, '<Global>', '</Global>')
      If $values10 = 0 Then
        $values11 = 0
      Else
        $values11 = _StringBetween ($values10[0], '<SystemProperties', '/>')
      EndIf

      For $i = 0 To UBound ($values1) - 1
        $values6 = _StringBetween ($values1[$i], 'Machines', '.vbox')
        If $values6 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values1[$i], "Machines" & $values6[0] & ".vbox"))
          FileClose ($file)
        EndIf
      Next

      For $j = 0 To UBound ($values3) - 1
        $values7 = _StringBetween ($values3[$j], 'HardDisks', '.vdi')
        If $values7 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values3[$j], "HardDisks" & $values7[0] & ".vdi"))
          FileClose ($file)
        EndIf
      Next

      For $k = 0 To UBound ($values3) - 1
        $values8 = _StringBetween ($values3[$k], 'Machines', '.vdi')
        If $values8 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values3[$k], "Machines" & $values8[0] & ".vdi"))
          FileClose ($file)
        EndIf
      Next

      For $l = 0 To UBound ($values5) - 1
        $values9 = _StringBetween ($values5[$l], 'location="', '"')
        If $values9 <> 0 Then
          If NOT FileExists ($values9[0]) Then
            $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
            $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
            FileWrite ($file, StringReplace ($content, "<Image" & $values5[$l] & "/>", ""))
            FileClose ($file)
          EndIf
        EndIf
      Next

      For $m = 0 To UBound ($values11) - 1
        $values12 = _StringBetween ($values11[$m], 'defaultMachineFolder="', '"')
        If $values12 <> 0 Then
          If NOT FileExists ($values10[0]) Then
            $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
            $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
            FileWrite ($file, StringReplace ($content, $values12[0], @ScriptDir&"\data\.VirtualBox\Machines"))
            FileClose ($file)
          EndIf
        EndIf
      Next

      For $n = 0 To UBound ($values1) - 1
        $values13 = _StringBetween ($values1[$n], 'Machines', '.xml')
        If $values13 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values1[$n], "Machines" & $values13[0] & ".xml"))
          FileClose ($file)
        EndIf
      Next
      FileClose ($file)
    EndIf
  EndIf
EndFunc

; Set VBOX_USER_HOME to our portable directory. 
; Unset VBOX_USER_HOME when closed.
; Create it first if it doesn't exist or VirtualBox.exe will fail to load.
Func SetHomeDir($action)
  local $userHome = @ScriptDir & IniRead ($var1, "userhome", "key", "NotFound")
  If $action = 'set' Then
    If NOT FileExists ($userHome) Then
      DirCreate ($userHome)
      _Debug("VBOX_USER_HOME directory created:" & $userHome, 1)
    EndIf
    If NOT EnvGet("VBOX_USER_HOME") = $userHome Then
      EnvSet ("VBOX_USER_HOME", $userHome)
      _Debug("VBOX_USER_HOME set: " & $userHome, 1)
    EndIf
  ElseIf $action = 'unset' Then
    EnvSet ("VBOX_USER_HOME")
    _Debug("VBOX_USER_HOME unset: " & $userHome, 1)
  EndIf
EndFunc

Func SetArch()
  local $app32 = @ScriptDir & "\app32\"
  local $app64 = @ScriptDir & "\app64\"
  If FileExists ($app32) AND FileExists ($app64) Then
    If @OSArch = "x86" Then
      Global $arch = "app32"
    EndIf
    If @OSArch = "x64" Then
      Global $arch = "app64"
    EndIf
  Else
    If FileExists ($app32) AND NOT FileExists ($app64) Then
      Global $arch = "app32"
    EndIf
    If NOT FileExists ($app32) AND FileExists ($app64) Then
      Global $arch = "app64"
    EndIf
  EndIf
  _Debug("Set host arch: " & $arch, 1)
EndFunc

Func Additions($action)
  If $action = 'load' Then
    If FileExists (@ScriptDir&"\"& $arch &"\") AND FileExists (@ScriptDir&"\vboxadditions\") Then
      DirMove (@ScriptDir&"\vboxadditions\doc", @ScriptDir&"\"& $arch, 1)
      DirMove (@ScriptDir&"\vboxadditions\ExtensionPacks", @ScriptDir&"\"& $arch, 1)
      DirMove (@ScriptDir&"\vboxadditions\nls", @ScriptDir&"\"& $arch, 1)
      FileMove (@ScriptDir&"\vboxadditions\guestadditions\*.*", @ScriptDir&"\"& $arch &"\", 9)
    Endif
  ElseIf $action = 'unload' Then
    If FileExists (@ScriptDir&"\"& $arch &"\") AND FileExists (@ScriptDir&"\vboxadditions\") Then
      DirMove (@ScriptDir&"\"& $arch &"\doc", @ScriptDir&"\vboxadditions\", 1)
      DirMove (@ScriptDir&"\"& $arch &"\ExtensionPacks", @ScriptDir&"\vboxadditions\", 1)
      DirMove (@ScriptDir&"\"& $arch &"\nls", @ScriptDir&"\vboxadditions\", 1)
      FileMove (@ScriptDir&"\"& $arch &"\*.iso", @ScriptDir&"\vboxadditions\guestadditions\", 9)
    EndIf
  EndIf
EndFunc

Func UseSettings ()
  If GUICtrlRead ($Input100) = "" OR GUICtrlRead ($Input100) = IniRead ($var2 & $lng &".ini", "download", "05", "NotFound") Then
    Local $SourceFile = @ScriptDir&"\forgetit"
  Else
    Local $SourceFile = GUICtrlRead ($Input100)
  EndIf

  If NOT (FileExists (@ScriptDir&"\virtualbox.exe") OR _
          FileExists ($SourceFile)) AND _
         (GUICtrlRead ($Checkbox100) = $GUI_CHECKED OR _
          GUICtrlRead ($Checkbox110) = $GUI_CHECKED) Then

    Break (1)
    Exit
  EndIf

  If (FileExists (@ScriptDir&"\virtualbox.exe") OR _
      FileExists ($SourceFile)) AND _
     (GUICtrlRead ($Checkbox100) = $GUI_CHECKED OR _
      GUICtrlRead ($Checkbox110) = $GUI_CHECKED) Then

    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "04", "NotFound"))
    If FileExists (@ScriptDir&"\virtualbox.exe") Then
      Run (@ScriptDir & "\virtualbox.exe -x -p temp", @ScriptDir, @SW_HIDE)
      Opt ("WinTitleMatchMode", 2)
      WinWait ("VirtualBox Installer", "")
      ControlClick ("VirtualBox Installer", "OK", "TButton1")
      WinClose ("VirtualBox Installer", "")
    EndIf

    If FileExists ($SourceFile) Then
      Run ($SourceFile & " -x -p temp", @ScriptDir, @SW_HIDE)
      Opt ("WinTitleMatchMode", 2)
      WinWait ("VirtualBox Installer", "")
      ControlClick ("VirtualBox Installer", "OK", "TButton1")
      WinClose ("VirtualBox Installer", "")
    EndIf
  EndIf

  If FileExists (@ScriptDir & "\Extension") Then
    If FileExists (@ScriptDir & "\Extension") Then

      RunWait (@ScriptDir & "\data\tools\7za.exe x -o" & _
               @ScriptDir & "\temp\ " & _
               @ScriptDir & "\Extension", _
               @ScriptDir, @SW_HIDE)

      RunWait (@ScriptDir & "\data\tools\7za.exe x -o" & _
               @ScriptDir & "\temp\ExtensionPacks\Oracle_VM_VirtualBox_Extension_Pack\ " & _
               @ScriptDir & "\temp\Extension~", _
               @ScriptDir, @SW_HIDE)
    EndIf
  EndIf

  If GUICtrlRead ($Checkbox100) = $GUI_CHECKED AND FileExists (@ScriptDir&"\temp") Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "05", "NotFound"))
    RunWait ("cmd /c ren ""%CD%\temp\*_x86.msi"" x86.msi", @ScriptDir, @SW_HIDE)
    RunWait ("cmd /c msiexec.exe /quiet /a ""%CD%\temp\x86.msi"" TARGETDIR=""%CD%\temp\x86""", @ScriptDir, @SW_HIDE)
    DirCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox", @ScriptDir&"\app32", 1)
    FileCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox\*", @ScriptDir&"\app32", 9)
    DirRemove (@ScriptDir&"\app32\accessible", 1)
    DirRemove (@ScriptDir&"\app32\sdk", 1)
  EndIf

  If GUICtrlRead ($Checkbox110) = $GUI_CHECKED AND FileExists (@ScriptDir&"\temp") Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "05", "NotFound"))
    RunWait ("cmd /c ren ""%CD%\temp\*_amd64.msi"" amd64.msi", @ScriptDir, @SW_HIDE)
    RunWait ("cmd /c msiexec.exe /quiet /a ""%CD%\temp\amd64.msi"" TARGETDIR=""%CD%\temp\x64""", @ScriptDir, @SW_HIDE)
    DirCopy (@ScriptDir&"\temp\x64\PFiles\Oracle\VirtualBox", @ScriptDir&"\app64", 1)
    FileCopy (@ScriptDir&"\temp\x64\PFiles\Oracle\VirtualBox\*", @ScriptDir&"\app64", 9)
    DirRemove (@ScriptDir&"\app64\accessible", 1)
    DirRemove (@ScriptDir&"\app64\sdk", 1)
  EndIf

  If GUICtrlRead ($Checkbox100) = $GUI_CHECKED AND GUICtrlRead ($Checkbox110) = $GUI_CHECKED Then
    GUICtrlSetData ($Input200, @LF & "Please wait, delete files and folders.")
    DirCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox\", @ScriptDir&"\vboxadditions", 1)
    DirCopy (@ScriptDir&"\temp\ExtensionPacks\", @ScriptDir&"\vboxadditions\ExtensionPacks", 1)
    FileCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox\*.iso", @ScriptDir&"\vboxadditions\guestadditions\*.iso", 9)
    DirRemove (@ScriptDir&"\vboxadditions\accessible", 1)
    DirRemove (@ScriptDir&"\vboxadditions\drivers", 1)
    DirRemove (@ScriptDir&"\vboxadditions\sdk", 1)
    FileDelete (@ScriptDir&"\vboxadditions\*.*")
    DirRemove (@ScriptDir&"\app32\doc", 1)
    DirRemove (@ScriptDir&"\app32\nls", 1)
    FileDelete (@ScriptDir&"\app32\*.iso")
    DirRemove (@ScriptDir&"\app64\doc", 1)
    DirRemove (@ScriptDir&"\app64\nls", 1)
    FileDelete (@ScriptDir&"\app64\*.iso")
  EndIf

  If FileExists (@ScriptDir&"\temp") Then
    DirRemove (@ScriptDir&"\temp", 1)
    FileDelete (@ScriptDir&"\virtualbox.exe")
    FileDelete (@ScriptDir&"\extension")
  EndIf

  If GUICtrlRead ($Checkbox130) = $GUI_CHECKED Then
    IniWrite (@ScriptDir&"\data\settings\vboxinstall.ini", "startvbox", "key", "1")
  Else
    IniWrite (@ScriptDir&"\data\settings\vboxinstall.ini", "startvbox", "key", "0")
  EndIf

  If (FileExists (@ScriptDir&"\virtualbox.exe") OR _
      FileExists ($SourceFile)) AND _
     (GUICtrlRead ($Checkbox100) = $GUI_CHECKED OR _
      GUICtrlRead ($Checkbox110) = $GUI_CHECKED) Then

    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "08", "NotFound"))
    Sleep (2000)
  EndIf

  GUIDelete ()
  $install = 0
EndFunc

Func Licence ()
  _IECreate ("http://www.virtualbox.org/wiki/VirtualBox_PUEL", 1, 1)
EndFunc