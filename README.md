# OMDE

Oh My Development Environment

```sh
git clone --recurse-submodules https://github.com/feileo/omde.git $HOME/x/omde
# update
# git submodule update --init --recursive
```

## zsh

```sh
# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install zsh
chsh -s /usr/local/bin/zsh

# Oh My Zsh: https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sv $HOME/x/omde/zsh/main.zsh $HOME/.zshrc
ln -sv $HOME/x/omde/zsh/p10k.zsh $HOME/.p10k.zsh

# powerlevel10k: https://github.com/romkatv/powerlevel10k

# install external plugins (listed in zsh/main.zsh)
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


brew install eza

source $HOME/.zshrc
```


## tmux

```sh
brew install tmux
brew install ical-buddy

ln -sv $MDE/tmux $HOME/.config/tmux

git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm

tmux new -s main
# Install plugins in tmux
prefix + I

# Install the uptime patch
cp $MDE/tmux/scripts/plugin_uptime_status.sh $HOME/.config/tmux/plugins/catppuccin-tmux/status/uptime.sh
```

👉 **For more information, please refer to the document: [tmux/README.md](tmux/README.md)**


## nvim

```sh
# Install Neovim: https://github.com/neovim/neovim/blob/master/INSTALL.md
# Install Nerd Font: https://www.nerdfonts.com/font-downloads（Recommend：Maple Mono NF CN）
brew install ripgrep

ln -sv $MDE/nvim-starter $HOME/.config/nvim

nvim
# :MasonInstallAll
# :GoInstallDeps（Go env）
```

👉 **For more information, please refer to: [nvim-starter](https://github.com/feileo/nvim-starter)**


## git

```sh
brew install git git-delta

ln -sv $MDE/git/.gitconfig $HOME/.gitconfig
ln -sv $MDE/git/.ignore_global $HOME/.gitignore_global

# commitizen（conventional commits）
brew install node

npm install -g commitizen
```

