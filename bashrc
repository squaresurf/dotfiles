# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

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

# Fix backspace
stty erase '^?'

# Fix tmux <c-h>
export TERMINFO="$HOME/.terminfo"

# Fix gpg-agent
export GPG_TTY=`tty`

# Go Lang
export GOPATH="$HOME/code/go"

# C
export OCLINT_HOME="$HOME/bin/oclint-0.7-x86_64-apple-darwin-10"

# User specific aliases and functions
alias la='ls -al'
alias be='bundle exec'
alias grep='grep --color'
alias curlinfo='curl -w "url_effective:\t\t%{url_effective}\nhttp_code:\t\t%{http_code}\nhttp_connect:\t\t%{http_connect}\ntime_total:\t\t%{time_total}\ntime_namelookup:\t%{time_namelookup}\ntime_connect:\t\t%{time_connect}\ntime_pretransfer:\t%{time_pretransfer}\ntime_redirect:\t\t%{time_redirect}\ntime_starttransfer:\t%{time_starttransfer}\nsize_download:\t\t%{size_download}\nsize_upload:\t\t%{size_upload}\nsize_header:\t\t%{size_header}\nsize_request:\t\t%{size_request}\nspeed_download:\t\t%{speed_download}\nspeed_upload:\t\t%{speed_upload}\ncontent_type:\t\t%{content_type}\nnum_connects:\t\t%{num_connects}\nnum_redirects:\t\t%{num_redirects}\nftp_entry_path:\t\t%{ftp_entry_path}\n" -o /dev/null -s'

export EDITOR="nvim"
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export HISTCONTROL='ignoreboth:erasedups'

export ERL_AFLAGS="-kernel shell_history enabled"

export PGUSER=postgres

export RG_IGNORE='\
  --glob "!.git/*" \
  --glob "!_build/*" \
  --glob "!client/node_modules/*" \
  --glob "!deps/*" \
  --glob "!dist/*" \
  --glob "!doc/*" \
  --glob "!elm-stuff/*" \
  --glob "!flow-typed/*" \
  --glob "!node_modules/*" \
  --glob "!tags" \
  --glob "!tmp/*" \
'
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow $RG_IGNORE"

# Add ssh keys
keys=(
  $HOME/.ssh/id_rsa
)

for key in ${keys[@]}; do
  if [[ -f $key && -z "$(ssh-add -l | grep $key)" ]]; then
    ssh-add $key
  fi
done

# Mac Aliases
if [[ "$(uname -s)" == "Darwin" ]]; then
  alias ls='ls -G'
  alias stat='stat -x'
fi

# nova
nova="$HOME/.nova/environment.bash"
if [ -f $nova ]; then
    source $nova
fi

# fasd
eval "$(fasd --init auto)"
alias v='f -e nvim'

# very hop
eval "$(~/code/very/hop/bin/hop init -)"

# direnv
eval "$(direnv hook bash)"

# autocompletions
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# stack autocompletion
if [ -n "$(which stack)" ]; then
  eval "$(stack --bash-completion-script stack)"
fi

haskell_local_bin=$(stack path --local-bin)

# This is in reverse order.
paths=(
    /usr/local/sbin
    $HOME/Library/Haskell/bin
    $OCLINT_HOME/bin
    /usr/local/go/bin
    $GOPATH/bin
    /usr/local/opt/openssl/bin
    /Library/TeX/texbin
    $haskell_local_bin
    $HOME/bin
)

for p in ${paths[@]}; do
    if [[ -d $p ]]; then
        export PATH="$p:$PATH";
    fi
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
