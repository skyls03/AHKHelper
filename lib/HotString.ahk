; --------------------热字符串--------------------

; *：不需要终止符 (即空格, 句点或回车) 来触发热字串.
; O：进行替换时，忽略终止符.

; 重新设置终止符为 Tab
#Hotstring EndChars `t

:*:]d::  ; 此热字串通过后面的命令把 "]d" 替换成当前日期和时间. *代表直接按就会触发效果
{
  CurrentDateTime := FormatTime(, "yyyy-MM-dd HH:mm")
  SendText(CurrentDateTime)
}