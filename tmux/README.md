# TMUX 现代化配置

> 基于插件的现代化 tmux 配置，优化的快捷键和工作流程

## ✨ 特性

- 🎯 **人体工学前缀键**: `Ctrl+Space`（备用 `Ctrl+e`）
- 🎨 **Catppuccin 主题**: 现代美观的配色方案
- ⌨️ **Vim 风格导航**: h/j/k/l 窗格导航
- 🪟 **浮动窗口**: 快速打开临时终端
- 📋 **智能剪贴板**: 自动同步系统剪贴板
- 🔋 **系统监控**: 电池、运行时间、会议提醒
- 🚀 **插件化架构**: 易于扩展和维护

---

## 📦 安装

### 前置要求

```bash
# tmux >= 3.0
brew install tmux
# or brew upgrade tmux
tmux -V

# git
git --version

# 3. Nerd Font
brew install --cask font-jetbrains-mono-nerd-font
```

### 完整安装步骤

#### Install

```bash
git clone --recurse-submodules https://github.com/feileo/omde.git $HOME/x/omde
# update
# git submodule update --init --recursive
# git submodule status
```

```bash
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
```

```bash
ln -sv $MDE/tmux $HOME/.config/tmux
```

```bash
tmux new -s main

# 在 tmux 中安装插件
prefix + I
# 等待插件安装完成（会显示 "TMUX environment reloaded"）
```

#### Reload

```bash
# 在 tmux 中按
Ctrl+Space r

# 或命令行
tmux source-file $HOME/.config/tmux/tmux.conf
```

#### Upgrade Plugins

```bash
Ctrl+Space U  (大写 U)
```

### 可选依赖（增强功能）

```bash
# 会议提醒模块（可选）
brew install ical-buddy

# 如果需要在终端设置中授权日历访问
# 系统设置 > 隐私与安全性 > 日历 > 勾选你的终端应用
```

---

## ⌨️ 快捷键

> **前缀键**: `Ctrl+Space` (备用: `Ctrl+e`)  

### 会话（Session）

```bash
# 创建和管理会话
prefix + C-c         新建会话
prefix + C-f         查找会话（输入名称搜索）
prefix + d           分离当前会话（退出但不关闭）
prefix + D           选择要分离的会话
prefix + $           重命名当前会话
prefix + s           列出所有会话（选择切换）
prefix + (           切换到上一个会话
prefix + )           切换到下一个会话

# 在终端中
tmux                 创建新会话
tmux new -s name     创建命名会话
tmux ls              列出所有会话
tmux attach          重新连接最后一个会话
tmux attach -t name  连接到指定会话
tmux kill-session -t name  杀掉指定会话
tmux kill-server     杀掉所有会话
```

### 窗口（Window）

```bash
# 窗口操作
prefix + c           新建窗口（保留当前路径）
prefix + w           列出所有窗口（选择切换）
prefix + f           按名称查找窗口
prefix + &           关闭当前窗口（需确认）
prefix + ,           重命名当前窗口

# 窗口导航
prefix + p           上一个窗口 ⭐
prefix + n           下一个窗口 ⭐
prefix + C-h         上一个窗口（备用）
prefix + C-l         下一个窗口（备用）
prefix + Tab         切换到最近使用的窗口
prefix + 0-9         切换到指定编号的窗口

# 窗口移动
prefix + .           移动窗口（输入新编号）
prefix + :swap-window -s 3 -t 1  交换窗口位置
```

### 窗格（Pane）

```bash
# 窗格分割
prefix + v           水平分割（左右）⭐
prefix + _           水平分割（备用）
prefix + -           垂直分割（上下）⭐
prefix + %           水平分割（默认）
prefix + "           垂直分割（默认）

# 窗格导航 (Vim风格)
prefix + o           循环切换窗格
prefix + h           移动到左边窗格 ⭐
prefix + j           移动到下面窗格 ⭐
prefix + k           移动到上面窗格 ⭐
prefix + l           移动到右边窗格 ⭐
prefix + ;           切换到上一个活动窗格
prefix + q           显示窗格编号（然后按数字跳转）

# 窗格调整大小 (Vim风格)
prefix + H           向左扩展 ⭐
prefix + J           向下扩展 ⭐
prefix + K           向上扩展 ⭐
prefix + L           向右扩展 ⭐
prefix + Alt+方向键   调整窗格大小（5个单位）

# 窗格布局
prefix + Space       切换预设布局
prefix + C-o         交换窗格
prefix + {           与上一个窗格交换位置
prefix + }           与下一个窗格交换位置
prefix + >           与下一个窗格交换 ⭐
prefix + <           与上一个窗格交换 ⭐
prefix + !           将当前窗格移到新窗口
prefix + z           最大化/还原当前窗格
prefix + x           关闭当前窗格（需确认）
```

### 复制模式（Vi 风格）

```bash
# 进入和退出
prefix + Enter       进入复制模式 ⭐
prefix + PgUp        进入复制模式并向上翻页
q 或 Escape          退出复制模式

# 复制模式内导航
h, j, k, l           Vim 风格移动 ⭐
w, b                 按单词前进/后退
0, $                 行首/行尾
H                    行首 ⭐
L                    行尾 ⭐
g, G                 文件首/文件尾
C-u                  向上半页 ⭐
C-d                  向下半页 ⭐
C-b                  向上整页
C-f                  向下整页
/                    向下搜索
?                    向上搜索
n                    下一个搜索结果
N                    上一个搜索结果

# 选择和复制
v                    开始选择（Visual 模式）⭐
V                    行选择
C-v                  矩形选择 ⭐
y                    复制选中内容并退出 ⭐
Enter                复制选中内容并退出
```

### 粘贴和缓冲区

```bash
# 粘贴操作
prefix + P           直接粘贴（大写 P）⭐
prefix + p           选择缓冲区粘贴（小写 p）⭐
prefix + b           列出所有粘贴缓冲区
prefix + =           选择并粘贴缓冲区
prefix + ]           粘贴最近的缓冲区
prefix + -           删除最近的缓冲区
```

### 配置和帮助

```bash
# 配置管理
prefix + r           重新加载配置 ⭐
prefix + :           进入命令提示符
prefix + ?           列出所有快捷键

# 插件管理（TPM）
prefix + I           安装插件（大写 I）
prefix + U           更新插件（大写 U）
prefix + Alt+u       卸载插件
```

### 特殊功能

```bash
# 浮动窗口
prefix + f           打开浮动终端 ⭐

# 其他
prefix + t           显示时钟
prefix + i           显示窗格信息
C-l                  清屏并清除历史记录 ⭐
prefix + m           切换鼠标模式

# FZF URL 选择器
prefix + u           打开 URL 选择器（需要插件配置）
```

---

## 🎨 状态栏模块

当前启用的状态栏模块：

### 右侧状态栏
```
application  →  当前应用程序
directory    →  当前目录名称
user         →  当前用户名
meetings     →  会议提醒（需要 icalBuddy）
battery      →  电池状态和电量
uptime       →  系统运行时间
date_time    →  日期和时间
```

### 左侧状态栏
```
session      →  当前会话名称
```

### 自定义模块

#### Uptime 模块（系统运行时间）
```bash
显示格式: 󰔟 0d 17h 52m
脚本位置: scripts/uptime.sh
模块位置: plugins/catppuccin-tmux/status/uptime.sh
```

#### Meetings 模块（会议提醒）
```bash
依赖: icalBuddy (brew install ical-buddy)
显示格式: 
  - 无会议: 󱁕
  - 有会议: 󰤙 14:30 Meeting Name (5 minutes)
脚本位置: scripts/cal.sh
模块位置: plugins/catppuccin-tmux/status/meetings.sh
```

---

## ⚙️ 配置说明

### 核心配置

```bash
前缀键:         Ctrl+Space (备用: Ctrl+e)
历史记录:       5000 行
重复超时:       600ms
状态更新间隔:   30 秒
终端类型:       ${TERM} (动态)
鼠标支持:       开启
Vi 模式:        开启
窗口起始:       1
状态栏位置:     顶部
```

### 插件列表

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| tpm | 插件管理器 | prefix+I/U |
| tmux-sensible | 合理的默认设置 | - |
| tmux-yank | 系统剪贴板集成 | 自动 |
| tmux-thumbs | 快速文本选择 | 见插件 |
| tmux-fzf-url | FZF URL 选择 | prefix+u |
| catppuccin-tmux | Catppuccin 主题 | - |
| tmux-floax | 浮动窗口 | prefix+f |
| tmux-battery | 电池状态 | - |

---

## 🚀 常用工作流程

### 典型开发会话

```bash
# 1. 创建命名会话
tmux new -s project

# 2. 创建多个窗口
Ctrl+Space c    # 窗口1: 编辑器
Ctrl+Space c    # 窗口2: 服务器
Ctrl+Space c    # 窗口3: 测试

# 3. 分割窗格（在窗口2）
Ctrl+Space v    # 水平分割（左右）
Ctrl+Space -    # 垂直分割（上下）

# 4. 在窗格间导航
Ctrl+Space h/j/k/l

# 5. 调整窗格大小
Ctrl+Space H/J/K/L

# 6. 在窗口间切换
Ctrl+Space p/n  # 上一个/下一个
Ctrl+Space 1/2/3  # 直接跳转

# 7. 使用浮动窗口
Ctrl+Space f    # 打开浮动终端执行命令

# 8. 分离会话
Ctrl+Space d

# 9. 重新连接
tmux attach -t project
```

### 复制粘贴工作流

```bash
# 1. 进入复制模式
Ctrl+Space Enter

# 2. 移动到起始位置（Vim 风格）
h/j/k/l 或 w/b

# 3. 开始选择
v

# 4. 移动到结束位置
h/j/k/l

# 5. 复制
y

# 6. 粘贴
Ctrl+Space P（大写 P）
```

---

## 🎯 快捷键记忆技巧

### 窗格操作（都用 Vim 风格）
```
导航: h/j/k/l    (小写 = 移动)
调整: H/J/K/L    (大写 = 调整大小)
分割: v/-/_      (v=vertical, -=horizontal)
```

### 窗口操作（传统风格）
```
p/n              (previous/next)
c                (create)
,                (重命名，逗号 = comma = change name)
```

### 粘贴操作（大小写有意义）
```
P                (大写 = 直接 Paste)
p                (小写 = pick 选择缓冲区)
b                (buffer 列表)
```

---

## 🔧 自定义配置

### 修改前缀键

如果只想用一个前缀键：

```bash
# 编辑 tmux.conf，注释掉备用前缀
# set -g prefix2 C-e
# bind C-e send-prefix -2
```

### 修改状态栏模块

```bash
# 编辑 tmux.conf 第59行
set -g @catppuccin_status_modules_right "directory uptime date_time"
#                                        ^^^^^^^^^^^^^^^^^^^^^^^
#                                        根据需要增删模块

# 可用模块: application, directory, user, host, battery, uptime, meetings, date_time
```

### 修改状态栏位置

```bash
# 改为底部
set -g status-position bottom
```

### 修改主题

```bash
# 修改 Catppuccin flavor (mocha, macchiato, frappe, latte)
set -g @catppuccin_flavor "mocha"
```

---

## 💡 使用技巧

### 1. 使用浮动窗口执行快速命令

```bash
# 打开浮动窗口
Ctrl+Space f

# 执行命令（如 git status, htop 等）
# 退出后自动关闭
```

### 2. 快速复制屏幕内容

```bash
# 使用 tmux-thumbs（安装后自动配置）
# 会高亮屏幕上的可复制文本，按提示字母复制
```

### 3. 保持工作目录

```bash
# 新窗格/窗口自动继承当前目录
Ctrl+Space v    # 在相同目录分割
Ctrl+Space c    # 在相同目录新建窗口
```

### 4. 快速选择 URL

```bash
# 使用 FZF URL 选择器
Ctrl+Space u    # 列出屏幕上所有 URL
# 选择后自动在浏览器打开
```

### 5. 持续会话

```bash
# 断开连接但保持会话运行
Ctrl+Space d

# 稍后重新连接
tmux attach

# 会话会保持所有窗口、窗格和运行的程序
```

---

## ⚡ 性能优化

配置已经优化了性能相关参数：

```bash
escape-time:        10ms    # 快速命令序列
repeat-time:        600ms   # 重复按键超时
status-interval:    30s     # 状态栏更新间隔
history-limit:      5000    # 历史记录行数
```

---

## 🎨 主题定制

### 可用的 Catppuccin Flavors

```bash
# 在 tmux.conf 中设置
set -g @catppuccin_flavor "mocha"      # 深色（默认）
set -g @catppuccin_flavor "macchiato"  # 深色变体
set -g @catppuccin_flavor "frappe"     # 中等深色
set -g @catppuccin_flavor "latte"      # 浅色
```

### 自定义边框颜色

```bash
# 在 tmux.conf 中修改
set -g pane-active-border-style 'fg=#ff6347,bg=default'  # 活动窗格
set -g pane-border-style 'fg=#303030,bg=default'         # 非活动窗格
```

---

## 📚 参考资料

### 官方文档
- [tmux 手册](https://man.openbsd.org/tmux)
- [tmux GitHub](https://github.com/tmux/tmux)

### 插件文档
- [TPM](https://github.com/tmux-plugins/tpm)
- [Catppuccin tmux](https://github.com/catppuccin/tmux)
- [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [tmux-floax](https://github.com/omerxx/tmux-floax)

### 快速命令查询

```bash
# 在 tmux 内查看帮助
tmux list-keys          # 列出所有键位绑定
tmux list-commands      # 列出所有命令
tmux show-options -g    # 显示全局选项
tmux info               # 显示 tmux 信息
```

---

## ⭐ 推荐配置

### 终端设置

1. **字体**: JetBrainsMono Nerd Font (14-16pt)
2. **配色**: 使用支持 TrueColor 的终端
3. **$TERM**: 设置为 `xterm-256color`

### Shell 配置

在 `.zshrc` 或 `.bashrc` 中：

```bash
# 自动启动 tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
```

---

## 🎊 快速参考

### 最常用的 10 个快捷键

```
1.  Ctrl+Space c        新建窗口
2.  Ctrl+Space v        水平分割
3.  Ctrl+Space -        垂直分割
4.  Ctrl+Space h/j/k/l  窗格导航
5.  Ctrl+Space p/n      窗口切换
6.  Ctrl+Space z        最大化窗格
7.  Ctrl+Space Enter    复制模式
8.  Ctrl+Space P        粘贴
9.  Ctrl+Space f        浮动窗口
10. Ctrl+Space d        分离会话
```

### 必记命令

```bash
tmux                    启动
tmux attach             重新连接
tmux ls                 列出会话
tmux kill-server        杀掉所有会话
Ctrl+Space ?            查看所有快捷键
Ctrl+Space r            重新加载配置
```

---

**配置版本**: v1.0  
**最后更新**: 2026-01-02  
**维护**: 个人配置

🎉 享受你的 tmux 配置！

