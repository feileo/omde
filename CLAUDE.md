# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

OMDE (Oh My Development Environment) is a dotfiles/config repository for macOS development environments. It is managed as a git repo with several submodules and symlinked into standard config locations.

## Repository Structure

- **zsh/** — Shell config. `main.zsh` is symlinked to `~/.zshrc`; `cmd.zsh` contains aliases and functions; `local.zsh` is gitignored (machine-specific overrides).
- **git/** — Git config files symlinked to `~/.gitconfig` and `~/.gitignore_global`. Uses `delta` as the pager and `nvim` as the editor. Commits use `git cz` (commitizen).
- **tmux/** — Tmux config symlinked to `~/.config/tmux`. Prefix is `C-Space`. Plugins managed by TPM (tpm runs at end of `tmux.conf`).
- **nvim-starter/** — Neovim config symlinked to `~/.config/nvim`. Built on NvChad with lazy.nvim. The `nvim-core` and `nvim-ui` directories are submodules providing the NvChad base.
- **ghostty/** — Ghostty terminal config (`config.ghostty`). Font: Maple Mono NF CN, theme: Molokai.
- **vscode/** — VS Code settings (`settings.json`). Primary language: Go; formatter: goimports + golangci-lint.
- **claude/** — Claude Code utilities. `statusline.sh` is a post-session status line hook displaying model, cost, token usage, and git status.
- **iterm/** — iTerm2 profile exports (backup only, not symlinked automatically).

## Submodules

| Path | Remote |
|------|--------|
| `nvim-starter` | github.com/feileo/nvim-starter |
| `nvim-core` | github.com/feileo/nvim-core |
| `nvim-ui` | github.com/feileo/nvim-ui |
| `tmux_old` | github.com/feileo/tmux (archived) |

Clone with `--recurse-submodules`. Update with `git submodule update --init --recursive`.

## Symlink Setup

All configs are symlinked — never copy files. Key links:

```sh
ln -sv $MDE/zsh/main.zsh $HOME/.zshrc
ln -sv $MDE/zsh/p10k.zsh $HOME/.p10k.zsh
ln -sv $MDE/git/.gitconfig $HOME/.gitconfig
ln -sv $MDE/git/.ignore_global $HOME/.gitignore_global
ln -sv $MDE/tmux $HOME/.config/tmux
ln -sv $MDE/nvim-starter $HOME/.config/nvim
```

`$MDE` is exported in `zsh/main.zsh` as `$HOME/x/omde`.

## Key Conventions

- **Commits**: Use `git cz` (commitizen) for conventional commits, not bare `git commit`.
- **`zsh/local.zsh`**: Machine-specific env vars and secrets go here — gitignored.
- **tmux plugins**: The `tmux/plugins/` directory is gitignored; TPM (`prefix + I`) installs them.
- **Neovim after install**: Run `:MasonInstallAll` after lazy.nvim finishes, and `:GoInstallDeps` for Go files.
- **tmux + Claude Code**: The two commented lines at the bottom of `tmux/tmux.conf` (`allow-passthrough` and `extended-keys`) must be enabled if running Claude Code inside tmux to fix Shift+Enter and desktop notifications.
