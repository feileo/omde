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

# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

#   autoload -Uz compinit
#   compinit
# fi


############################### Main settings ###############################

export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh(./theme.zsh)
source ~/x/conf/zsh/theme.zsh

# autojump
plugins=(
  git z dircycle  extract zsh-syntax-highlighting zsh-autosuggestions
)


############################### Completion settings ###############################
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
COMPLETION_WAITING_DOTS=true
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
ZSH_DISABLE_COMPFIX=true
CASE_SENSITIVE=true
HYPHEN_INSENSITIVE=true


############################### Update settings ###############################
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7


############################### Library settings ###############################
# DISABLE_MAGIC_FUNCTIONS=true
# DISABLE_LS_COLORS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
HIST_STAMPS="yyyy-mm-dd"


source $ZSH/oh-my-zsh.sh

############################### User settings ###############################
# Load local settings files
source ~/x/conf/zsh/local.zsh

# Load local env files
source ~/x/conf/zsh/local_env.zsh
