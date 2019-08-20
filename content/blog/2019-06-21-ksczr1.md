---
title: VS Code 常见配置与使用技巧总结
type: post
tags: ["others", "软件"]
date: 2019-06-21T03:58:08.000Z
category: 软件
published: true
---

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561100166886-8101e9e6-c7d4-45fd-b981-7a1656f3bd90.png#align=left&display=inline&height=292&name=image.png&originHeight=292&originWidth=380&size=30073&status=done&width=380)<br />版本: 1.35.1 (user setup)


<a name="4Qnkm"></a>
### 1. 通过配置文件设置

VS Code 的配置文件默认为：settings.json，我们可以通过下面的方式打开该文件进行自定义配置：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561099788662-7327baa6-1373-468b-9e8f-92918417bc77.png#align=left&display=inline&height=310&name=image.png&originHeight=310&originWidth=1019&size=35777&status=done&width=1019)

```json
{
    "editor.minimap.enabled": false,
    "editor.fontSize": 12,
    "workbench.statusBar.feedback.visible": false,
    "terminal.integrated.shell.windows": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "workbench.colorTheme": "Visual Studio Dark",
    "[python]": {},
    "breadcrumbs.enabled": false,
    "workbench.editor.centeredLayoutAutoResize": false,
    "editor.wordWrap": "on",
    "editor.minimap.showSlider": "always",
    "window.menuBarVisibility": "visible",
    "workbench.sideBar.location": "left",
    "editor.accessibilitySupport": "off",
    //显示头部导航栏
    "workbench.editor.showTabs": true,
    "window.zoomLevel": 0,
    //Ctrl+滚轮实现代码的缩放
    "editor.mouseWheelZoom": true,
    "workbench.editor.tabSizing": "shrink"
}
```

<a name="nQhTY"></a>
### 2. 编辑器选项卡
当 vscode 打开很多文件，如果 "**设置→工作台→编辑器管理→Tab Sizing**" 为 "**fit**"，编辑器选项卡将使用滚动隐藏的方式显示，想要显示打开的编辑器可以使用 `edt` 的命令或者设置 "**Show All Editors**" 的快捷键。<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1565228295004-83f73509-9e84-457b-b30d-3ed359d89860.png#align=left&display=inline&height=320&name=image.png&originHeight=320&originWidth=772&size=86248&status=done&width=772)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561098903958-6b478420-5bdc-4a29-ab67-24af40d370a9.png#align=left&display=inline&height=225&name=image.png&originHeight=225&originWidth=1019&size=30265&status=done&width=1019)

也可以将 "**设置→工作台→编辑器管理→Tab Sizing**" 设置为 "**shrink**"：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561099277202-15bc9e25-1f38-4c13-8a1e-48cf7cd696de.png#align=left&display=inline&height=313&name=image.png&originHeight=313&originWidth=684&size=27747&status=done&width=684)
