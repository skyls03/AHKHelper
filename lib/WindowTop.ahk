; --------------------窗口置顶--------------------

<!d::    ;LAlt D ：顶置鼠标下的窗口/取消顶置
{
    MouseGetPos(,, &currentWindow)
    WinTopToggle(currentWindow)
}

WinTopToggle(w) {
    winTitle := WinGetTitle("ahk_id" w)
    WinSetAlwaysOnTop(-1, "ahk_id" w)
    ExStyle := WinGetExStyle("ahk_id" w)
    if (ExStyle & 0x8)  ; 0x8 为 WS_EX_TOPMOST.在WinGet的帮助中
        msg := "置顶 "
    else
        msg := "取消置顶 "
    toast(msg winTitle)
}
