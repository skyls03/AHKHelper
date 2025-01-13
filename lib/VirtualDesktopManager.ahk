; 快速切换Windows工作空间
; 使用的一个C#程序来实现，Github: https://github.com/MScholtes/VirtualDesktop

reg_path := "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
reg_Key := "DisabledHotkeys"

; 此步骤修改注册表为了下面的热键可以正常运行
res_reg := RegRead(reg_path, reg_Key, "-1")
if (res_reg = -1) {
    RegWrite("1234", "REG_SZ", reg_path, reg_Key)
    toast("已修改注册表！")
}

VirtualDesktop(arg) {
    Run("C:\Users\sky03\OneDrive\Buckup\VirtualDesktop11.exe " arg, , "Hide")
}

; 若想生效，需在注册表中禁用 Win+其他按键的快捷键
; 切换桌面（左Win 1）
<#1:: VirtualDesktop("/Switch:0")
<#2:: VirtualDesktop("/Switch:1")
<#3:: VirtualDesktop("/Switch:2")
<#4:: VirtualDesktop("/Switch:3")

; 把当前应用移动并切换至指定桌面（左Win Shift 1）
<#+1:: VirtualDesktop("/GetDesktop:0 /MoveActiveWindow /Switch:0")
<#+2:: VirtualDesktop("/GetDesktop:1 /MoveActiveWindow /Switch:1")
<#+3:: VirtualDesktop("/GetDesktop:2 /MoveActiveWindow /Switch:2")
<#+4:: VirtualDesktop("/GetDesktop:3 /MoveActiveWindow /Switch:3")

; 把当前应用移动到指定桌面（左Win Ctrl 1）
<#^1:: VirtualDesktop("/GetDesktop:0 /MoveActiveWindow")
<#^2:: VirtualDesktop("/GetDesktop:1 /MoveActiveWindow")
<#^3:: VirtualDesktop("/GetDesktop:2 /MoveActiveWindow")
<#^4:: VirtualDesktop("/GetDesktop:3 /MoveActiveWindow")