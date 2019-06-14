Func CheckUpdate ()
  If FileExists (@ScriptDir&"\update.exe") Then
    Sleep (2000)
    DirRemove (@ScriptDir&"\update", 1)
    FileDelete (@ScriptDir&"\update.exe")
  EndIf

  Local $hDownload = InetGet ($updateUrl&"update.dat", @TempDir&"\update.ini", 1, 1)
  Do
    Sleep (250)
  Until InetGetInfo ($hDownload, 2)
  InetClose ($hDownload)

  If FileExists (@TempDir&"\update.ini") Then
    If IniRead (@TempDir&"\update.ini", "version", "key", "NotFound") <= _
       IniRead (@ScriptDir&"\data\settings\settings.ini", "version", "key", "NotFound") Then
        $new1 = 0
    Else
        $new1 = 1
    Endif
    If IniRead (@TempDir&"\update.ini", "starter", "key", "NotFound") <= _
       IniRead (@ScriptDir&"\data\settings\settings.ini", "starter", "key", "NotFound") Then
        $new2 = 0
    Else
        $new2 = 1
    Endif
  EndIf

  If $new1 = 1 OR $new2 = 1 Then
    Global $Input300, $Checkbox200
    Global $update = 1

    Local $ov = IniRead ($var1, "version", "key", "NotFound")
    Local $os = IniRead ($var1, "starter", "key", "NotFound")
    Local $nv = IniRead (@TempDir&"\update.ini", "version", "key", "NotFound")
    Local $ns = IniRead (@TempDir&"\update.ini", "starter", "key", "NotFound")

    Local $ovd1 = StringTrimRight($ov, 3)
    Local $ovd2 = StringTrimLeft($ov, 1)
    Local $ovd3 = StringTrimRight($ovd2, 2)
    Local $ovd4 = StringTrimLeft($ov, 2)
    Local $ovd5 = StringTrimRight($ovd4, 1)
    Local $ovd6 = StringTrimLeft($ov, 3)

    Local $osd1 = StringTrimRight($os, 3)
    Local $osd2 = StringTrimLeft($os, 1)
    Local $osd3 = StringTrimRight($osd2, 2)
    Local $osd4 = StringTrimLeft($os, 2)
    Local $osd5 = StringTrimRight($osd4, 1)
    Local $osd6 = StringTrimLeft($os, 3)

    Local $nvd1 = StringTrimRight($nv, 3)
    Local $nvd2 = StringTrimLeft($nv, 1)
    Local $nvd3 = StringTrimRight($nvd2, 2)
    Local $nvd4 = StringTrimLeft($nv, 2)
    Local $nvd5 = StringTrimRight($nvd4, 1)
    Local $nvd6 = StringTrimLeft($nv, 3)

    Local $nsd1 = StringTrimRight($ns, 3)
    Local $nsd2 = StringTrimLeft($ns, 1)
    Local $nsd3 = StringTrimRight($nsd2, 2)
    Local $nsd4 = StringTrimLeft($ns, 2)
    Local $nsd5 = StringTrimRight($nsd4, 1)
    Local $nsd6 = StringTrimLeft($ns, 3)

    If $ovd5 = 0 Then
      Local $ov_d = "v"& $ovd1 &"."& $ovd3 &"."& $ovd6
    Else
      Local $ov_d = "v"& $ovd1 &"."& $ovd3 &"."& $ovd5 &"."& $ovd6
    EndIf

    If $nsd5 = 0 Then
      Local $os_d = "v"& $osd1 &"."& $osd3 &"."& $osd6
    Else
      Local $os_d = "v"& $osd1 &"."& $osd3 &"."& $osd5 &"."& $osd6
    EndIf

    If $nvd5 = 0 Then
      Local $nv_d = "v"& $nvd1 &"."& $nvd3 &"."& $nvd6
    Else
      Local $nv_d = "v"& $nvd1 &"."& $nvd3 &"."& $nvd5 &"."& $nvd6
    EndIf

    If $nsd5 = 0 Then
      Local $ns_d = "v"& $nsd1 &"."& $nsd3 &"."& $nsd6
    Else
      Local $ns_d = "v"& $nsd1 &"."& $nsd3 &"."& $nsd5 &"."& $nsd6
    EndIf

    Local $WS_POPUP

    If $new1 = 1 AND $new2 = 0 Then
      Local $dialog = IniRead ($var2 & $lng &".ini", "check", "02", "NotFound") &" "& $ov_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $nv_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "07", "NotFound")
    EndIf

    If $new1 = 0 AND $new2 = 1 Then
      Local $dialog = IniRead ($var2 & $lng &".ini", "check", "03", "NotFound") &" "& $os_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $ns_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "07", "NotFound")
    EndIf

    If $new1 = 1 AND $new2 = 1 Then
      Local $dialog = IniRead ($var2 & $lng &".ini", "check", "04", "NotFound") &" "& $ov_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $nv_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "05", "NotFound") &" "& $os_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $ns_d &" "& _
                      IniRead ($var2 & $lng &".ini", "check", "07", "NotFound")
    EndIf

    GUICreate (IniRead ($var2 & $lng &".ini", "check", "01", "NotFound"), 300, 190, -1, -1, $WS_POPUP)
    GUISetFont (9, 400, 0, "Arial")
    GUISetBkColor (0xFFFFFF)
    GUICtrlSetFont (-1, 10, 800, 0, "Arial")

    GUICtrlCreateLabel ($dialog, 14, 8, 260, 50)
    GUICtrlSetFont (-1, 9, 800, "Arial")

    $Checkbox200 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "check", "08", "NotFound"), 14, 62, 260, 14)

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "check", "09", "NotFound"), 14, 82, 280, 10)
    GUICtrlSetFont (-1, 8, 800, 4,"Arial")
    $Input300 = GUICtrlCreateLabel ("", 14, 96, 260, 20)
    GUICtrlSetFont (-1, 8, 400, 0,"Arial")

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "check", "10", "NotFound"), 32, 116, 100, 33, 0)
    GUICtrlSetFont (-1, 9, 800, "Arial")
    GUICtrlSetOnEvent (-1, "UpdateYes")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "check", "11", "NotFound"), 160, 116, 100, 33, 0)
    GUICtrlSetFont (-1, 9, 800, "Arial")
    GUICtrlSetOnEvent (-1, "UpdateNo")

    GUISetState ()

    While 1
      If $update = 0 Then ExitLoop
    WEnd
  EndIf

  If IniRead (@ScriptDir&"\data\settings\settings.ini", "update", "key", "NotFound") = 1 Then
    Sleep (2000)
    FileDelete (@TempDir&"\update.ini")
  EndIf
EndFunc

Func UpdateYes ()
  If $new1 = 1 Then
    Local $hDownload = InetGet ($updateUrl&"vboxinstall.dat", @ScriptDir&"\data\settings\vboxinstall.ini", 1, 1)
    Do
      Sleep (250)
    Until InetGetInfo ($hDownload, 2)
    InetClose ($hDownload)

    If GUICtrlRead ($Checkbox200) = $GUI_CHECKED Then
      GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "09", "NotFound"))
      DirMove (@ScriptDir&"\app32", @ScriptDir&"\app32_BAK", 1)
      DirMove (@ScriptDir&"\app64", @ScriptDir&"\app64_BAK", 1)
      DirMove (@ScriptDir&"\vboxadditions", @ScriptDir&"\vboxadditions_BAK", 1)
    Else
      GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "07", "NotFound"))
      DirRemove (@ScriptDir&"\app32", 1)
      DirRemove (@ScriptDir&"\app64", 1)
      DirRemove (@ScriptDir&"\vboxadditions", 1)
    EndIf

    IniWrite ($var1, "version", "key", IniRead (@TempDir&"\update.ini", "version", "key", "NotFound"))
  EndIf

  If $new2 = 1 Then
    DirCreate (@ScriptDir&"\update\")
    GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "10", "NotFound"))

    Local $vboxdown = IniRead ($updateUrl&"download.ini", "download", "key", "NotFound")
    IniWrite ($updateUrl&"download.ini", "download", "key", $vboxdown + 1)

    Local $hDownload = InetGet ($updateUrl&"vbox.7z", @ScriptDir&"\update\vbox.7z", 1, 1)
    Do
      Sleep (250)
    Until InetGetInfo ($hDownload, 2)
    InetClose ($hDownload)

    GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "04", "NotFound"))
    Sleep (2000)

    If FileExists (@ScriptDir&"\update\vbox.7z") Then
      RunWait (@ScriptDir & "\data\tools\7za.exe x -o"& _
               @ScriptDir & "\update\ "& _
               @ScriptDir & "\update\vbox.7z", _
               @ScriptDir, @SW_HIDE)
    EndIf

    GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "11", "NotFound"))

    If GUICtrlRead ($Checkbox200) = $GUI_CHECKED Then
      DirMove (@ScriptDir&"\data\language", @ScriptDir&"\data\language_BAK", 1)
      DirMove (@ScriptDir&"\data\tools", @ScriptDir&"\data\tools_BAK", 1)
      DirMove (@ScriptDir&"\source", @ScriptDir&"\source_BAK", 1)
    Else
      DirRemove (@ScriptDir&"\data\language", 1)
      DirRemove (@ScriptDir&"\data\tools", 1)
      DirRemove (@ScriptDir&"\source", 1)
      FileDelete (@ScriptDir&"\LiesMich.txt")
      FileDelete (@ScriptDir&"\ReadMe.txt")
    EndIf

    Sleep (2000)

    DirMove (@ScriptDir&"\update\Portable-VirtualBox\data\language", @ScriptDir&"\data", 1)
    DirMove (@ScriptDir&"\update\Portable-VirtualBox\data\tools", @ScriptDir&"\data", 1)
    DirMove (@ScriptDir&"\update\Portable-VirtualBox\source", @ScriptDir, 1)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\LiesMich.txt", @ScriptDir, 9)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\ReadMe.txt", @ScriptDir, 9)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\Portable-VirtualBox.exe", @ScriptDir&"\Portable-VirtualBox.exe_NEW", 9)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\UpDate.exe", @ScriptDir&"\update.exe", 9)

    IniWrite ($var1, "starter", "key", IniRead (@TempDir&"\update.ini", "starter", "key", "NotFound"))
  EndIf

  GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "12", "NotFound"))
  Sleep (2000)

  GUIDelete ()
  $update = 0

  If $new2 = 1 Then
    Run (@ScriptDir&"\update.exe")
    Break (1)
    Exit
  EndIf
EndFunc

Func UpdateNo ()
  GUIDelete ()
  $update = 0
EndFunc

Func DownloadFile ()
  ; Download official VirtualBox and extensions
  local $virtualBoxURL = IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "key1", "NotFound")
  local $virtualBoxDL = InetGet ($virtualBoxURL, @ScriptDir&"\VirtualBox.exe", 1, 1)
  local $virtualBoxExtentionsURL = IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "key2", "NotFound")
  local $virtualBoxExtentionsDL = InetGet ($virtualBoxExtentionsURL, @ScriptDir&"\Extension", 1, 1)
  local $dlLabel = IniRead ($var2 & $lng &".ini", "status", "01", "NotFound")
  local $doneLabel = IniRead ($var2 & $lng &".ini", "status", "02", "NotFound")
  Do
    Sleep (250)
    local $bytes = 0
    $bytes = InetGetInfo($virtualBoxDL, 0)
    $total_bytes = InetGetInfo($virtualBoxDL, 1)
    GUICtrlSetData ($Input200, $dlLabel & " " & $virtualBoxURL & @LF & DisplayDownloadStatus($bytes,$total_bytes))
  Until InetGetInfo($virtualBoxDL, 2)
  InetClose($virtualBoxDL)

  Do
    Sleep (250)
    local $bytes = 0
    $bytes = InetGetInfo($virtualBoxExtentionsDL, 0)
	  $total_bytes = InetGetInfo($virtualBoxExtentionsDL, 1)
    GUICtrlSetData ($Input200, $dlLabel & " " & $virtualBoxExtentionsURL & @LF & DisplayDownloadStatus($bytes,$total_bytes))
  Until InetGetInfo ($virtualBoxExtentionsDL, 2)
  InetClose ($virtualBoxExtentionsDL)

  If FileExists (@ScriptDir&"\virtualbox.exe") Then
    GUICtrlSetData ($Input100, @ScriptDir&"\virtualbox.exe")
  EndIf
  GUICtrlSetData ($Input200, @LF & $doneLabel)
  $bytes = 0
EndFunc

Func DisplayDownloadStatus($downloaded_bytes,$total_bytes)
	if $total_bytes > 0 Then
    Return RoundForceDecimalMB($downloaded_bytes) & "MB / " & _
           RoundForceDecimalMB($total_bytes) & "MB (" & _
           Round(100*$downloaded_bytes/$total_bytes) & "%)"
	Else
		Return RoundForceDecimalMB($downloaded_bytes) & "MB"
	EndIf
EndFunc

Func RoundForceDecimalMB($number)
	$rounded = Round($number/1048576, 1)
	If Not StringInStr($rounded, ".") Then
		Return $rounded & ".0"
	Else
		Return $rounded
	EndIf
EndFunc   ;==>RoundForceDecimal