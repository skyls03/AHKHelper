
<!+c::   ; LAlt Shift C ：复制当前选中文件的绝对路径
{
	send("^c")
	sleep(200)
	; Windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了
	A_Clipboard := A_Clipboard
	; 提示复制文本
	toast(A_Clipboard)
}