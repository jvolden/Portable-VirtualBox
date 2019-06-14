#include <GUIConstants.au3>
#include <Date.au3>

Opt("GUIOnEventMode", 1)
$Log_GUI = GUICreate("Log", 685, 395, 258, 190)
GUISetOnEvent($GUI_EVENT_CLOSE, "Log_Close")
$Log_Edit = GUICtrlCreateEdit("", 8, 8, 669, 377, BitOR($ES_AUTOVSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUISetState(@SW_SHOW)

;While 1
;    Sleep(100)
;WEnd
        
Func Log_Close()
    ;Exit
    GUISetState(@SW_HIDE, $Log_GUI)
EndFunc

Func _Debug($message, $level)
  If $level <= $debugLevel Then
    _WriteLineToLog($message)
  EndIf
EndFunc

Func _WriteLineToLog($Log_String_WriteLineToLog)
    GUICtrlSetData($Log_Edit, _NowCalc() & " - " & $Log_String_WriteLineToLog & @CRLF, 1)
Endfunc