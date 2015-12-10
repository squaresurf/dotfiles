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

# My Prompt
PS1="\[$BLUE\]\u\[$RESET\]@\h \[$BLUE\]\w \n\[$GREEN\]\$ \[$RESET\]"
PROMPT_COMMAND="date_prompt; git_prompt; $PROMPT_COMMAND"

# Fix backspace
stty erase '^?'

# Go Lang
export GOPATH="$HOME/code/go"

# C
export OCLINT_HOME="$HOME/bin/oclint-0.7-x86_64-apple-darwin-10"

# User specific aliases and functions

# This is in reverse order.
paths=(
    /usr/texbin
    /opt/X11/bin
    /sbin
    /usr/sbin
    /bin
    /usr/bin
    /usr/local/sbin
    /usr/local/bin
    $HOME/Library/Haskell/bin
    $HOME/bin
    $HOME/bin/terraform
    $HOME/bin/packer
    $OCLINT_HOME/bin
    $HOME/.composer/vendor/bin
    $GOPATH/bin
    $HOME/Library/Android/sdk/platform-tools
    $HOME/code/spartan/gitreflow/bin
)

export PATH="/usr/local/sbin"
for p in ${paths[@]}; do
    if [[ -d $p ]]; then
        export PATH="$p:$PATH";
    fi
done

alias be='bundle exec'
alias grep='grep --color'
alias curlinfo='curl -w "url_effective:\t\t%{url_effective}\nhttp_code:\t\t%{http_code}\nhttp_connect:\t\t%{http_connect}\ntime_total:\t\t%{time_total}\ntime_namelookup:\t%{time_namelookup}\ntime_connect:\t\t%{time_connect}\ntime_pretransfer:\t%{time_pretransfer}\ntime_redirect:\t\t%{time_redirect}\ntime_starttransfer:\t%{time_starttransfer}\nsize_download:\t\t%{size_download}\nsize_upload:\t\t%{size_upload}\nsize_header:\t\t%{size_header}\nsize_request:\t\t%{size_request}\nspeed_download:\t\t%{speed_download}\nspeed_upload:\t\t%{speed_upload}\ncontent_type:\t\t%{content_type}\nnum_connects:\t\t%{num_connects}\nnum_redirects:\t\t%{num_redirects}\nftp_entry_path:\t\t%{ftp_entry_path}\n" -o /dev/null -s'

export EDITOR="vim"
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export HISTCONTROL='ignoreboth:erasedups'

# Mac Aliases
alias ls='ls -G'
alias stat='stat -x'

if [ -f ~/.nova/environment.bash ]; then
    . ~/.nova/environment.bash
fi

# Add the following to your ~/.bashrc or ~/.zshrc
#
# Alternatively, copy/symlink this file and source in your shell.  See `hitch --setup-path`.

# Hitch
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

# chruby
chruby="/usr/local/share/chruby"
if [ -d $chruby ]; then
    source $chruby/chruby.sh
    chruby '2.2.3'
fi

# nova
nova="$HOME/.nova/environment.bash"
if [ -f $nova ]; then
    source $nova
fi

# spartan hop
eval "$(~/code/spartan/hop/bin/hop init -)"

# direnv
eval "$(direnv hook bash)"

# autocompletions
source /usr/local/etc/bash_completion.d/git-completion.bash
