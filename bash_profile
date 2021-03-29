# Source global definitions
if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.bashrc_arch ]; then
    source ~/.bashrc_arch
fi

if [ -f ~/.bashrc_mac ]; then
    source ~/.bashrc_mac
fi
