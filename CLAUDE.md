# CLAUDE.md

Guidance for Claude Code (claude.ai/code) when working in this repo.

## Overview

OMDE (Oh My Development Environment) is a dotfiles/config repo for macOS development. Configs live here and are **symlinked** into their canonical locations (`~/.zshrc`, `~/.config/nvim`, `~/.config/tmux`, etc.). Never copy — always symlink, so edits here are immediately live.

`$MDE` is exported in `zsh/main.zsh` as `$HOME/x/omde`. All cross-config references use `$MDE`.

## Repository Layout

| Path | Role | Symlink target |
|------|------|----------------|
| `zsh/` | Shell config (oh-my-zsh + powerlevel10k) | `main.zsh` → `~/.zshrc`, `p10k.zsh` → `~/.p10k.zsh` |
| `git/` | Git config (delta pager, nvim editor) | `.gitconfig` → `~/.gitconfig`, `.ignore_global` → `~/.gitignore_global` |
| `tmux/` | Tmux config (prefix `C-Space`, TPM plugins, catppuccin) | whole dir → `~/.config/tmux` |
| `nvim-starter/` | Neovim entry (NvChad-based, lazy.nvim) | whole dir → `~/.config/nvim` |
| `nvim-core/` | NvChad fork used as a plugin by `nvim-starter` (submodule) | — |
| `nvim-ui/` | NvChad UI submodule used by `nvim-core` | — |
| `ghostty/` | Ghostty terminal config (Maple Mono NF CN, Molokai) | — |
| `vscode/` | VS Code settings (Go primary: goimports + golangci-lint) | — |
| `claude/` | Claude Code status line hook (`statusline.sh`) | — |
| `iterm/` | iTerm2 profile backups (not symlinked) | — |
| `tmux_old/` | Archived original tmux config (submodule, read-only reference) | — |

## Neovim: how the override layering works

This is the single most important thing to understand before editing nvim configs.

`nvim-starter/init.lua` loads plugins in this order:

```lua
require("lazy").setup({
  { "feileo/nvim-core", lazy = false, import = "nvchad.plugins" },  -- base plugin specs
  { import = "plugins" },                                           -- local overrides
}, lazy_config)
```

lazy.nvim **merges specs by plugin name**, so anything in `nvim-starter/lua/plugins/init.lua` overrides the matching entry from `nvim-core`. When changing a plugin's `opts`, `keys`, or `event`:
- **Add/override in `nvim-starter/lua/plugins/init.lua`** — do not edit `nvim-core/` directly (it's a submodule tracking upstream).
- Detailed plugin configs go in `nvim-starter/lua/configs/*.lua` and are referenced via `opts = function() return require "configs.xxx" end`.

Key files in `nvim-starter/lua/`:
- `chadrc.lua` — NvChad theme + UI config (currently `onedark`, statusline `minimal`)
- `options.lua` — `vim.opt` settings + `g:go_highlight_*` vars consumed by `syntax/go.vim`
- `mappings.lua` — keymaps (loaded via `vim.schedule` in `init.lua` after base46 themes)
- `autocmds.lua`, `cmds.lua` — autocmds and user commands
- `highlights.lua` — applied via `chadrc.base46.hl_override` / `hl_add`
- `configs/*.lua` — per-plugin config tables

### Neovim gotchas

- **LSP setup is 0.11+ style**: `nvim-core/lua/nvchad/configs/lspconfig.lua` uses `vim.lsp.config(...)` + `vim.lsp.enable "lua_ls"`. Do **not** call `lspconfig.setup` for servers already enabled in core (e.g. `lua_ls`) — it causes double-setup.
- **Go filetype uses a custom syntax file, not treesitter**: `nvim-starter/syntax/go.vim` (Charles Pascoe's) is authoritative. Treesitter has `disable = { "go" }` in `configs/treesitter.lua`. The `vim.g.go_highlight_*` variables in `options.lua` are the config knobs for this syntax file — they are **not** vim-go leftovers.
- **`highlightsts.lua` is currently dead code**: `chadrc.lua` only loads `highlights.lua`. The commented `vim.schedule` block in `init.lua` is the old loader. If reviving treesitter highlight overrides, wire it through `chadrc.base46.hl_override`, not ad-hoc `nvim_set_hl` calls.
- **pantran.nvim config nests under `fallback`**: without a Google API key the plugin uses its fallback engine, which reads `config.user.engines.google.fallback.*`. See `configs/pantran.lua`. Top-level `engines.google.*` keys are only used by the paid API path.
- **After first `lazy.nvim` sync**: run `:MasonInstallAll`, then `:GoInstallDeps` for Go files.

## Zsh

- `main.zsh` (→ `~/.zshrc`) sources `p10k.zsh`, `cmd.zsh`, then `local.zsh` if present.
- `local.zsh` is **gitignored** — put machine-specific env vars, secrets, work-only aliases there.
- `cmd.zsh` holds all user aliases and functions (`qq`/`rmqq` for Go's `q` debug log, `thrift-use` version switcher, git shortcuts).
- **`TERM` is forced to `tmux-256color` inside tmux** — requires the `tmux-256color` terminfo to be installed (see [this gist](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)).
- Known quirks (not yet fixed): `CASE_SENSITIVE=true` + `HYPHEN_INSENSITIVE=false` are redundant together; `COMPLETION_WAITING_DOTS` is set twice (line 34 commented, line 35 active); `source $HOME/.bashrc` at the bottom is marked TODO.
- Alias footguns: `ga='git add .'` (stages everything unconditionally), `gco='git commit -m'` (not `git checkout` — surprising vs. conventional `gco`).

## Tmux

- Prefix is `C-Space` (with `C-e` as secondary). Reloaded via sourcing; no dedicated reload binding currently.
- Plugin manager is **TPM** (`tmux/plugins/` is gitignored; installed via `prefix + I`).
- Theme is **`omerxx/catppuccin-tmux`** (a fork of the catppuccin original, not the upstream) — plugin options use the legacy `@catppuccin_*` keys, not the newer `@catppuccin_status_*` module API.
- Status bar modules (right side): `application directory user meetings battery uptime date_time`. The `meetings` and `uptime` modules shell out to scripts in `tmux/scripts/`.
- **Claude Code + tmux**: if running Claude Code inside tmux, flip the two lines at the bottom of `tmux.conf`:
  - `set -g allow-passthrough on` — lets desktop notifications / OSC sequences reach the outer terminal
  - `set -s extended-keys on` — lets tmux distinguish `Shift+Enter` from plain `Enter`
- Known quirks (not yet fixed): `pane-active-border-style` is set at both line ~20 and line ~270 (the latter wins); no pane-resize bindings enabled (commented at line ~190); `bind ^X kill-pane` has no confirmation.

### Tmux scripts

- `text_meetings.sh` — shows the next meeting from macOS Calendar via `icalBuddy`. Watches only calendars listed in `WATCH_CALS` (default `"工作"`). Caches results in `/tmp/tmux_meetings_<hour>_<5min-bucket>.cache` for 5 minutes via time-bucket filenames (auto-expiring, no cron needed). Popup window is 60s wide (matches `status-interval 60`).
- `text_uptime.sh` / `plugin_uptime_status.sh` — uptime indicators.
- Dependency: `brew install ical-buddy` is required for `text_meetings.sh`.

## Git & commits

- Use **`git cz`** (commitizen) for conventional commits — the project is set up for it, plain `git commit` bypasses the flow.
- `delta` is the configured pager; `nvim` is the editor.
- `.gitignore_global` is active — check it before adding ignore rules to individual repos.

## Submodule workflow

```sh
git clone --recurse-submodules <omde-url> $HOME/x/omde
git submodule update --init --recursive   # after pulling
git submodule status                      # check versions
```

Submodules (`nvim-starter`, `nvim-core`, `nvim-ui`, `tmux_old`) all point at `github.com/feileo/*`. When updating a submodule, commit the pointer bump in the parent repo.

## Conventions

- **Symlink, don't copy** — see the layout table for canonical targets.
- **Secrets / machine-local config → `zsh/local.zsh`** (gitignored).
- **Comments in configs are often Chinese** (user-written annotations). Preserve tone and language when editing adjacent lines.
- **Don't delete commented-out blocks** reflexively — many are intentional toggles (e.g. the Claude-Code-in-tmux lines, the highlightsts loader). Ask first if it looks load-bearing.
- **Don't introduce new dependencies** (plugins, brews, npm packages) without asking — this is a curated environment.
