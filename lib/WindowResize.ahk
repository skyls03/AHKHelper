; --------------------窗口大小--------------------
; LAlt 鼠标右键   调整鼠标下的窗口大小
<!RButton::
{
    CoordMode("Mouse", "Screen")
    ; 获取鼠标初始坐标和鼠标下的窗口id
    MouseGetPos(&Start_MouseX, &Start_MouseY, &Target_WinID)
    if (!Target_WinID)
        return
    Target_MinMax := WinGetMinMax(Target_WinID)
    if (Target_MinMax != 0)
        return
    Target_WinClass := WinGetClass(Target_WinID)
    if (Target_WinClass = "Progman")
        return
    Target_WinStyle := WinGetStyle(Target_WinID)
    ; 必须是可调宽高的窗口
    if (!Target_WinStyle & 0x40000)
        return

    if !WinActive(Target_WinID)
        WinActivate(Target_WinID)
    WinGetPos(, , &Start_WinW, &Start_WinH, Target_WinID)
    If !(Start_WinW and Start_WinH)
        return
    loop {
        Sleep(0)
        Mouse_RBtnState := GetKeyState("RButton", "P") 	;按下1 松开0
        ; 鼠标松开 结束循环
        if (Mouse_RBtnState = 0)
            Break
        MouseGetPos(&End_MouseX, &End_MouseY)
        WinGetPos(,, &SIZ_WinW, &SIZ_WinH, Target_WinID)

        New_WinH := Start_WinH + (End_MouseY - Start_MouseY)
        New_WinW := Start_WinW + (End_MouseX - Start_MouseX)
		; 如果鼠标没有移动，则不改变窗口。节省CPU资源，提高性能
        If ((New_WinW != Start_WinW) or (New_WinH != Start_WinH))
        {
            WinMove(,, New_WinW, New_WinH, Target_WinID)
        }
    }
}