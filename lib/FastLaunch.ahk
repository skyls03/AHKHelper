; --------------------基础键位--------------------
; 修饰键四大金刚：# Win    ! Alt    ^ Control    + Shift

; --------------------------------------------------
; 软件切换
; 切换逻辑：先判断软件是否启动：
;      - 如果该软件已经启动，就再判断软件窗口是否已经激活
;        - 如果已经激活,就将窗口最小化
;        - 如果窗口没有激活，就将其激活
;      - 如果该软件没有启动，就启动该软件

; 规则：
; 1. ahk_exe 后跟进程名称 （可用AHK自带的Window_Spy来查看）
; 2. Run 后面直接放程序的路径即可。
;    - 但 Windows 商店中软件不同，先用 Win+R 输入 shell:appsFolder，打开一个 Applications 文件夹
;    - 找到要启动的 App，右键创建快捷方式，查看快捷方式属性，将目标类型值加到 shell:appsFolder\ 后即可
; name: 进程名称，path：程序所在路径
launch(name, path){
    if WinExist("ahk_exe" . name) {
        if WinActive("ahk_exe" . name) {
            WinMinimize()
        } else {
            WinActivate()
        }
    } else {
        Run(path)
    }
}

<!e::
{
    launch("msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
}

<!a::
{
    launch("idea64.exe", "D:\Development\JetBrains\IntelliJ IDEA Ultimate\bin\idea64.exe")
}

<!w::
{
    launch("webstorm64.exe", "D:\Development\JetBrains\WebStorm\bin\webstorm64.exe")
}


<!c::launch("Code.exe", "C:\Program Files\Microsoft VS Code\Code.exe")
