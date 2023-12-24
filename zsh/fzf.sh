## FZF Config

export FZF_DEFAULT_OPTS="
--height=70% 
--preview='([[ -f {} ]] && (bat --style=numbers --theme=Dracula --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' 
--preview-window=right:60%:wrap:hidden
--reverse
--info=hidden
--separator=''
--scrollbar=''
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 
--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 
--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
"

# Dracula color scheme

# Setting fd as the default source for fzf
# export FZF_DEFAULT_COMMAND='fd --type f'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Auto-suggestion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_MANUAL_REBIND
# _zsh_autosuggest_bind_widgets -> to rebind widget
# bindkey '^ ' autosuggest-accept

# fd - Find any directory and cd to selected directory
fd() {
 local dir
 dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d \
      -print 2> /dev/null | fzf +m) &&
 cd "$dir"
}

# FZF DBT
# Need to modify the script to fit my need
# _fzf_complete_pdbt instead of dbt
# change path returned _dbt_fzf_get_project_root
FZF_DBT_PATH=~/.fzf-dbt/fzf-dbt.sh
if [[ ! -f $FZF_DBT_PATH ]]; then
    FZF_DBT_DIR=$(dirname $FZF_DBT_PATH)
    print -P "%F{green}Installing fzf-dbt into $FZF_DBT_DIR%f"
    mkdir -p $FZF_DBT_DIR
    command curl -L https://raw.githubusercontent.com/Infused-Insight/fzf-dbt/main/src/fzf_dbt.sh > $FZF_DBT_PATH && \
        print -P "%F{green}Installation successful.%f" || \
        print -P "%F{red}The download has failed.%f"
fi

export FZF_DBT_HEIGHT=80%
source $FZF_DBT_PATH
export FZF_DBT_PREVIEW_CMD="([[ -f {} ]] && (bat --style=numbers --theme=Dracula --color=always {} || cat {}))"

