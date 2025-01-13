; --------------------基础键位--------------------
; 修饰键四大金刚：# Win    ! Alt    ^ Control    + Shift

^Esc::Suspend    ; Ctrl+Esc 禁用/启用所有的热键和热字串

^+r::    ; Ctrl+Shift+r 重载配置文件
{
  Reload()
  Sleep(1000)
  res := MsgBox("脚本出错，不能被重载，要编辑吗？","Error", "YesNo")
  if (res = "Yes"){
    Edit
  }
}

<#w::    ; 关闭活动窗口(Win W)
{
  WinClose("A")
}

<#+w::      ; LWin Shift W 关闭活动窗口，不行则强制关闭
{
  WinKill("A")
}

;<!+s::      ; 最大化窗口
;	WinMaximize, A
;Return

;<!+x::      ; 最小化窗口
;	WinMinimize, A
;Return
