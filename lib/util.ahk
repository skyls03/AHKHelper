toast(text, delay := 800) {
    ToolTip(text)
    SetTimer(() => ToolTip(), delay)
}