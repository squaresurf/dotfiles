# Source global definitions
if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Output my dotfiles status
printf "dotfiles status: $(cd $HOME/.dotfiles/ && git_prompt)\n"
printf "dotfiles-secret status: $(cd $HOME/.dotfiles-secret/ && git_prompt)\n"

# Load up asdf
if [ -d ~/.asdf ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi

# Load pyenv
if [ -n "$(which pyenv)" ]; then
  eval "$(pyenv init -)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
