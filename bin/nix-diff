#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash jq
# shellcheck shell=bash

# Usage: nix-diff [revision]
# where revision is the full nixpkgs revision.

set -euo pipefail

declare -A cur

query() {
  nix-env --query --json "$@" | jq -r '.[] | .pname + " " + .version'
}

query_args=()

if [[ $# -eq 1 ]]; then
  query_args=('--file' "https://github.com/NixOS/nixpkgs/archive/$1.tar.gz")
fi

while read -r name version; do
  cur[${name}]=${version}
done < <(query "${query_args[@]}")

ret=0
while read -r name version; do
  if [[ -n ${cur[${name}]:-} ]]; then
    if [[ "${version}" != "${cur[${name}]}" ]]; then
      echo -e "\033[33mM ${name} ${cur[${name}]} ➤ ${version}\033[0m"
      ret=1
    fi
    unset "cur[${name}]"
  else
    echo -e "\033[32mA ${name} ${version}\033[0m"
    ret=1
  fi
done < <(query -af "${HOME}/.dotfiles/env.nix")

for name in "${!cur[@]}"; do
  echo -e "\033[31mD ${name} ${cur[${name}]}\033[0m"
  ret=1
done

if [[ ${ret} -ne 0 ]]; then
  # Disable SC2016 (info): Expressions don't expand in single quotes, use double quotes for that.
  # shellcheck disable=SC2016
  echo 'Run `nix-env -irf ~/.dotfiles/env.nix` to make these changes'
fi

exit "${ret}"

# vim: set sw=2 sts=2 ts=8 et ft=bash:
