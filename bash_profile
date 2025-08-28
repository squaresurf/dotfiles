# Source global definitions
if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# This is in reverse order.
paths=(
    /opt/local/bin # macports hack
    /opt/local/sbin # macports hack
    /opt/homebrew/opt/openjdk/bin
    /usr/local/opt/sqlite/bin
    $HOME/.poetry/bin
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

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  export NIX_PATH="$HOME/.nix-defexpr"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi

