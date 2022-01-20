; =======================================================
; ====================== AHKHelper ======================
; =======================================================

#NoEnv                          ;不检查空变量是否为环境变量(建议所有新脚本使用).
#SingleInstance force           ;决定当脚本已经运行时是否允许它再次运行.Force: 跳过对话框并自动替换旧实例, 效果类似于 Reload 命令.
#Warn                           ; 发生错误时，是否发出警告
#HotkeyInterval 1000
#MaxHotkeysPerInterval 100
;#NoTrayIcon					; 隐藏系统托盘图标
; # Win
; ! Alt
; ^ Control
; + Shift

SendMode Input
SetWorkingDir %A_ScriptDir%

SetBatchLines, -1   	;让脚本无休眠运行(即让脚本以全速运行).
; TODO : a nulled key delay may produce problems for WinAmp control
SetKeyDelay, 0, 0
SetMouseDelay, 0
SetDefaultMouseSpeed, 0
SetWinDelay, 0 				;设置在每次执行窗口命令后自动的延时, -1 表示无延时, 而 0 表示最小延时. 如果未设置, 默认延时为 100.
SetControlDelay, 0

; OnExit("ExitFunc")

; 退出时清除透明
; ExitFunc(){ 
;    Gosub, TRA_TransparencyAllOff
; }
; --------------------热字符串--------------------
; *：不需要终止符 (即空格, 句点或回车) 来触发热字串.
; O：进行替换时，忽略终止符.
:O:kbd::<kbd></kbd>

:*:]d::  ; 此热字串通过后面的命令把 "]d" 替换成当前日期和时间. *代表直接按就会触发效果
FormatTime, CurrentDateTime,, yy/MM/dd HH:mm
SendInput %CurrentDateTime%
return
; --------------------------------------------------

^Esc::Suspend  ; ^+Esc 会禁用/启用所有的热键和热字串

^+r:: ; Ctrl+Shift+r 重载配置文件
reload
sleep 1000
msgbox, 4,, 脚本出错，不能被重载，要编辑吗?
ifmsgbox, yes, edit
return

LAlt & w::  ; 关闭窗口
    WinClose, A
Return

<!+w::      ; 尝试关闭，不行杀死
    WinKill, A
Return

LAlt & s::
	WinMaximize, A
Return

LAlt & x::
	WinMinimize, A
Return

LAlt & r::
	WinRestore, A
Return

LAlt::Send {LAlt}

LAlt & LButton::     ; 窗口移动
	SetWinDelay, -1
	CoordMode, Mouse, Screen
    MouseGetPos, MouseStartX, MouseStartY, Move_WinID    ; Move_WinID为鼠标下窗口的唯一id
    If ( !Move_WinID )
    	Return
    WinGetPos, WinStartX, WinStartY, , , ahk_id %Move_WinID%   ;获取坐标
	WinGet, Move_WinMinMax, MinMax, ahk_id %Move_WinID% 		;获取最大最小化状态
	WinGet, Move_WinStyle, Style, ahk_id %Move_WinID% 		;获取窗口Style
	WinGetClass, Move_WinClass, ahk_id %Move_WinID%			;获取窗口Class
	Move_LAltState := GetKeyState("LAlt", "P") 				;按下1 松开0

	; (WS_POPUP) and !(WS_DLGFRAME | WS_SYSMENU | WS_THICKFRAME)
	; 检查弹出窗口
    If ( (Move_WinClass = "WorkerW") or ((Move_LAltState = 0) and (((Move_WinStyle & 0x80000000) and !(Move_WinStyle & 0x4C0000)) or (Move_WinClass = "ExploreWClass") or (Move_WinClass = "WorkerW") or (Move_WinClass = "IEFrame") or (Move_WinClass = "MozillaWindowClass") or (Move_WinClass = "OpWindow") or (Move_WinClass = "ATL:ExplorerFrame") or (Move_WinClass = "ATL:ScrapFrame"))) )
	{
		return
	}
	Else
	{
    	if ( (Move_WinClass != "Progman") and ((Move_LAltState = 1) and (Move_WinMinMax != 1)) ){
			IfWinNotActive, ahk_id %Move_WinID%
				WinActivate, ahk_id %Move_WinID%
			SetTimer, Move_WindowHandler, 10
		}
	}
Return

	; Alt按下或者有可调整大小边框
	; If ( (Move_LAltState = 1) or (Move_WinStyle & 0x40000) )
	; {
	; }

	; TODO : this is a workaround (checks for popup window) for the activation 
	; bug of AutoHotkey -> can be removed as soon as the known bug is fixed
	; If ( !((Move_WinStyle & 0x80000000) and !(Move_WinStyle & 0x4C0000)) )

Move_WindowHandler:
	SetWinDelay, -1
	CoordMode, Mouse, Screen
	MouseGetPos, Move_MouseX, Move_MouseY 		;移动后鼠标位置
	WinGetPos, Move_WinX, Move_WinY, , , ahk_id %Move_WinID% 		;获取窗口坐标
	Move_LButtonState := GetKeyState("LButton", "P") 	;按下1 松开0
	
	If ( Move_LButtonState = 0 )    ; 鼠标左松开
	{
		SetTimer, Move_WindowHandler, Off 	;停止循环
	}
	Else 						; 鼠标左按住
	{
		Move_MouseDeltaX := Move_MouseX - MouseStartX
		Move_MouseDeltaY := Move_MouseY - MouseStartY

		If ( Move_MouseDeltaX or Move_MouseDeltaY )
		{
			Move_WinNewX := WinStartX + Move_MouseDeltaX
			Move_WinNewY := WinStartY + Move_MouseDeltaY
			If ( (Move_WinNewX != Move_WinX) or (Move_WinNewY != Move_WinY) )
			{
				WinMove, ahk_id %Move_WinID%, , %Move_WinNewX%, %Move_WinNewY%
			}
		}
	}
Return

; 窗口大小----------------------------------------------------------------
LAlt & RButton::
	SetWinDelay, -1
	CoordMode, Mouse, Screen
    MouseGetPos, Siz_MouseStartX, Siz_MouseStartY, Siz_WinID    ; Move_WinID为鼠标下窗口的唯一id
	if ( Siz_WinID )
	{
		WinGetClass, SIZ_WinClass, ahk_id %Siz_WinID%
		WinGet, SIZ_WinMinMax, MinMax, ahk_id %Siz_WinID%
		WinGet, SIZ_WinStyle, Style, ahk_id %Siz_WinID%

		; 检查窗口是否未最大化，是否有大小调整边框
		If ( (SIZ_WinClass != "Progman") and (SIZ_WinMinMax != 1) and (SIZ_WinStyle & 0x40000) )
		{
			WinGetPos, , , Siz_WinStartW, Siz_WinStartH, ahk_id %Siz_WinID%
			If ( SIZ_WinStartW and SIZ_WinStartH )
			{
				IfWinNotActive, ahk_id %Siz_WinID%
					WinActivate, ahk_id %Siz_WinID%
				SetTimer, SIZ_WindowHandler, 10
			}
		}
	}
Return

SIZ_WindowHandler:
	SetWinDelay, -1
	CoordMode, Mouse, Screen
	MouseGetPos, Siz_MouseX, Siz_MouseY
	WinGetPos, , , SIZ_WinW, SIZ_WinH, ahk_id %Siz_WinID%
	Siz_RButtonState := GetKeyState("RButton", "P") 	;按下1 松开0
	
	If ( Siz_RButtonState = 0 )    ; 鼠标松开
	{
		SetTimer, SIZ_WindowHandler, Off 	;停止循环
	}
	Else 						; 鼠标按住
	{
		Siz_MouseDeltaX := Siz_MouseX - Siz_MouseStartX
		Siz_MouseDeltaY := Siz_MouseY - Siz_MouseStartY
		If ( Siz_MouseDeltaX or Siz_MouseDeltaY )
		{
			Siz_WinNewW := Siz_WinStartW + Siz_MouseDeltaX
			Siz_WinNewH := Siz_WinStartH + Siz_MouseDeltaY
			; 这个判断来减少执行WinMove，提高性能
			If ( (Siz_WinNewW != Siz_WinStartW) or (Siz_WinNewH != Siz_WinStartH) )
			{
				WinMove, ahk_id %Siz_WinID%, , , , Siz_WinNewW, Siz_WinNewH
			}
		}
	}
Return

~LAlt & WheelUp:: 		;====窗口透明化增加====
    WinGet, ow, id, A
    WinTransplus(ow)
return

~LAlt & WheelDown:: 	;====窗口透明化减弱====
    WinGet, ow, id, A
    WinTransMinus(ow)
return

WinTransplus(w){
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent < 255
        transparent := transparent+10
    else
        transparent =
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}

WinTransMinus(w){
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent
        transparent := transparent-10
    else
        transparent := 240
    WinSet, Transparent, %transparent%, ahk_id %w%
    return
}

LAlt & d:: 		;====窗口置顶====
    WinGet ow, id, A
    WinTopToggle(ow)
return

WinTopToggle(w) {
    WinGetTitle, oTitle, ahk_id %w%
    WinSet, AlwaysOnTop, Toggle, ahk_id %w%
    WinGet, ExStyle, ExStyle, ahk_id %w%
    if (ExStyle & 0x8)  ; 0x8 为 WS_EX_TOPMOST.在WinGet的帮助中
        oTop = 置顶
    else
        oTop = 取消置顶
    tooltip %oTitle% %oTop%
	; 一般有人会快速切换，把消息关掉就交给另外一个线程来做
    SetTimer, RemoveToolTip, 700
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}

;=========================================================
~WheelUp::  	;鼠标放在任务栏，滚动滚轮实现音量的加减 
	if (Existclass("ahk_class Shell_TrayWnd")=1)  
	Send,{Volume_Up}
	Return
	~WheelDown::  	
	if (Existclass("ahk_class Shell_TrayWnd")=1)
	Send,{Volume_Down}
	Return
	~MButton::    	;鼠标中键静音
	if (Existclass("ahk_class Shell_TrayWnd")=1)  
	Send,{Volume_Mute}
Return

Existclass(class)  {  
	MouseGetPos,,,win
	WinGet,winid,id,%class%
	if win = %winid%
		Return,1
	Else
		Return,0
}

<!+c::   ;复制当前选中文件的路径
	send ^c
	sleep,200
	clipboard=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了
	tooltip,%clipboard% ;提示文本
	sleep,800
	tooltip,
return
