#NoEnv
#NoTrayIcon
; #Warn
#SingleInstance Off

<+!s::ToggleWinMinimize("Sublime")
<+!v::ToggleWinMinimize("VirtualBox")

$Escape::                                               ; Long press (> 0.5 sec) on Esc closes window - but if you change your mind you can keep it pressed for 3 more seconds
    KeyWait, Escape, T0.5                               ; Wait no more than 0.5 sec for key release (also suppress auto-repeat)
    If ErrorLevel                                       ; timeout, so key is still down...
        {
            SoundPlay *64                               ; Play an asterisk (Doesn't work for me though!)
            WinGet, X, ProcessName, A
            SplashTextOn,,150,,`nRelease button to close %x%`n`nKeep pressing it to NOT close window...
            KeyWait, Escape, T3                         ; Wait no more than 3 more sec for key to be released
            SplashTextOff
            If !ErrorLevel                              ; No timeout, so key was released
                {
                    PostMessage, 0x112, 0xF060,,, A     ; ...so close window      
                    Return
                }
                                                        ; Otherwise,                
            SoundPlay *64
            KeyWait, Escape                             ; Wait for button to be released
                                                        ; Then do nothing...            
            Return
        }
        
        Send {Esc}
Return

; Win+\ Turn Of Screen
#\::
SendMessage 0x112, 0xF170, 2, , Program Manager ; Monitor off
Return

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
  Run, cmd, .
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



