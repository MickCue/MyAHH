#NoEnv
#NoTrayIcon
; #Warn
#SingleInstance Off

ToggleWinMinimize(TheWindowTitle)
{
SetTitleMatchMode,2
DetectHiddenWindows, Off
IfWinActive, %TheWindowTitle%
{
WinMinimize, %TheWindowTitle%
}
Else
{
IfWinExist, %TheWindowTitle%
{
WinGet, winid, ID, %TheWindowTitle%
DllCall("SwitchToThisWindow", "UInt", winid, "UInt", 1)
}
}
Return
}

LWin & Return::
if WinActive("ahk_class CabinetWClass") 
or WinActive("ahk_class ExploreWClass")
{
  Send {Shift Down}{AppsKey}{Shift Up}
  Sleep 10
  Send w{enter}
}
else
{
  run, cmd, .
}
return

#IfWinActive ahk_class ConsoleWindowClass
^V::
SendInput {Raw}%clipboard%
return
#IfWinActive


#IfWinActive ahk_class Git Bash
{
^v::
SendInput +{Insert}
Return
}

; Win+\ Turn Of Screen
#\::
SendMessage 0x112, 0xF170, 2, , Program Manager ; Monitor off
Return

<+!s::ToggleWinMinimize("Sublime")
<+!v::ToggleWinMinimize("VirtualBox")