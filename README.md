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

We need to eventually address the following:

* Workflow currently is centered on just darwin (i.e. nixpkgs revision and the script to check it)

## License

[MIT](LICENSE)
