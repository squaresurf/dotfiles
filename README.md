# squaresurf dotfiles

A set of configuration files and scripts.

## Install

This project uses [RCM](https://thoughtbot.github.io/rcm/) to manage the
dotfiles and git to keep them in sync across machines. Here are some [install
instructions](https://github.com/thoughtbot/dotfiles#install) from another
dotfile project.

### Nix

Nix is required for install of all packages.

**Note:** make sure to remove nix install to `/etc/bashrc` as it causes issues.

As long as all the dotfiles in this repo are symlinked you can then run `nix-env -irf env.nix` in the dotfiles
directory to install all the packages.

## Nix Project

Used https://checkoway.net/musings/nix/ to setup first go at Nix. The two links below were what he used.

* How to Learn Nix, Part 22: Setting up a declarative user environment url:https://ianthehenry.com/posts/how-to-learn-nix/declarative-user-environment/
* How to Learn Nix url:https://ianthehenry.com/posts/how-to-learn-nix/

We need to eventually address the following:

* Workflow currently is centered on just darwin (i.e. nixpkgs revision and the script to check it)
* What is the cadence for nix cleanup?

### Other Links

The below were the links I was working through to understand Nix.

* NixOS Search - Packages - neovim url:https://search.nixos.org/packages?channel=25.05&show=neovim&query=neovim
* Learn Nix | Nix & NixOS | Nix & NixOS url:https://nixos.org/learn/
* Packaging existing software with Nix — nix.dev documentation url:https://nix.dev/tutorials/packaging-existing-software
* Operators - Nix 2.28.5 Reference Manual url:https://nix.dev/manual/nix/2.28/language/operators.html
* Built-ins - Nix 2.28.5 Reference Manual url:https://nix.dev/manual/nix/2.28/language/builtins.html
* Declarative shell environments with shell.nix — nix.dev documentation url:https://nix.dev/tutorials/first-steps/declarative-shell#declarative-reproducible-envs
* Preface - Nix Pills url:https://nixos.org/guides/nix-pills/
* Nixpkgs Reference Manual url:https://nixos.org/manual/nixpkgs/stable/#chap-overlays
* Declarative shell environments with shell.nix — nix.dev documentation url:https://nix.dev/tutorials/first-steps/declarative-shell#declarative-reproducible-envs
* Towards reproducibility: pinning Nixpkgs — nix.dev documentation url:https://nix.dev/tutorials/first-steps/towards-reproducibility-pinning-nixpkgs#pinning-nixpkgs
* Setting up Nix on macOS url:https://nixcademy.com/posts/nix-on-macos/
* NixOS Search - Packages - neovim url:https://search.nixos.org/packages?channel=25.05&show=neovim&query=neovim

## License

[MIT](LICENSE)
