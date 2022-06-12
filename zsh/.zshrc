# Path to your oh-my-zsh installation.
export ZSH=~/dotfiles/zsh

source $ZSH/oh-my-zsh-config.sh

# in ~/.zshrc, before Oh My Zsh is sourced:
ZSH_DOTENV_FILE=.env

source $ZSH/oh-my-zsh.sh

# User configuration

source $ZSH/fzf.sh
source $ZSH/gittree.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Open a random file in the current directory
function orf {
  sh ~/.script/launch_vids.sh $1
}

# Open a random file in MEGAsync directory
function orv  {
  NAME="/Users/GaetanPJ/MEGAsync\ Downloads"
  eval sh ~/.script/launch_vids.sh $NAME
}

# Print nbLine colName of csv files
csvcol() {
  head -n 1 $1 | tr , '\n' | awk '{printf("%d %s\n", NR, $0)}'
}



# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi


alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias proxy="proxychains4"
alias vim="nvim"

alias tre="tree -paACL 2 --filelimit=100"


# Allow pyenv to ovverride python env
eval "$(pyenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Vim like terminal navigation
set -o vi

# allow vv to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# added by travis gem
[ ! -s /Users/gaetanpierre-justin/.travis/travis.sh ] || source /Users/gaetanpierre-justin/.travis/travis.sh
