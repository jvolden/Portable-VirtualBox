Func SelectLanguage ()
  Local $WS_POPUP

  GUICreate ("Language", 300, 136, -1, -1, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")
  GUICtrlCreateLabel ("Please select your language", 14, 8, 260, 14)
  GUICtrlSetFont (-1, 9, 800, "Arial")
  $StartLng = GUICtrlCreateInput (IniRead ($var1, "language", "key", "NotFound"), 13, 34, 180, 21)
  GUICtrlCreateButton ("Search", 200, 32, 80, 24, 0)
  GUICtrlSetOnEvent (-1, "SRCLanguage")
  GUICtrlCreateButton ("OK", 30, 66, 100, 28, 0)
  GUICtrlSetOnEvent (-1, "OKLanguage")
  GUICtrlCreateButton ("Exit", 162, 66, 100, 28, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")
  GUISetState ()

  While 1
    If $cl = 0 Then ExitLoop
  WEnd

  GUIDelete ()
  IniWrite ($var1, "lang", "key", "1")
  $lng = IniRead ($var1, "language", "key", "NotFound")
EndFunc

Func InstallGUI ()
  Global $Checkbox100, $Checkbox110, $Checkbox130;, $Checkbox120
  Global $Input100, $Input200
  Global $install = 1

  Local $WS_POPUP

  GUICreate (IniRead ($var2 & $lng &".ini", "download", "01", "NotFound"), 542, 380, -1, -1, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "download", "02", "NotFound"), 32, 8, 476, 60)
  GUICtrlSetFont (-1, 9, 800, "Arial")

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "03", "NotFound"), 32, 62, 473, 33)
  GUICtrlSetFont (-1, 14, 400, "Arial")
  GUICtrlSetOnEvent (-1, "DownloadFile")

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "download", "04", "NotFound"), 250, 101, 80, 40)
  GUICtrlSetFont (-1, 10, 800, "Arial")

  $Input100 = GUICtrlCreateInput (IniRead ($var2 & $lng &".ini", "download", "05", "NotFound"), 32, 124, 373, 21)
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "06", "NotFound"), 412, 122, 93, 25, 0)
  GUICtrlSetOnEvent (-1, "SearchFile")

  $Checkbox100 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "07", "NotFound"), 32, 151, 460, 26)
  $Checkbox110 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "08", "NotFound"), 32, 175, 460, 26)
  ;$Checkbox120 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "09", "NotFound"), 32, 199, 460, 26)
  $Checkbox130 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "10", "NotFound"), 32, 223, 460, 26)

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "download", "11", "NotFound"), 32, 247, 436, 26)
  GUICtrlSetFont (-1, 8, 800, 4,"Arial")
  $Input200 = GUICtrlCreateLabel ("", 32, 264, 476, 47)
  GUICtrlSetFont (-1, 8, 400, 0,"Arial")

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "12", "NotFound"), 52, 308, 129, 33, 0)
  GUICtrlSetOnEvent (-1, "UseSettings")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "13", "NotFound"), 194, 308, 149, 33, 0)
  GUICtrlSetFont (-1, 8, 600, "Arial")
  GUICtrlSetOnEvent (-1, "Licence")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "14", "NotFound"), 356, 308, 129, 33, 0)
  GUICtrlSetOnEvent (-1, "ExitExtraction")

  GUISetState ()

  While 1
    If $install = 0 Then ExitLoop
  WEnd
EndFunc

Func Settings ()
  Opt ("GUIOnEventMode", 1)

  Global $Radio1, $Radio2, $Radio3, $Radio4, $Radio5, $Radio6, $Radio7, _
         $Radio8, $Radio9, $Radio10, $Radio11, $Radio12, $Radio13, $Radio14
  Global $Checkbox01, $Checkbox02, $Checkbox03, $Checkbox04, $Checkbox05, _
         $Checkbox06, $Checkbox07, $Checkbox08, $Checkbox09
  Global $Checkbox10, $Checkbox11, $Checkbox12, $Checkbox13, $Checkbox14, _
         $Checkbox15, $Checkbox16, $Checkbox17, $Checkbox18
  Global $Input1, $Input2, $Input3, $Input4, $Input5, $Input6
  Global $HomeRoot, $VMStart, $StartLng

  Local $WS_POPUP

  GUICreate (IniRead ($var2 & $lng &".ini", "settings-label", "01", "NotFound"), _
             580, 318, 193, 125, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")
  GUICtrlCreateTab (0, 0, 577, 296)

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "homeroot-settings", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "homeroot-settings", "02", "NotFound"), 16, 40, 546, 105)

  $Radio1 = GUICtrlCreateRadio ("Radio01", 20, 153, 17, 17)
  If IniRead ($var1, "userhome", "key", "NotFound") = "%CD%\data\.VirtualBox" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio2 = GUICtrlCreateRadio ("Radio02", 20, 185, 17, 17)
  If IniRead ($var1, "userhome", "key", "NotFound") <> "%CD%\data\.VirtualBox" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "homeroot-settings", "03", "NotFound"), 36, 153, 524, 21)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "homeroot-settings", "04", "NotFound"), 36, 185, 180, 21)

  If IniRead ($var1, "userhome", "key", "NotFound") = "%CD%\data\.VirtualBox" Then
    $HomeRoot = GUICtrlCreateInput (IniRead ($var2 & $lng &".ini", "homeroot-settings", "05", "NotFound"), 220, 185, 249, 21)
  Else
    $User_Home = IniRead ($var1, "userhome", "key", "NotFound")
    $HomeRoot  = GUICtrlCreateInput ($User_Home, 220, 185, 249, 21)
  EndIf

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "homeroot-settings", "06", "NotFound"), 476, 185, 81, 21, 0)
  GUICtrlSetOnEvent (-1, "SRCUserHome")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKUserHome")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "startvm-settings", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "startvm-settings", "02", "NotFound"), 16, 40, 546, 105)

  $Radio3 = GUICtrlCreateRadio ("Radio3", 20, 153, 17, 17)
  If IniRead ($var1, "startvm", "key", "NotFound") = false Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio4 = GUICtrlCreateRadio ("Radio4", 20, 185, 17, 17)
  If IniRead ($var1, "startvm", "key", "NotFound") = true Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "startvm-settings", "03", "NotFound"), 36, 153, 524, 21)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "startvm-settings", "04", "NotFound"), 36, 185, 180, 21)

  If IniRead ($var1, "startvm", "key", "NotFound") = false Then
    $VMStart = GUICtrlCreateInput (IniRead ($var2 & $lng &".ini", "startvm-settings", "05", "NotFound"), 220, 185, 249, 21)
  Else
    $Start_VM = IniRead ($var1, "startvm", "key", "NotFound")
    $VMStart  = GUICtrlCreateInput ($Start_VM, 220, 185, 249, 21)
  EndIf

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "startvm-settings", "06", "NotFound"), 476, 185, 81, 21, 0)
  GUICtrlSetOnEvent (-1, "SRCStartVM")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKStartVM")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "hotkeys", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkeys", "02", "NotFound"), 16, 40, 546, 105)

  $Radio5 = GUICtrlCreateRadio ("Radio5", 20, 153, 17, 17)
  If IniRead ($var1, "hotkeys", "key", "NotFound") = 1 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio6 = GUICtrlCreateRadio ("Radio6", 20, 185, 17, 17)
  If IniRead ($var1, "hotkeys", "key", "NotFound") = 0 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkeys", "03", "NotFound"), 36, 153, 524, 21)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkeys", "04", "NotFound"), 36, 185, 524, 21)

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKHotKeys")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "hotkey-settings", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkey-settings", "02", "NotFound"), 16, 40, 546, 60)

  $Radio7 = GUICtrlCreateRadio ("Radio7", 20, 112, 17, 17)
  If IniRead ($var1, "hotkeys", "userkey", "NotFound") = 0 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio8 = GUICtrlCreateRadio ("Radio8", 154, 112, 17, 17)
  If IniRead ($var1, "hotkeys", "userkey", "NotFound") = 1 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkey-settings", "03", "NotFound"), 38, 113, 100, 122)

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "01", "NotFound") &":", 172, 113, 120, 17)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "02", "NotFound") &":", 172, 133, 120, 17)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "03", "NotFound") &":", 172, 153, 120, 17)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "04", "NotFound") &":", 172, 173, 120, 17)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "05", "NotFound") &":", 172, 193, 120, 17)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "06", "NotFound") &":", 172, 213, 120, 17)

  GUICtrlCreateLabel ("CTRL +", 318, 113, 44, 17)
  GUICtrlCreateLabel ("CTRL +", 318, 133, 44, 17)
  GUICtrlCreateLabel ("CTRL +", 318, 153, 44, 17)
  GUICtrlCreateLabel ("CTRL +", 318, 173, 44, 17)
  GUICtrlCreateLabel ("CTRL +", 318, 193, 44, 17)
  GUICtrlCreateLabel ("CTRL +", 318, 213, 44, 17)

  GUICtrlCreateLabel ("ALT +", 395, 113, 44, 17)
  GUICtrlCreateLabel ("ALT +", 395, 133, 44, 17)
  GUICtrlCreateLabel ("ALT +", 395, 153, 44, 17)
  GUICtrlCreateLabel ("ALT +", 395, 173, 44, 17)
  GUICtrlCreateLabel ("ALT +", 395, 193, 44, 17)
  GUICtrlCreateLabel ("ALT +", 395, 213, 44, 17)

  GUICtrlCreateLabel ("SHIFT +", 460, 113, 44, 17)
  GUICtrlCreateLabel ("SHIFT +", 460, 133, 44, 17)
  GUICtrlCreateLabel ("SHIFT +", 460, 153, 44, 17)
  GUICtrlCreateLabel ("SHIFT +", 460, 173, 44, 17)
  GUICtrlCreateLabel ("SHIFT +", 460, 193, 44, 17)
  GUICtrlCreateLabel ("SHIFT +", 460, 213, 44, 17)

  $Checkbox01 = GUICtrlCreateCheckbox ("Checkbox01", 302, 112, 17, 17)
  If IniRead ($var1, "hotkeys", "01", "NotFound") = "^" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox02 = GUICtrlCreateCheckbox ("Checkbox02", 302, 132, 17, 17)
  If IniRead ($var1, "hotkeys", "02", "NotFound") = "^" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox03 = GUICtrlCreateCheckbox ("Checkbox03", 302, 152, 17, 17)
  If IniRead ($var1, "hotkeys", "03", "NotFound") = "^" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox04 = GUICtrlCreateCheckbox ("Checkbox04", 302, 172, 17, 17)
  If IniRead ($var1, "hotkeys", "04", "NotFound") = "^" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox05 = GUICtrlCreateCheckbox ("Checkbox05", 302, 192, 17, 17)
  If IniRead ($var1, "hotkeys", "05", "NotFound") = "^" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox06 = GUICtrlCreateCheckbox ("Checkbox06", 302, 212, 17, 17)
  If IniRead ($var1, "hotkeys", "06", "NotFound") = "^" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Checkbox07 = GUICtrlCreateCheckbox ("Checkbox07", 378, 112, 17, 17)
  If IniRead ($var1, "hotkeys", "07", "NotFound") = "!" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox08 = GUICtrlCreateCheckbox ("Checkbox08", 378, 132, 17, 17)
  If IniRead ($var1, "hotkeys", "08", "NotFound") = "!" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox09 = GUICtrlCreateCheckbox ("Checkbox09", 378, 152, 17, 17)
  If IniRead ($var1, "hotkeys", "09", "NotFound") = "!" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox10 = GUICtrlCreateCheckbox ("Checkbox10", 378, 172, 17, 17)
  If IniRead ($var1, "hotkeys", "10", "NotFound") = "!" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox11 = GUICtrlCreateCheckbox ("Checkbox11", 378, 192, 17, 17)
  If IniRead ($var1, "hotkeys", "11", "NotFound") = "!" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox12 = GUICtrlCreateCheckbox ("Checkbox12", 378, 212, 17, 17)
  If IniRead ($var1, "hotkeys", "12", "NotFound") = "!" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Checkbox13 = GUICtrlCreateCheckbox ("Checkbox13", 444, 112, 17, 17)
  If IniRead ($var1, "hotkeys", "13", "NotFound") = "+" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox14 = GUICtrlCreateCheckbox ("Checkbox14", 444, 132, 17, 17)
  If IniRead ($var1, "hotkeys", "14", "NotFound") = "+" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox15 = GUICtrlCreateCheckbox ("Checkbox15", 444, 152, 17, 17)
  If IniRead ($var1, "hotkeys", "15", "NotFound") = "+" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox16 = GUICtrlCreateCheckbox ("Checkbox16", 444, 172, 17, 17)
  If IniRead ($var1, "hotkeys", "16", "NotFound") = "+" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox17 = GUICtrlCreateCheckbox ("Checkbox17", 444, 192, 17, 17)
  If IniRead ($var1, "hotkeys", "17", "NotFound") = "+" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf
  $Checkbox18 = GUICtrlCreateCheckbox ("Checkbox18", 444, 212, 17, 17)
  If IniRead ($var1, "hotkeys", "18", "NotFound") = "+" Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Input1 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "19", "NotFound"), 524, 111, 24, 21)
  $Input2 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "20", "NotFound"), 524, 131, 24, 21)
  $Input3 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "21", "NotFound"), 524, 151, 24, 21)
  $Input4 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "22", "NotFound"), 524, 171, 24, 21)
  $Input5 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "23", "NotFound"), 524, 191, 24, 21)
  $Input6 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "24", "NotFound"), 524, 211, 24, 21)

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKHotKeysSet")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "usb", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "usb", "02", "NotFound"), 16, 40, 546, 105)

  $Radio9 = GUICtrlCreateRadio ("$Radio9", 20, 153, 17, 17)
  If IniRead ($var1, "usb", "key", "NotFound") = 0 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio10 = GUICtrlCreateRadio ("$Radio10", 20, 185, 17, 17)
  If IniRead ($var1, "usb", "key", "NotFound") = 1 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "usb", "03", "NotFound"), 40, 153, 524, 21)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "usb", "04", "NotFound"), 40, 185, 524, 21)

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKUSB")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "net", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "net", "02", "NotFound"), 16, 40, 546, 105)

  $Radio11 = GUICtrlCreateRadio ("$Radio11", 20, 153, 17, 17)
  If IniRead ($var1, "net", "key", "NotFound") = 0 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio12 = GUICtrlCreateRadio ("$Radio12", 20, 185, 17, 17)
  If IniRead ($var1, "net", "key", "NotFound") = 1 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "net", "03", "NotFound"), 40, 153, 524, 21)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "net", "04", "NotFound"), 40, 185, 524, 21)

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKNet")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "language-settings", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "language-settings", "02", "NotFound"), 16, 40, 546, 105)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "language-settings", "03", "NotFound"), 26, 185, 180, 21)

  $StartLng = GUICtrlCreateInput (IniRead ($var1, "language", "key", "NotFound"), 210, 185, 259, 21)

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "language-settings", "04", "NotFound"), 476, 185, 81, 21, 0)
  GUICtrlSetOnEvent (-1, "SRCLanguage")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKLanguage")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "update", "01", "NotFound"))
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "update", "02", "NotFound"), 16, 40, 546, 105)

  $Radio13 = GUICtrlCreateRadio ("$Radio13", 20, 153, 17, 17)
  If IniRead ($var1, "update", "key", "NotFound") = 0 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  $Radio14 = GUICtrlCreateRadio ("$Radio14", 20, 185, 17, 17)
  If IniRead ($var1, "update", "key", "NotFound") = 1 Then
    GUICtrlSetState (-1, $GUI_CHECKED)
  EndIf

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "update", "03", "NotFound"), 40, 153, 524, 21)
  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "update", "04", "NotFound"), 40, 185, 524, 21)

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "OKUpdate")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "about", "01", "NotFound"))
  GUICtrlCreateLabel (". : Portable-VirtualBox Launcher v"& $version &" : .", 100, 40, 448, 26)
  GUICtrlSetFont (-1, 14, 800, 4, "Arial")
  GUICtrlCreateLabel("Download and Support: http://www.win-lite.de/wbb/index.php?page=Board&&&boardID=153", 40, 70, 500, 20)
  GUICtrlSetFont (-1, 8, 800, 0, "Arial")
  GUICtrlCreateLabel ("VirtualBox is a family of powerful x86 virtualization products for enterprise as well as home use. Not only is VirtualBox an extremely feature rich, high performance product for enterprise customers, it is also the only professional solution that is freely available as Open Source Software under the terms of the GNU General Public License (GPL).", 16, 94, 546, 55)
  GUICtrlSetFont (-1, 8, 400, 0, "Arial")
  GUICtrlCreateLabel ("Download and Support: http://www.virtualbox.org", 88, 133, 300, 14)
  GUICtrlSetFont (-1, 8, 800, 0, "Arial")
  GUICtrlCreateLabel ("Presently, VirtualBox runs on Windows, Linux, Macintosh and OpenSolaris hosts and supports a large number of guest operating systems including but not limited to Windows (NT 4.0, 2000, XP, Server 2003, Vista), DOS/Windows 3.x, Linux (2.4 and 2.6), and OpenBSD.", 16, 149, 546, 40)
  GUICtrlSetFont (-1, 8, 400, 0, "Arial")
  GUICtrlCreateLabel ("VirtualBox is being actively developed with frequent releases and has an ever growing list of features, supported guest operating systems and platforms it runs on. VirtualBox is a community effort backed by a dedicated company: everyone is encouraged to contribute while Sun ensures the product always meets professional quality criteria.", 16, 192, 546, 40)
  GUICtrlSetFont (-1, 8, 400, 0, "Arial")

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 236, 240, 129, 25, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUISetState ()
EndFunc

Func ShowWindows_VM ()
  Opt ("WinTitleMatchMode", 2)
  WinSetState ("] - Oracle VM VirtualBox", "", BitAND (@SW_SHOW, @SW_RESTORE))
EndFunc

Func HideWindows_VM ()
  Opt ("WinTitleMatchMode", 2)
  WinSetState ("] - Oracle VM VirtualBox", "", @SW_HIDE)
EndFunc

Func ShowWindows ()
  Opt ("WinTitleMatchMode", 3)
  WinSetState ("Oracle VM VirtualBox Manager", "", BitAND (@SW_SHOW, @SW_RESTORE))
EndFunc

Func HideWindows ()
  Opt ("WinTitleMatchMode", 3)
  WinSetState ("Oracle VM VirtualBox Manager", "", @SW_HIDE)
EndFunc

Func SRCUserHome ()
  Local $PathHR = FileSelectFolder (IniRead ($var2 & $lng &".ini", "srcuserhome", "01", "NotFound"), "", 1+4)
  If NOT @error Then
    GUICtrlSetState ($Radio2, $GUI_CHECKED)
    GUICtrlSetData ($HomeRoot, $PathHR)
  EndIf
EndFunc

Func OKUserHome ()
  If GUICtrlRead ($Radio1) = $GUI_CHECKED Then
    IniWrite ($var1, "userhome", "key", "%CD%\data\.VirtualBox")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    If GUICtrlRead ($HomeRoot) = IniRead ($var2 & $lng &".ini", "okuserhome", "01", "NotFound") Then
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "okuserhome", "02", "NotFound"))
    Else
      IniWrite (@ScriptDir&"\data\settings\settings.ini", "userhome", "key", GUICtrlRead ($HomeRoot))
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
    EndIf
  EndIf
EndFunc

Func SRCStartVM ()
  Local $PathVM, $VM_String, $String, $VDI, $VM_Start
  Local $Start_VM = IniRead ($var1, "startvm", "key", "NotFound")
  If IniRead ($var1, "startvm", "key", "NotFound") Then
    If FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\") Then
      $PathVM = FileOpenDialog (IniRead ($var2 & $lng &".ini", "srcstartvm", "01", "NotFound"), $Start_VM&"\.VirtualBox\HardDisks", "VirtualBox VM (*.vdi)", 1+2)
    EndIf
  Else
    If FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\") Then
      $PathVM = FileOpenDialog (IniRead ($var2 & $lng &".ini", "srcstartvm", "01", "NotFound"), @ScriptDir&"\data\.VirtualBox\HardDisks", "VirtualBox VM (*.vdi)", 1+2)
    EndIf
  EndIf
  If NOT @error Then
    $VM_String = StringSplit ($PathVM, "\")
    $String = ""
    For $VDI In $VM_String
      $String = $VDI
    Next
    $VM_Start = StringSplit ($String, ".")
    GUICtrlSetState ($Radio4, $GUI_CHECKED)
    GUICtrlSetData ($VMStart, $VM_Start[1])
  EndIf
EndFunc

Func OKStartVM ()
  If GUICtrlRead ($Radio3) = $GUI_CHECKED Then
    IniWrite ($var1, "startvm", "key", "")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    If GUICtrlRead ($VMStart) = IniRead ($var2 & $lng &".ini", "okstartvm", "01", "NotFound") Then
      MsgBox (0, IniRead (@ScriptDir&"\data\language\"& $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "okstartvm", "02", "NotFound"))
    Else
      IniWrite ($var1, "startvm", "key", GUICtrlRead ($VMStart))
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
    EndIf
  EndIf
EndFunc

Func OKHotKeys ()
  If GUICtrlRead ($Radio5) = $GUI_CHECKED Then
    IniWrite ($var1, "hotkeys", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "hotkeys", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc


Func OKUSB ()
  If GUICtrlRead ($Radio9) = $GUI_CHECKED Then
    IniWrite ($var1, "usb", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "usb", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func OKNet ()
  If GUICtrlRead ($Radio11) = $GUI_CHECKED Then
    IniWrite ($var1, "net", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "net", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func SRCLanguage ()
  Local $Language_String, $String, $Language, $Language_Start
  Local $PathLanguage = FileOpenDialog (IniRead ($var2 & $lng &".ini", "srcslanguage", "01", "NotFound"), _
                                        @ScriptDir&"\data\language", "(*.ini)", 1+2)
  If NOT @error Then
    $Language_String = StringSplit ($PathLanguage, "\")
    $String = ""
    For $Language In $Language_String
      $String  = $Language
    Next
    $Language_Start = StringSplit ($String, ".")
    GUICtrlSetData ($StartLng, $Language_Start[1])
  EndIf
EndFunc

Func OKLanguage ()
  If GUICtrlRead ($StartLng) = "" Then
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "oklanguage", "01", "NotFound"))
  Else
    IniWrite ($var1, "language", "key", GUICtrlRead ($StartLng))
	If IniRead ($var1, "lang", "key", "NotFound") = 1 Then
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
                 IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
	EndIf
	$cl = 0
  EndIf
EndFunc

Func OKUpdate ()
  If GUICtrlRead ($Radio13) = $GUI_CHECKED Then
    IniWrite ($var1, "update", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "update", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func ExitGUI ()
  GUIDelete ()
  $cl = 0
EndFunc

Func ExitScript ()
  Opt ("WinTitleMatchMode", 2)
  WinClose ("] - Oracle VM VirtualBox", "")
  WinWaitClose ("] - Oracle VM VirtualBox", "")
  WinClose ("Oracle VM VirtualBox", "")
  Break (1)
EndFunc

Func SearchFile ()
  Local $FilePath = FileOpenDialog (IniRead ($var2 & $lng &".ini", "status", "03", "NotFound"), @ScriptDir, "(*.exe)", 1+2)
  If NOT @error Then
    GUICtrlSetData ($Input100, $FilePath)
  EndIf
EndFunc

Func ExitExtraction ()
  GUIDelete ()
  $install = 0

  Break (1)
  Exit
EndFunc
