#!/usr/bin/sh

git submodule update --init --recursive

brew bundle

stow --ignore=".DS_Store|.netrwhist|autoload/plug.vim|coc-settings.json|colors/solarized.vim" vim
stow --ignore=".DS_Store|.gitconfig" git
stow --ignore=".DS_Store" tmux
stow --ignore=".DS_Store|Code/User/settings.json" vscode
stow --ignore=".DS_Store" jupyter
stow --ignore=".DS_Store" ipython


unlink ~/.zshrc
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

unlink ~/.p10k.zsh
ln -s ~/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
