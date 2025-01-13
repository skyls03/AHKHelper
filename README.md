## AHKHelper

一个由 AutoHotKey V2 编写的脚本。

## 有什么功能？

查看具体脚本，有注释说明。

## 文件结构

`AHKHelper.ahk` 为入口文件，它会导入 `lib` 中的各种模块。

## How to use?

- 先安装 [AutoHotkey](https://www.autohotkey.com/)
- 再克隆脚本，双击 `AHKHelper.ahk` 即可运行

  ```Bash
  git clone https://github.com/ListenV/AHKHelper.git
  ```

- 也可以用 Ahk2Exe 将 `AHKHelper.ahk` 编译为 exe

## FAQ

### 有的窗口无法操作？

因为有的窗口是以**管理员权限**启动的，比如：任务管理器、WeGame客户端（万恶的腾讯）

本程序默认是普通用户身份运行，无法越级操作。

解决办法：右键 `AHKHelper`，以管理员身份运行
