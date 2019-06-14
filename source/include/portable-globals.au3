
Global $version = "6.4.9.0"
Global $cl = 1, $StartLng, $lng
Global $var1 = @ScriptDir&"\data\settings\settings.ini"
Global $var2 = @ScriptDir&"\data\language\"
Global $lng = IniRead ($var1, "language", "key", "NotFound")

Global $updateUrl = IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "update", "NotFound")
Global $new1 = 0, $new2 = 0
Global $debugLevel = 3