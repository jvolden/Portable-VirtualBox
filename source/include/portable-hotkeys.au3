Func LoadHotkeysInTray()
  If IniRead ($var1, "hotkeys", "key", "NotFound") = 1 Then
    HotKeySet (IniRead ($var1, "hotkeys", "01", "NotFound") & _
               IniRead ($var1, "hotkeys", "07", "NotFound") & _
               IniRead ($var1, "hotkeys", "13", "NotFound") & _
               IniRead ($var1, "hotkeys", "19", "NotFound"), "ShowWindows_VM")
    HotKeySet (IniRead ($var1, "hotkeys", "02", "NotFound") & _
               IniRead ($var1, "hotkeys", "08", "NotFound") & _
               IniRead ($var1, "hotkeys", "14", "NotFound") & _
               IniRead ($var1, "hotkeys", "20", "NotFound"), "HideWindows_VM")
    HotKeySet (IniRead ($var1, "hotkeys", "03", "NotFound") & _
               IniRead ($var1, "hotkeys", "09", "NotFound") & _
               IniRead ($var1, "hotkeys", "15", "NotFound") & _
               IniRead ($var1, "hotkeys", "21", "NotFound"), "ShowWindows")
    HotKeySet (IniRead ($var1, "hotkeys", "04", "NotFound") & _
               IniRead ($var1, "hotkeys", "10", "NotFound") & _
               IniRead ($var1, "hotkeys", "16", "NotFound") & _
               IniRead ($var1, "hotkeys", "22", "NotFound"), "HideWindows")
    HotKeySet (IniRead ($var1, "hotkeys", "05", "NotFound") & _
               IniRead ($var1, "hotkeys", "11", "NotFound") & _
               IniRead ($var1, "hotkeys", "17", "NotFound") & _
               IniRead ($var1, "hotkeys", "23", "NotFound"), "Settings")
    HotKeySet (IniRead ($var1, "hotkeys", "06", "NotFound") & _
               IniRead ($var1, "hotkeys", "12", "NotFound") & _
               IniRead ($var1, "hotkeys", "18", "NotFound") & _
               IniRead ($var1, "hotkeys", "24", "NotFound"), "ExitScript")

    Local $ctrl1, $ctrl2, $ctrl3, $ctrl4, $ctrl5, $ctrl6
    Local $alt1, $alt2, $alt3, $alt4, $alt5, $alt6
    Local $shift1, $shift2, $shift3, $shift4, $shift5, $shift6
    Local $plus01, $plus02, $plus03, $plus04, $plus05, $plus06, $plus07, _
          $plus08, $plus09, $plus10, $plus11, $plus12, $plus13, $plus14, _
          $plus15, $plus16, $plus17, $plus18

    If IniRead ($var1, "hotkeys", "01", "NotFound") = "^" Then
      $ctrl1  = "CTRL"
      $plus01 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "02", "NotFound") = "^" Then
      $ctrl2  = "CTRL"
      $plus02 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "03", "NotFound") = "^" Then
      $ctrl3  = "CTRL"
      $plus03 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "04", "NotFound") = "^" Then
      $ctrl4  = "CTRL"
      $plus04 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "05", "NotFound") = "^" Then
      $ctrl5  = "CTRL"
      $plus05 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "06", "NotFound") = "^" Then
      $ctrl6  = "CTRL"
      $plus06 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "07", "NotFound") = "!" Then
      $alt1   = "ALT"
      $plus07 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "08", "NotFound") = "!" Then
      $alt2   = "ALT"
      $plus08 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "09", "NotFound") = "!" Then
      $alt3   = "ALT"
      $plus09 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "10", "NotFound") = "!" Then
      $alt4   = "ALT"
      $plus10 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "11", "NotFound") = "!" Then
      $alt5   = "ALT"
      $plus11 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "12", "NotFound") = "!" Then
      $alt6   = "ALT"
      $plus12 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "13", "NotFound") = "+" Then
      $shift1 = "SHIFT"
      $plus13 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "14", "NotFound") = "+" Then
      $shift2 = "SHIFT"
      $plus14 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "15", "NotFound") = "+" Then
      $shift3 = "SHIFT"
      $plus15 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "16", "NotFound") = "+" Then
      $shift4 = "SHIFT"
      $plus16 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "17", "NotFound") = "+" Then
      $shift5 = "SHIFT"
      $plus17 = "+"
    EndIf
    If IniRead ($var1, "hotkeys", "18", "NotFound") = "+" Then
      $shift6 = "SHIFT"
      $plus18 = "+"
    EndIf

    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "01", "NotFound") _
                    &" (" & $ctrl1 & $plus01 & $alt1 & $plus07 & $shift1 & $plus13 _
                    & IniRead ($var1, "hotkeys", "19", "NotFound") & ")")
    TrayItemSetOnEvent (-1, "ShowWindows_VM")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "02", "NotFound") _
                    &" (" & $ctrl2 & $plus02 & $alt2 & $plus08 & $shift2 & $plus14 _
                    & IniRead ($var1, "hotkeys", "20", "NotFound") & ")")
    TrayItemSetOnEvent (-1, "HideWindows_VM")
    TrayCreateItem ("")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "03", "NotFound") _
                    &" (" & $ctrl3 & $plus03 & $alt3 & $plus09 & $shift3 & $plus15 _
                    & IniRead ($var1, "hotkeys", "21", "NotFound") & ")")
    TrayItemSetOnEvent (-1, "ShowWindows")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "04", "NotFound") _
                    &" (" & $ctrl4 & $plus04 & $alt4 & $plus10 & $shift4 & $plus16 _
                    & IniRead ($var1, "hotkeys", "22", "NotFound") & ")")
    TrayItemSetOnEvent (-1, "HideWindows")
    TrayCreateItem ("")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "05", "NotFound") _
                    &" (" & $ctrl5 & $plus05 & $alt5 & $plus11 & $shift5 & $plus17 _
                    & IniRead ($var1, "hotkeys", "23", "NotFound") & ")")
    TrayItemSetOnEvent (-1, "Settings")
    TrayCreateItem ("")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "06", "NotFound") _
                    &" (" & $ctrl6 & $plus06 & $alt6 & $plus12 & $shift6 & $plus18 _
                    & IniRead ($var1, "hotkeys", "24", "NotFound") & ")")
    TrayItemSetOnEvent (-1, "ExitScript")
    TraySetState ()
    TraySetToolTip (IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"))
    TrayTip("", IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"), 5)
  Else
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "01", "NotFound"))
    TrayItemSetOnEvent (-1, "ShowWindows_VM")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "02", "NotFound"))
    TrayItemSetOnEvent (-1, "HideWindows_VM")
    TrayCreateItem ("")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "03", "NotFound"))
    TrayItemSetOnEvent (-1, "ShowWindows")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "04", "NotFound"))
    TrayItemSetOnEvent (-1, "HideWindows")
    TrayCreateItem ("")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "05", "NotFound"))
    TrayItemSetOnEvent (-1, "Settings")
    TrayCreateItem ("")
    TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "06", "NotFound"))
    TrayItemSetOnEvent (-1, "ExitScript")
    TraySetState ()
    TraySetToolTip (IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"))
    TrayTip("", IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"), 5)
  EndIf

EndFunc

Func OKHotKeysSet ()
  If GUICtrlRead ($Radio7) = $GUI_CHECKED Then
    IniWrite ($var1, "hotkeys", "userkey", "0")
    IniWrite ($var1, "hotkeys", "01", "^")
    IniWrite ($var1, "hotkeys", "02", "^")
    IniWrite ($var1, "hotkeys", "03", "^")
    IniWrite ($var1, "hotkeys", "04", "^")
    IniWrite ($var1, "hotkeys", "05", "^")
    IniWrite ($var1, "hotkeys", "06", "^")

    IniWrite ($var1, "hotkeys", "07", "")
    IniWrite ($var1, "hotkeys", "08", "")
    IniWrite ($var1, "hotkeys", "09", "")
    IniWrite ($var1, "hotkeys", "10", "")
    IniWrite ($var1, "hotkeys", "11", "")
    IniWrite ($var1, "hotkeys", "12", "")

    IniWrite ($var1, "hotkeys", "13", "")
    IniWrite ($var1, "hotkeys", "14", "")
    IniWrite ($var1, "hotkeys", "15", "")
    IniWrite ($var1, "hotkeys", "16", "")
    IniWrite ($var1, "hotkeys", "17", "")
    IniWrite ($var1, "hotkeys", "18", "")

    IniWrite ($var1, "hotkeys", "19", "1")
    IniWrite ($var1, "hotkeys", "20", "2")
    IniWrite ($var1, "hotkeys", "21", "3")
    IniWrite ($var1, "hotkeys", "22", "4")
    IniWrite ($var1, "hotkeys", "23", "5")
    IniWrite ($var1, "hotkeys", "24", "6")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
               IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    If GUICtrlRead ($Input1) = false OR GUICtrlRead ($Input2) = false OR _
       GUICtrlRead ($Input3) = false OR GUICtrlRead ($Input4) = false OR _
       GUICtrlRead ($Input5) = false OR GUICtrlRead ($Input6) = false Then
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), _
                 IniRead ($var2 & $lng &".ini", "okhotkeysset", "01", "NotFound"))
    Else
      IniWrite ($var1, "hotkeys", "userkey", "1")
      If GUICtrlRead ($CheckBox01) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "01", "^")
      Else
        IniWrite ($var1, "hotkeys", "01", "")
      EndIf
      If GUICtrlRead ($CheckBox02) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "02", "^")
      Else
        IniWrite ($var1, "hotkeys", "02", "")
      EndIf
      If GUICtrlRead ($CheckBox03) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "03", "^")
      Else
        IniWrite ($var1, "hotkeys", "03", "")
      EndIf
      If GUICtrlRead ($CheckBox04) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "04", "^")
      Else
        IniWrite ($var1, "hotkeys", "04", "")
      EndIf
      If GUICtrlRead ($CheckBox05) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "05", "^")
      Else
        IniWrite ($var1, "hotkeys", "05", "")
      EndIf
      If GUICtrlRead ($CheckBox06) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "06", "^")
      Else
        IniWrite ($var1, "hotkeys", "06", "")
      EndIf

      If GUICtrlRead ($CheckBox07) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "07", "!")
      Else
        IniWrite ($var1, "hotkeys", "07", "")
      EndIf
      If GUICtrlRead ($CheckBox08) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "08", "!")
      Else
        IniWrite ($var1, "hotkeys", "08", "")
      EndIf
      If GUICtrlRead ($CheckBox09) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "09", "!")
      Else
        IniWrite ($var1, "hotkeys", "09", "")
      EndIf
      If GUICtrlRead ($CheckBox10) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "10", "!")
      Else
        IniWrite ($var1, "hotkeys", "10", "")
      EndIf
      If GUICtrlRead ($CheckBox11) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "11", "!")
      Else
        IniWrite ($var1, "hotkeys", "11", "")
      EndIf
      If GUICtrlRead ($CheckBox12) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "12", "!")
      Else
        IniWrite ($var1, "hotkeys", "12", "")
      EndIf

      If GUICtrlRead ($CheckBox13) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "13", "+")
      Else
        IniWrite ($var1, "hotkeys", "13", "")
      EndIf
      If GUICtrlRead ($CheckBox14) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "14", "+")
      Else
        IniWrite ($var1, "hotkeys", "14", "")
      EndIf
      If GUICtrlRead ($CheckBox15) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "15", "+")
      Else
        IniWrite ($var1, "hotkeys", "15", "")
      EndIf
      If GUICtrlRead ($CheckBox16) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "16", "+")
      Else
        IniWrite ($var1, "hotkeys", "16", "")
      EndIf
      If GUICtrlRead ($CheckBox17) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "17", "+")
      Else
        IniWrite ($var1, "hotkeys", "17", "")
      EndIf
      If GUICtrlRead ($CheckBox18) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "18", "+")
      Else
        IniWrite ($var1, "hotkeys", "18", "")
      EndIf

      IniWrite ($var1, "hotkeys", "19", GUICtrlRead ($Input1))
      IniWrite ($var1, "hotkeys", "20", GUICtrlRead ($Input2))
      IniWrite ($var1, "hotkeys", "21", GUICtrlRead ($Input3))
      IniWrite ($var1, "hotkeys", "22", GUICtrlRead ($Input4))
      IniWrite ($var1, "hotkeys", "23", GUICtrlRead ($Input5))
      IniWrite ($var1, "hotkeys", "24", GUICtrlRead ($Input6))
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), _
                 IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
    EndIf
  EndIf
EndFunc