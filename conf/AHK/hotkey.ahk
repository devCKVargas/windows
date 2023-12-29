#Requires AutoHotkey v2.0

; █░█ ▄▀█ █▀█
; ▀▄▀ █▀█ █▀▄
terminal := "wt"		; windows terminal
browser := "msedge"
editor := "code"
spotify := "spotify"
currentYear := A_YYYY ; i.e. 2023
currentMonth := A_MM	; i.e. 12
screenshotFolder := "D:\--ShareX--\Screenshots\" . currentYear . "-" . currentMonth

; ▄▀█ █▀█ █▀█ █▀	Note:
; █▀█ █▀▀ █▀▀ ▄█	# WindowKey, ^ Ctrl, ! Alt
#b::Run browser											; 	Super + B 								-	launch msedge
#c::Run editor											; 	Super + C 								-	launch vscode
#enter:: Run terminal								; 	Super + Enter 						-	launch terminal
#NumpadEnter:: Run terminal					; 	Super + NumpadEnter 			-	launch terminal
#^!s:: Run spotify									; 	Ctrl + Super + Alt + S 		-	launch spotify

; █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█
; ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀	ToolTip "Window is Maximized"
#q::Send "!{F4}"										; 	Super + Q									-	close active window
^q::Send "!{F4}"										; 	Ctrl + Q									-	close active window
#f::{ 															;		Super + F									-	toggle maximize active window
	ActWinState:=WinGetMinMax("A")
	if(ActWinState > 0){
		WinRestore "A"
	} else WinMaximize "A"
}
#PgUp::WinMaximize "A"							; 	Super + PgUp							-	maximize active window
#PgDn::WinRestore "A"								;		Super + PgDn  						-	unmaximize active window
#+x:: Run screenshotFolder					; 	Super + Shift + x					-	open ShareX screenshot folder

; ▀█▀ █▀█  █▀▄ █▀█
; ░█░ █▄█  █▄▀ █▄█
; ADD voicemeeter as volcontrol := "voicemeeter"