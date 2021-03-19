# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

export EDITOR="nvim"
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export HISTCONTROL='ignoreboth:erasedups'

RESET='\e[0;0m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'

GIT_PROMPT_PREFIX="[${GREEN}±${RESET}"
GIT_PROMPT_CLEAN="${GREEN}✓${RESET}"
GIT_PROMPT_AHEAD="${CYAN}▴${RESET}"
GIT_PROMPT_BEHIND="${MAGENTA}▾${RESET}"
GIT_PROMPT_STAGED="${GREEN}●${RESET}"
GIT_PROMPT_UNSTAGED="${YELLOW}●${RESET}"
GIT_PROMPT_UNMERGED="${YELLOW}~${RESET}"
GIT_PROMPT_UNTRACKED="${RED}●${RESET}"
GIT_PROMPT_SUFFIX="${RESET}]"

git_branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

git_status() {
  _INDEX=$(command git status --porcelain -b 2> /dev/null)
  _STATUS=""
  if $(echo "$_INDEX" | grep '^[AMRD]. ' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_STAGED"
  fi
  if $(echo "$_INDEX" | grep '^.[MTD] ' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_UNSTAGED"
  fi
  if $(echo "$_INDEX" | grep -E '^\?\? ' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_UNTRACKED"
  fi
  if $(echo "$_INDEX" | grep '^UU ' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_UNMERGED"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    _STATUS="$_STATUS$GIT_PROMPT_STASHED"
  fi
  if $(echo "$_INDEX" | grep '^## .*ahead' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_AHEAD"
  fi
  if $(echo "$_INDEX" | grep '^## .*behind' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_BEHIND"
  fi
  if $(echo "$_INDEX" | grep '^## .*diverged' &> /dev/null); then
    _STATUS="$_STATUS$GIT_PROMPT_DIVERGED"
  fi

  if [[ -n $_STATUS ]]; then
    printf $_STATUS
  fi
}

git_prompt() {
  local _branch=$(git_branch)
  local _status=$(git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$GIT_PROMPT_PREFIX$_branch"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$GIT_PROMPT_SUFFIX"
  fi

  if [[ -n $_result ]]; then
    printf "$_result "
  fi
}

date_prompt() {
  printf "$MAGENTA$(date '+%Y-%m-%d %H:%M:%S')$RESET "
}

exit_status_prompt() {
  last_status=$?
  if [[ $last_status > 0 ]]; then
    printf "${RED}$last_status${RESET} "
  fi
}

# My Prompt
PS1="\[$BLUE\]\u\[$RESET\]@\h \[$BLUE\]\w \n\[$GREEN\]\$ \[$RESET\]"
PROMPT_COMMAND="exit_status_prompt; date_prompt; git_prompt;"

# Go Lang
export GOPATH="$HOME/code/go"

# User specific aliases and functions
alias t='tmux attach'

# Fix gpg-agent
export GPG_TTY=`tty`

export ERL_AFLAGS="-kernel shell_history enabled"

export PGUSER=postgres

export RG_IGNORE='\
  --glob "!**/*.egg-info/*" \
  --glob "!**/*.pyc" \
  --glob "!**/.build/*" \
  --glob "!**/.direnv/*" \
  --glob "!**/.hypothesis/*" \
  --glob "!**/.mypy_cache/*" \
  --glob "!**/.pytest_cache/*" \
  --glob "!**/.serverless/*" \
  --glob "!**/.shadow-cljs/*" \
  --glob "!**/.webpack/*" \
  --glob "!**/_build/*" \
  --glob "!**/_nerves-tmp/*" \
  --glob "!**/compiled/*" \
  --glob "!**/deps/*" \
  --glob "!**/elm-stuff/*" \
  --glob "!**/node_modules/*" \
  --glob "!.direnv/*" \
  --glob "!.elixir_ls/*" \
  --glob "!.git/*" \
  --glob "!.pytest_cache/*" \
  --glob "!.serverless/*" \
  --glob "!.stack-work/*" \
  --glob "!_build/*" \
  --glob "!deps/*" \
  --glob "!dist/*" \
  --glob "!elm-stuff/*" \
  --glob "!flow-typed/*" \
  --glob "!htmlcov/*" \
  --glob "!node_modules/*" \
  --glob "!serverless/lib/*" \
  --glob "!tags" \
  --glob "!tmp/*" \
'
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow $RG_IGNORE"

# Add ssh keys
if [ -n "$(ps ax | rg ssh-agent | rg -v rg)" ]; then
  keys=(
    id_rsa
  )

  for key in ${keys[@]}; do
    keyfile="$HOME/.ssh/$key"
    pub_key=$(cat $HOME/.ssh/$key.pub | awk '{print $2}')
    if [[ -f $keyfile && -z "$(ssh-add -L | grep $pub_key)" ]]; then
      ssh-add $keyfile
    fi
  done
fi

# fasd
if [ -n "$(which fasd)" ]; then
  eval "$(fasd --init auto)"
  alias v='f -e nvim'
fi

# direnv
if [ -n "$(which direnv)" ]; then
  eval "$(direnv hook bash)"
fi

# This is in reverse order.
paths=(
    /usr/local/sbin
    $HOME/Library/Haskell/bin
    /usr/local/go/bin
    $GOPATH/bin
    /usr/local/opt/openssl/bin
    /Library/TeX/texbin
    $HOME/.local/bin # $haskell_local_bin
    $HOME/bin
)

for p in ${paths[@]}; do
    if [[ -d $p ]]; then
        export PATH="$p:$PATH";
    fi
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
