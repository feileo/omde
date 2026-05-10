# OMDE

Oh My Development Environment

```sh
git clone --recurse-submodules https://github.com/feileo/omde.git $HOME/x/omde
# update
# git submodule update --init --recursive
```

## 安装

### Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### zsh

```sh
brew install zsh
chsh -s /usr/local/bin/zsh

# Oh My Zsh: https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sv $HOME/x/omde/zsh/main.zsh $HOME/.zshrc
ln -sv $HOME/x/omde/zsh/p10k.zsh $HOME/.p10k.zsh

# powerlevel10k: https://github.com/romkatv/powerlevel10k
# 安装 zsh/main.zsh 中列出的插件

brew install eza

source $HOME/.zshrc
```

### git

```sh
brew install git git-delta

ln -sv $MDE/git/.gitconfig $HOME/.gitconfig
ln -sv $MDE/git/.ignore_global $HOME/.gitignore_global

# commitizen（conventional commits）
brew install node

npm install -g commitizen
```

### tmux

```sh
brew install tmux
brew install ical-buddy

ln -sv $MDE/tmux $HOME/.config/tmux

git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm

tmux new -s main
# 在 tmux 内安装插件：
prefix + I

# 安装 uptime 模块补丁
cp $MDE/tmux/scripts/plugin_uptime_status.sh $HOME/.config/tmux/plugins/catppuccin-tmux/status/uptime.sh
```

详细文档：[tmux/README.md](tmux/README.md)

### nvim

```sh
# 安装 Neovim: https://github.com/neovim/neovim/blob/master/INSTALL.md
# 安装 Nerd Font: https://www.nerdfonts.com/font-downloads（推荐 Maple Mono NF CN）
brew install ripgrep

ln -sv $MDE/nvim-starter $HOME/.config/nvim

nvim
# 启动后执行：
# :MasonInstallAll
# :GoInstallDeps（Go 开发）
```

详细文档：[nvim-starter/README.md](nvim-starter/README.md)

## 目录结构

| 路径 | 说明 | Symlink 目标 |
|------|------|-------------|
| `zsh/` | Shell 配置（oh-my-zsh + powerlevel10k） | `main.zsh` → `~/.zshrc`，`p10k.zsh` → `~/.p10k.zsh` |
| `git/` | Git 配置（delta pager，nvim editor） | `.gitconfig` → `~/.gitconfig`，`.ignore_global` → `~/.gitignore_global` |
| `tmux/` | Tmux 配置 | 整个目录 → `~/.config/tmux` |
| `nvim-starter/` | Neovim 配置入口 | 整个目录 → `~/.config/nvim` |
| `nvim-core/` | NvChad 核心框架（submodule，nvim-starter 的插件依赖） | — |
| `ghostty/` | Ghostty 终端配置（Maple Mono NF CN，Molokai 主题） | — |
| `vscode/` | VS Code 配置（Go 主力：goimports + golangci-lint） | — |
| `claude/` | Claude Code 状态栏 hook（`statusline.sh`） | — |
| `iterm/` | iTerm2 profile 备份（不自动 symlink） | — |
| `tmux_old/` | 原始 tmux 配置存档（submodule，只读参考） | — |

## 约定

- **Symlink，不 copy** — 编辑仓库文件即时生效
- **本地私有配置 → `zsh/local.zsh`**（已 gitignore）
- **提交用 `git cz`**（commitizen），不用裸 `git commit`
