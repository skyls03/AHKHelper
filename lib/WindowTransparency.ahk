; --------------------窗口透明--------------------

<!WheelUp:: 		; LAlt 鼠标滚轮   窗口透明化增加
{
    HWND := WinGetID("A")
    WinTransPlus(HWND)
}

<!WheelDown:: 	    ; LAlt 鼠标滚轮   窗口透明化减弱
{
    HWND := WinGetID("A")
    WinTransMinus(HWND)
}

WinTransPlus(wid) {
    transparent := WinGetTransparent("ahk_id" wid)
    ; TODO 最开始不为Integer，因此无法修改
    if (IsInteger(transparent)) {
        if (transparent <= 235) {
            transparent := transparent + 20
            WinSetTransparent(transparent, "ahk_id" wid)
        }
        else {
            WinSetTransparent("off", "ahk_id" wid)
        }
    }
}
WinTransMinus(wid) {
    transparent := WinGetTransparent("ahk_id" wid)
    ; TODO 最开始不为Integer，因此无法修改
    if (transparent = "") {
        WinSetTransparent(235, "ahk_id" wid)
    }
    else {
        if (IsInteger(transparent)) {
            if (transparent >= 40) {
                transparent := transparent - 20
            }
            WinSetTransparent(transparent, "ahk_id" wid)
        }
    }
}