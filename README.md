# OMDE

Oh My Development Environment.

## Install

```sh
git clone --recurse-submodules https://github.com/feileo/omde.git $HOME/x/omde

# update
# git submodule update --init --recursive
# git submodule status
```

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### zsh

```sh
brew update
brew install zsh
zsh --version

chsh -s /usr/local/bin/zsh
echo $SHELL

# Install Oh My Zsh
# https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sv $HOME/x/omde/zsh/main.zsh $HOME/.zshrc
ln -sv $HOME/x/omde/zsh/p10k.zsh $HOME/.p10k.zsh

# Install powerlevel10k and the recommended font:
# https://github.com/romkatv/powerlevel10k

# Install the zsh plugins, see zsh/main.sh plugins list

# https://github.com/eza-community/eza/blob/main/INSTALL.md
brew install eza

source $HOME/.zshrc
```

### git

```sh
brew install git
# or
# xcode-select --install
git --version

ln -sv $MDE/git/.gitconfig $HOME/.gitconfig
ln -sv $MDE/git/.ignore_global $HOME/.ignore_global

# https://dandavison.github.io/delta/installation.html
brew install git-delta

brew install node
node -v
npm -v
npm install -g commitizen
```

### tmux

```sh
brew install tmux
tmux -V

ln -sv $MDE/tmux $HOME/.config/tmux
```

### nvim

```sh
# Install neovim to $HOM/apps/nvim/
# https://github.com/neovim/neovim/blob/master/INSTALL.md

ln -sv $MDE/nvim-starter $HOME/.config/nvim
```
