# git switch branch
alias gsb="git branch -a| grep remote |cut -d '/' -f3- | grep -v HEAD | fzf --reverse --header git-branch | xargs git checkout"

function git-clone-bare() {
  url=$1
  basename=${url##*/}
  name=${2:-${basename%.*}}
  mkdir $name
  cd "$name"

  git clone --bare "$url" .bare
  echo "gitdir: ./.bare" > .git
  git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
  git fetch origin
}

function gawt() {
  # Cut before /.bare directory
  gitdirectory=$(git rev-parse --git-dir | cut -d '.' -f1)

  git fetch origin
  mybranch=$(git branch -a | grep remote | cut -d '/' -f3- | fzf --reverse --header git-branch | xargs)
  cd $gitdirectory
  git worktree add --guess-remote $mybranch $mybranch
  cd ./$mybranch
  git branch --set-upstream-to=origin/$mybranch $mybranch
}

function gcwt() {
  # crashing
  # if [[ $@ != "" ]] 
  #   then 
  #     echo "No branch name given"
  #     exit 1
  # fi
  # Cut before /.bare directory
  gitdirectory=$(git rev-parse --git-dir | cut -d '.' -f1)
  cd $gitdirectory
  git worktree add -b $1 $1
  cd ./$1
}

function gswt() {
  # Cut before /.bare directory
  gitdirectory=$(git rev-parse --git-dir | cut -d '.' -f1)
  mydirectory=$(basename -s .git $(git remote get-url origin))
  mybranch=$(git worktree list --porcelain \
    | grep worktree \
    | sed -r "s/.*\/$mydirectory\/(.*)$/\1/" \
    | grep -v bare \
    | fzf)
  cd $gitdirectory$mybranch
}
