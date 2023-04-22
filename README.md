# Dotfiles

To set-up:

- install neovim 5.

- install brew

  ```sh
  /bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")
  ```

- install dependencies
  ```sh
  sh install.sh
  ```

- install ohmyzsh theme
```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

- install dracula theme
```sh
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
```
