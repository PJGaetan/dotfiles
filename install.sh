#!/usr/bin/sh

stow --ignore=.DS_Store vim
stow --ignore=.DS_Store git
stow --ignore=.DS_Store tmux
stow --ignore=.DS_Store vscode


unlink ~/.zshrc
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

unlink ~/.p10k.zsh
ln -s ~/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
