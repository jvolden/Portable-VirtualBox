; Language       : multilanguage
; Author         : Michael Meyer (michaelm_007) et al.
; e-Mail         : email.address@gmx.de
; License        : http://creativecommons.org/licenses/by-nc-sa/3.0/
; Version        : 6.4.9.0
; Download       : http://www.vbox.me
; Support        : http://www.win-lite.de/wbb/index.php?page=Board&boardID=153

#AutoIt3Wrapper_Res_Fileversion=6.4.9.0
#AutoIt3Wrapper_Res_ProductVersion=6.4.9.0
#AutoIt3Wrapper_Icon=VirtualBox.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_both=Y

#include <ColorConstants.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <GUIConstants.au3>
#include <DirConstants.au3>
#include <FileConstants.au3>
#include <IE.au3>
#include <ProcessConstants.au3>
#include <String.au3>
#include <WinAPIError.au3>
#include <Date.au3>

#include "include\portable-globals.au3"
#include "include\portable-ini.au3"
#include "include\portable-gui.au3"
#include "include\portable-update.au3"
#include "include\portable-hotkeys.au3"
#include "include\portable-utils.au3"
#include "include\portable-drivers.au3"
#include "include\portable-log.au3"

#NoTrayIcon
#RequireAdmin

Opt ("GUIOnEventMode", 1)
Opt ("TrayAutoPause", 0)
Opt ("TrayMenuMode", 11)
Opt ("TrayOnEventMode", 1)

TraySetClick (16)
TraySetState ()
TraySetToolTip ("Portable-VirtualBox")

If NOT FileExists ($var1) Then
  _Debug($var1 & " file missing. Creating ini", 3)
  CreateIni()
EndIf

local $lang = IniRead ($var1, "lang", "key", "NotFound")
If $lang = 0 Then
  _Debug("Language ini setting missing. Running SelectLanguage()", 3)
  SelectLanguage()
EndIf

local $update = IniRead ($var1, "update", "key", "NotFound")
If  $update = 1 Then
  CheckUpdate()
EndIf

If NOT (FileExists (@ScriptDir&"\app32") OR FileExists (@ScriptDir&"\app64")) Then
  _Debug(@ScriptDir &  "\app[32|64] missing. Running InstallGUI()", 3)
  InstallGUI()
  Global $startvbox = 0
Else
  _Debug(@ScriptDir &  "\app[32|64] exists. Skipping InstallGUI()", 3)
  Global $startvbox = 1
EndIf

If (FileExists (@ScriptDir&"\app32\virtualbox.exe") OR FileExists (@ScriptDir&"\app64\virtualbox.exe")) AND _ 
   ($startvbox = 1 OR IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "startvbox", "key", "NotFound") = 1) Then

  SetArch()
  UpdateXML()

  If FileExists (@ScriptDir&"\"& $arch & "\VirtualBox.exe") AND _
     FileExists (@ScriptDir&"\"& $arch & "\VBoxSVC.exe") AND _
     FileExists (@ScriptDir&"\"& $arch & "\VBoxC.dll") Then

    If NOT ProcessExists ("VirtualBox.exe") OR NOT ProcessExists ("VBoxManage.exe") Then

      local $image=@ScriptDir&"\data\settings\SplashScreen.jpg"
      local $loadmsg=IniRead ($var2 & $lng &".ini", "messages", "06", "NotFound")

      If FileExists ($image) Then
        SplashImageOn ("Portable-VirtualBox", $image, 480, 360, -1, -1, 1)
      Else
        SplashTextOn ("Portable-VirtualBox", $loadmsg, 220, 40, -1, -1, 1, "arial", 12)
      EndIf

      LoadHotkeysInTray()
      MSVSDrivers('load')
      Additions('load')
      Services('load')
      DllCall ($arch&"\VBoxRT.dll", "hwnd", "RTR3Init")
      Services('start')
      SetHomeDir('set')

      SplashOff ()

      ; Where we finally run VirtualBox.exe
      local $vMachine
      If $CmdLine[0] = 1 Then
        $vMachine = $CmdLine[1]
      ElseIf IniRead ($var1, "startvm", "key", "NotFound") = True Then
        $vMachine = IniRead ($var1, "startvm", "key", "NotFound")
      EndIf
      local $vBoxCommand="cmd /c .\"& $arch &"\VirtualBox.exe"
      local $StartVMCommand="cmd /c .\"& $arch &"\VBoxManage.exe startvm """& $vMachine & """" 
      If IniRead ($var1, "startvm", "key", "NotFound") = True or $CmdLine[0] = 1 Then
        RunWait ($StartVMCommand, @ScriptDir, @SW_HIDE)
      Else
        RunWait ($vBoxCommand, @ScriptDir, @SW_HIDE)
      EndIf

      ProcessWaitClose ("VirtualBoxVM.exe")
      ProcessWaitClose ("VBoxManage.exe")

      SplashTextOn ("Portable-VirtualBox", IniRead ($var2 & $lng &".ini", "messages", "07", "NotFound"), 220, 40, -1, -1, 1, "arial", 12)
      ProcessWaitClose ("VBoxSVC.exe")
      SetHomeDir('unset')

      Local $timer=0
      Local $PID = ProcessExists ("VBoxSVC.exe")
      If $PID Then ProcessClose ($PID)
      While $timer < 10000 AND $PID
        $PID = ProcessExists ("VBoxSVC.exe")
        If $PID Then ProcessClose ($PID)
        Sleep(1000)
        $timer += 1000
      Wend

      Services('stop')
      Additions('unload')
      MSVSDrivers('unload')
      Services('delete')
      SplashOff ()
    Else
      WinSetState ("Oracle VM VirtualBox Manager", "", BitAND (@SW_SHOW, @SW_RESTORE))
      WinSetState ("] - Oracle VM VirtualBox", "", BitAND (@SW_SHOW, @SW_RESTORE))
    EndIf
  Else
    SplashOff ()
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "start", "01", "NotFound"))
  EndIf
EndIf

Break (1)
Exit