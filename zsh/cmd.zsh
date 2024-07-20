# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ope="nvim"

# zshrc
alias opezrc='nvim ~/.zshrc'
alias sourcezrc='source ~/.zshrc'

# git
alias gs="git status"
alias gsm="git summary"
alias ga='git add .'
alias gd='git diff'
alias gf='git fetch'
alias grv='git remote -v'
alias grb='git rebase'
alias gck='git checkout'
alias gbr='git branch'
alias gul="git pull"
alias gus="git push"
alias gl="git log"
alias glg="git log --graph --decorate --all"
alias glgo="git log --oneline --graph --decorate --all"
alias gc="git cz"
alias gco="git commit -m"
alias gm="git merge"
alias gcl='git clone'

alias gop='git-open'

# virtualenvwrapper
alias won="workon"
alias deac='deactivate'
alias lsenv='lsvirtualenv'
alias mkenv='mkvirtualenv'
alias rmenv="rmvirtualenv"

# tmux
alias tnew='tmux new -s'
alias tatt='tmux attach'
alias tdtt='tmux detach'

# base
alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias grep="grep --color=auto"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -s html=nvim
alias -s rb=nvim
alias -s go=nvim
alias -s py=nvim
alias -s js=nvim
alias -s json=nvim
alias -s c=nvim
alias -s txt=nvim
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'

if [ -x "$(command -v exa)" ]; then
    alias ls="exa --icons"
    alias la="exa --icons --all"
    alias ll="exa --icons --long --links --all --header --group --modified --time-style=iso" # --grid
    alias lt="exa --icons --long --links --all --header --group --tree --level=2 --modified --time-style=iso"
fi


# go q
qq() {
    clear

    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi

    if [[ ! -f "$logpath" ]]; then
        echo 'Q LOG' > "$logpath"
    fi

    tail -100f -- "$logpath"
}

rmqq() {
    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi
    if [[ -f "$logpath" ]]; then
        rm "$logpath"
    fi
}
