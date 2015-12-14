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
