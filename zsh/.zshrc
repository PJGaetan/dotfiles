# Path to your oh-my-zsh installation.
export ZSH=~/dotfiles/zsh

source $ZSH/oh-my-zsh-config.sh

# in ~/.zshrc, before Oh My Zsh is sourced:
ZSH_DOTENV_FILE=.env

source $ZSH/oh-my-zsh.sh

#Plugin manager
source ~/.zplug/init.zsh

zplug raabf/gitmoji-fuzzy-hook, \
    from:gitlab
GITMOJI_FUZZY_HOOK_NO_COMMENTS=false
GITMOJI_FUZZY_HOOK_USE_CODE=true


# User configuration

source $ZSH/fzf.sh
source $ZSH/gittree.sh

# not loading in vim
source ~/.zprofile

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



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Vim like terminal navigation
set -o vi

# allow vv to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autoload -U +X bashcompinit && bashcompinit
autoload -U compinit; compinit
complete -o nospace -C /usr/local/bin/terraform terraform

# added by travis gem
[ ! -s /Users/gaetanpierre-justin/.travis/travis.sh ] || source /Users/gaetanpierre-justin/.travis/travis.sh

FZF_DBT_PATH=~/.fzf-dbt/fzf-dbt.sh
if [[ ! -f $FZF_DBT_PATH ]]; then
    FZF_DBT_DIR=$(dirname $FZF_DBT_PATH)
    print -P "%F{green}Installing fzf-dbt into $FZF_DBT_DIR%f"
    mkdir -p $FZF_DBT_DIR
    command curl -L https://raw.githubusercontent.com/Infused-Insight/fzf-dbt/main/src/fzf_dbt.sh > $FZF_DBT_PATH && \
        print -P "%F{green}Installation successful.%f" || \
        print -P "%F{red}The download has failed.%f"
fi

export FZF_DBT_PREVIEW_CMD="cat {}"
export FZF_DBT_HEIGHT=80%
source $FZF_DBT_PATH

# Allow pyenv to ovverride python env
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

FZF_DBT_PATH=~/.fzf-dbt/fzf-dbt.sh
if [[ ! -f /Users/gaetan.pierrejustin/.fzf-dbt/fzf-dbt.sh ]]; then
    FZF_DBT_DIR=/Users/gaetan.pierrejustin/.fzf-dbt
    print -P "%F{green}Installing fzf-dbt into %f"
    mkdir -p 
    command curl -L https://raw.githubusercontent.com/Infused-Insight/fzf-dbt/main/src/fzf_dbt.sh > /Users/gaetan.pierrejustin/.fzf-dbt/fzf-dbt.sh &&         print -P "%F{green}Installation successful.%f" ||         print -P "%F{red}The download has failed.%f"
fi

export FZF_DBT_PREVIEW_CMD="cat {}"
export FZF_DBT_HEIGHT=80%
source /Users/gaetan.pierrejustin/.fzf-dbt/fzf-dbt.sh

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
alias ggovm="$GOPATH/bin/g"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH
