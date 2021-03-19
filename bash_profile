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

# Output my dotfiles status
printf "dotfiles status: $(cd $HOME/.dotfiles/ && git_prompt)\n"

# asdf start - - - - - - - - - -
## mac setup TODO move this to mac bash
if [ -f ~/.asdf/asdf.sh ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi

## arch setup
if [ -d /opt/asdf-vm ]; then
  source /opt/asdf-vm/asdf.sh
fi
# asdf end - - - - - - - - - -

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi

cargo_env=$HOME/.cargo/env
if [ -f "$cargo_env" ]; then source "$cargo_env"; fi

# kubectl autocompletion
if type kubectl &>/dev/null; then
  source <(kubectl completion bash)
fi

