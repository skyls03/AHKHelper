; --------------------窗口移动--------------------

<!LButton::    ; LAlt 鼠标左键   移动鼠标下的窗口
{
	; 鼠标的坐标是相对于屏幕的
	CoordMode("Mouse", "Screen")
	; 获取鼠标初始坐标和鼠标下的窗口id(后面的函数中，窗口ID可以省略不写)
	MouseGetPos(&Start_MouseX, &Start_MouseY, &TargetWinID)
	If (!TargetWinID)
		Return
	; 获取目标窗口最大最小化状态
	TargetMinMax := WinGetMinMax(TargetWinID)
	; 排除最小化最大化的窗口
	if (TargetMinMax != 0)
		return
	; 获取目标窗口Style
	TargetStyle := WinGetStyle(TargetWinID)
	; 排除弹窗样式窗口
	if ((TargetStyle & 0x80000000) and !(TargetStyle & 0x4C0000))
		return
	; 获取目标窗口Class
	TargetClass := WinGetClass(TargetWinID)
	; 避免拖动一下窗口类型
	if (TargetClass = "WorkerW" ||
		; 桌面
		TargetClass = "Progman" ||
		; 状态栏
		TargetClass = "Shell_TrayWnd" 
		; 输入法切换栏
		; TargetClass = "Shell_InputSwitchTopLevelWindow"
	) {
		return
	}
	if (!WinActive(TargetWinID))
		WinActivate(TargetWinID)
	; 获取目标窗口初始坐标
	WinGetPos(&Start_WinX, &Start_WinY, , , TargetWinID)
	loop {
		Sleep(0)
		Mouse_LBtnState := GetKeyState("LButton", "P") 	;按下1 松开0
		if (Mouse_LBtnState = 0)
			break
		MouseGetPos(&End_MouseX, &End_MouseY) 		;移动后鼠标位置
		WinGetPos(&End_WinX, &End_WinY, , , TargetWinID) 		;获取窗口坐标

		New_WinX := Start_WinX + (End_MouseX - Start_MouseX)
		New_WinY := Start_WinY + (End_MouseY - Start_MouseY)
		; 如果鼠标没有移动，则不移动窗口。节省CPU资源，提高性能
		If ((New_WinX != End_WinX) or (New_WinY != End_WinY)) {
			WinMove(New_WinX, New_WinY, , , TargetWinID)
		}
	}
}

; Alt按下或者有可调整大小边框
; If ( (Move_LAltState = 1) or (Move_WinStyle & 0x40000) )
; {
; }

; TODO : this is a workaround (checks for popup window) for the activation
; bug of AutoHotkey -> can be removed as soon as the known bug is fixed
; If ( !((Move_WinStyle & 0x80000000) and !(Move_WinStyle & 0x4C0000)) )
