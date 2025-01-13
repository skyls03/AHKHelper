; =======================================================
; ====================== AHKHelper ======================
; =======================================================

; 决定当脚本已经运行时是否允许它再次运行. Force: 跳过对话框并自动替换旧实例, 效果类似于 Reload 命令.
#SingleInstance Force
; 禁止发出警告
#Warn                           

; 每次执行窗口函数后的延时（0表示最小延时，提高脚本在CPU高负载时的可靠性）-1 表示无延时，而 0 表示最小延时. 默认延时为 100.
SetWinDelay(0)

global Version := "Version: 3.0 (2024-01-08)`n`nCopyright sky03"

#Include lib
#Include util.ahk

#include BasicKey.ahk
#include HotString.ahk

#include WindowTop.ahk
#include WindowTransparency.ahk
#include CopyFilePath.ahk

#include FastLaunch.ahk
#include WindowMove.ahk
#include WindowResize.ahk

#Include VirtualDesktopManager.ahk