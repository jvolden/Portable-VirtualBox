
Func CreateIni ()
    DirCreate (@ScriptDir&"\data\settings")
    IniWrite ($var1, "hotkeys", "key", "1")
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
    IniWrite ($var1, "usb", "key", "0")
    IniWrite ($var1, "net", "key", "0")
    IniWrite ($var1, "language", "key", "english")
    IniWrite ($var1, "userhome", "key", "\data\.VirtualBox")
    IniWrite ($var1, "startvm", "key", "")
    IniWrite ($var1, "update", "key", "1")
    IniWrite ($var1, "lang", "key", "0")
    IniWrite ($var1, "version", "key", "")
    IniWrite ($var1, "starter", "key", "")
EndFunc