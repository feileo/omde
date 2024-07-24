#          __                                     __
#   ____  / /_     ____ ___  __  __   ____  _____/ /_  __ _______
#  / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \'__ __/____|
# / /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / // /   //
# \____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_//_/   /(__
#                         /____/

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
export MDE=$HOME/x/omde

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  dircycle
  extract
  zsh-syntax-highlighting
  zsh-autosuggestions
  # autojump
)

ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
ZSH_DISABLE_COMPFIX=true
COMPLETION_WAITING_DOTS=true
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
CASE_SENSITIVE=true
HYPHEN_INSENSITIVE=true


zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7


# DISABLE_MAGIC_FUNCTIONS=true
# DISABLE_LS_COLORS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
HIST_STAMPS="yyyy-mm-dd"


source $ZSH/oh-my-zsh.sh

############################### User settings ###############################
setopt HIST_IGNORE_DUPS

# install tmux-256color https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
if [[ $TMUX != "" ]] then
  export TERM="tmux-256color"
else
  export TERM="xterm-256color"
fi

DEFAULT_USER=$USER

# To customize prompt, run `p10k configure` or edit $MDE/zsh/p10k.zsh.
[[ ! -f $MDE/zsh/p10k.zsh ]] || source $MDE/zsh/p10k.zsh

[[ ! -f $MDE/zsh/cmd.zsh ]] || source $MDE/zsh/cmd.zsh

[[ ! -f $MDE/zsh/local.zsh ]] || source $MDE/zsh/local.zsh
