Func MSVSDrivers($action)
  If Not IsAdmin() Then Return
  If $action = 'load' Then
    If @OSArch = "x86" Then
        If NOT FileExists (@SystemDir&"\msvcp71.dll") OR _
        NOT FileExists (@SystemDir&"\msvcr71.dll") OR _
        NOT FileExists (@SystemDir&"\msvcrt.dll") Then
        FileCopy (@ScriptDir&"\app32\msvcp71.dll", @SystemDir, 9)
        FileCopy (@ScriptDir&"\app32\msvcr71.dll", @SystemDir, 9)
        FileCopy (@ScriptDir&"\app32\msvcrt.dll", @SystemDir, 9)
        Global $msv = 1
        Else
        Global $msv = 0
        EndIf
    EndIf
    If @OSArch = "x64" Then
        If NOT FileExists (@SystemDir&"\msvcp100.dll") OR _
        NOT FileExists (@SystemDir&"\msvcr100.dll") Then
        FileCopy (@ScriptDir&"\app64\msvcp100.dll", @SystemDir, 9)
        FileCopy (@ScriptDir&"\app64\msvcr100.dll", @SystemDir, 9)
        Global $msv = 2
        Else
        ;Do hash file checks here.
        Global $msv = 0
        EndIf
    EndIf
  ElseIf $action = 'unload' Then
    If $msv = 1 Then
      FileDelete (@SystemDir&"\msvcp71.dll")
      FileDelete (@SystemDir&"\msvcr71.dll")
      FileDelete (@SystemDir&"\msvcrt.dll")
    EndIf

    If $msv = 2 Then
      FileDelete (@SystemDir&"\msvcp100.dll")
      FileDelete (@SystemDir&"\msvcr100.dll")
    EndIf
  EndIf
EndFunc

Func Services($action)
  local $DRV, $USB, $MON, $ADP, $NET
  If Not IsAdmin() Then Return
  If $action='load' Then
    ; Register Services
    RunWait ($arch&"\VBoxSVC.exe /reregserver", @ScriptDir, @SW_HIDE)
    RunWait (@SystemDir&"\regsvr32.exe /S "& $arch &"\VBoxC.dll", @ScriptDir, @SW_HIDE)

    ; Check for VBoxDRV.
    ; Create service using portable files if required.
    local $VBoxDRV="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxDRV"
    If RegRead ($VBoxDRV, "DisplayName") <> "VirtualBox Service" Then
      _Debug($VBoxDRV & " not in registry. Running our portable service.", 3)
      local $command="cmd /c sc create VBoxDRV binpath= " & _
                     """%CD%\"& $arch &"\drivers\VBoxDrv\VBoxDrv.sys""" & _
                     " type= kernel start= auto error= normal displayname= PortableVBoxDRV"
      RunWait ($command, @ScriptDir, @SW_HIDE)
      $DRV = 1
    Else
      _Debug($VBoxDRV & " in registry. Skipping our portable service.", 3)
      $DRV = 0
    EndIf

    ; Check for VBoxUSBMon
    ; Create service using portable files if required.
    local $VBoxUSBMon = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxUSBMon"
    If RegRead ($VBoxUSBMon, "DisplayName") <> "VirtualBox USB Monitor Driver" Then
      _Debug($VBoxUSBMon & " not in registry. Running our portable service.", 3)
      local $command = "cmd /c sc create VBoxUSBMon binpath= " & _
                       """%CD%\"& $arch & "\drivers\USB\filter\VBoxUSBMon.sys""" & _
                       " type= kernel start= auto error= normal displayname= PortableVBoxUSBMon"
      RunWait ($command , @ScriptDir, @SW_HIDE)
      $MON = 1
    Else
      _Debug($VBoxUSBMon & " in registry. Skipping our portable service.", 3)
      $MON = 0
    EndIf

    ; Check for VBoxUSB.sys
    ; Create service using portable files if required.
    If IniRead ($var1, "usb", "key", "NotFound") = 1 Then
      If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxUSB", "DisplayName") <> "VirtualBox USB" Then
        If @OSArch = "x86" Then
          RunWait (@ScriptDir &"\data\tools\devcon_x86.exe install .\"& $arch & _
                   "\drivers\USB\device\VBoxUSB.inf ""USB\VID_80EE&PID_CAFE""", _
                   @ScriptDir, @SW_HIDE)
        EndIf
        If @OSArch = "x64" Then
          RunWait (@ScriptDir &"\data\tools\devcon_x64.exe install .\"& $arch & _
                   "\drivers\USB\device\VBoxUSB.inf ""USB\VID_80EE&PID_CAFE""", _
                   @ScriptDir, @SW_HIDE)
        EndIf
        FileCopy (@ScriptDir&"\"& $arch &"\drivers\USB\device\VBoxUSB.sys", @SystemDir&"\drivers", 9)
        $USB = 1
      Else
        $USB = 0
      EndIf
    Else
      $USB = 0
    EndIf

    If IniRead ($var1, "net", "key", "NotFound") = 1 Then
      local $VBoxNetAdp = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxNetAdp"
      If RegRead ($VBoxNetAdp, "DisplayName") <> "VirtualBox Host-Only Network Adapter" Then
        If @OSArch = "x86" Then
          RunWait (@ScriptDir & "\data\tools\devcon_x86.exe install .\" & $arch & _
                   "\drivers\network\netadp\VBoxNetAdp.inf ""sun_VBoxNetAdp""", _
                   @ScriptDir, @SW_HIDE)
        EndIf
        If @OSArch = "x64" Then
          RunWait (@ScriptDir & "\data\tools\devcon_x64.exe install .\" & $arch & _
                   "\drivers\network\netadp\VBoxNetAdp.inf ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
        EndIf
        FileCopy (@ScriptDir&"\"& $arch &"\drivers\network\netadp\VBoxNetAdp.sys", @SystemDir&"\drivers", 9)
        $ADP = 1
      Else
        $ADP = 0
      EndIf
    Else
      $ADP = 0
    EndIf

    If IniRead ($var1, "net", "key", "NotFound") = 1 Then
      If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxNetFlt", "DisplayName") <> "VBoxNetFlt Service" Then
        If @OSArch = "x86" Then
          RunWait (@ScriptDir&"\data\tools\snetcfg_x86.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
          RunWait (@ScriptDir&"\data\tools\snetcfg_x86.exe -v -l .\" & $arch & _
                   "\drivers\network\netflt\VBoxNetFlt.inf -m .\" & $arch & _
                   "\drivers\network\netflt\VBoxNetFltM.inf -c s -i sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
        EndIf
        If @OSArch = "x64" Then
          RunWait (@ScriptDir&"\data\tools\snetcfg_x64.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
          RunWait (@ScriptDir&"\data\tools\snetcfg_x64.exe -v -l .\"& $arch & _
                   "\drivers\network\netflt\VBoxNetFlt.inf -m .\"& $arch & _
                   "\drivers\network\netflt\VBoxNetFltM.inf -c s -i sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
        EndIf
        FileCopy (@ScriptDir&"\"& $arch &"\drivers\network\netflt\VBoxNetFltNobj.dll", @SystemDir, 9)
        FileCopy (@ScriptDir&"\"& $arch &"\drivers\network\netflt\VBoxNetFlt.sys", @SystemDir&"\drivers", 9)
        RunWait (@SystemDir&"\regsvr32.exe /S "& @SystemDir &"\VBoxNetFltNobj.dll", @ScriptDir, @SW_HIDE)
        $NET = 1
      Else
        $NET = 0
      EndIf
    Else
      $NET = 0
    EndIf

  ; If our services were installed, start them.
  ElseIf $action='start' Then 
    If $DRV = 1 Then
      RunWait ("sc start VBoxDRV", @ScriptDir, @SW_HIDE)
    EndIf
    If $USB = 1 Then
      RunWait ("sc start VBoxUSB", @ScriptDir, @SW_HIDE)
    EndIf
    If $MON = 1 Then
      RunWait ("sc start VBoxUSBMon", @ScriptDir, @SW_HIDE)
    EndIf
    If $ADP = 1 Then
      RunWait ("sc start VBoxNetAdp", @ScriptDir, @SW_HIDE)
    EndIf
    If $NET = 1 Then
      RunWait ("sc start VBoxNetFlt", @ScriptDir, @SW_HIDE)
    EndIf
  
  ; Stop all services we installed/started.
  ElseIf $action='stop' Then
    RunWait ($arch&"\VBoxSVC.exe /unregserver", @ScriptDir, @SW_HIDE)
    RunWait (@SystemDir&"\regsvr32.exe /S /U "& $arch &"\VBoxC.dll", @ScriptDir, @SW_HIDE)
    If $DRV = 1 Then
      RunWait ("sc stop VBoxDRV", @ScriptDir, @SW_HIDE)
    EndIf
    If $MON = 1 Then
      RunWait ("sc stop VBoxUSBMon", @ScriptDir, @SW_HIDE)
    EndIf
    If $ADP = 1 Then
      RunWait ("sc stop VBoxNetAdp", @ScriptDir, @SW_HIDE)
      If @OSArch = "x86" Then
        RunWait (@ScriptDir &"\data\tools\devcon_x86.exe remove ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
      EndIf
      If @OSArch = "x64" Then
        RunWait (@ScriptDir &"\data\tools\devcon_x64.exe remove ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
      EndIf
      FileDelete (@SystemDir&"\drivers\VBoxNetAdp.sys")
    EndIf
    If $USB = 1 Then
      RunWait ("sc stop VBoxUSB", @ScriptDir, @SW_HIDE)
      If @OSArch = "x86" Then
        RunWait (@ScriptDir &"\data\tools\devcon_x86.exe remove ""USB\VID_80EE&PID_CAFE""", @ScriptDir, @SW_HIDE)
      EndIf
      If @OSArch = "x64" Then
        RunWait (@ScriptDir &"\data\tools\devcon_x64.exe remove ""USB\VID_80EE&PID_CAFE""", @ScriptDir, @SW_HIDE)
      EndIf
      FileDelete (@SystemDir&"\drivers\VBoxUSB.sys")
    EndIf
    If $NET = 1 Then
      RunWait ("sc stop VBoxNetFlt", @ScriptDir, @SW_HIDE)
      If @OSArch = "x86" Then
        RunWait (@ScriptDir&"\data\tools\snetcfg_x86.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
      EndIf
      If @OSArch = "x64" Then
        RunWait (@ScriptDir&"\data\tools\snetcfg_x64.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
      EndIf
      RunWait (@SystemDir&"\regsvr32.exe /S /U "&@SystemDir&"\VBoxNetFltNobj.dll", @ScriptDir, @SW_HIDE)
      ;RunWait ("sc delete VBoxNetFlt", @ScriptDir, @SW_HIDE)
      FileDelete (@SystemDir&"\VBoxNetFltNobj.dll")
      FileDelete (@SystemDir&"\drivers\VBoxNetFlt.sys")
    EndIf
  ElseIf $action = 'delete' Then
      If $DRV = 1 Then
        RunWait ("sc delete VBoxDRV", @ScriptDir, @SW_HIDE)
      EndIf
      If $USB = 1 Then
        RunWait ("sc delete VBoxUSB", @ScriptDir, @SW_HIDE)
      EndIf
      If $MON = 1 Then
        RunWait ("sc delete VBoxUSBMon", @ScriptDir, @SW_HIDE)
      EndIf
      If $ADP = 1 Then
        RunWait ("sc delete VBoxNetAdp", @ScriptDir, @SW_HIDE)
      EndIf
      If $NET = 1 Then
        RunWait ("sc delete VBoxNetFlt", @ScriptDir, @SW_HIDE)
      EndIf
  EndIf
EndFunc