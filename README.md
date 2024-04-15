# My Neovim flake

This is my neovim configuration implemented as a flake. Thanks to the power of
nix and flakes, my whole neovim configuration can be built with a single
command.

Based on the template from [kickstart-nix.nvim](https://github.com/mrcjkb/kickstart-nix.nvim).

Some of the features:

- Neovim nightly.
- LSPs, linters, formatters for Python.
- Use [Neorg](https://github.com/nvim-neorg/neorg) for note taking.

Note: `latexindent` and `latexmk` for latex are not provided in this flake
as they are usually downloaded along with the `texliveFull` package.

## Installation

### Test drive

If you have Nix installed (with [flakes](https://nixos.wiki/wiki/Flakes) enabled),
you can test drive this by running:

```console
nix run "github:pierrot-lc/nvim-nix"
```

### NixOS and Home Manager (with flakes)

1. Add this flake and the neovim-nightly flake to your NixOS flake inputs.

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nvim-nix = {
      url = "github:pierrot-lc/nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ...
  };

  # ...
}
```

2. Add the overlays.

```nix
nixpkgs.overlays = [
  inputs.nvim-nix.overlays.default
  inputs.neovim-nightly.overlay
];
```

You can then add the overlay's output(s) to the `systemPackages`:

```nix
environment.systemPackages = with pkgs; [
    nvim-pkg
];
```

Or with home manager:

```nix
home.packages = with pkgs; [
    nvim-pkg
];
```

### Non-NixOS

With Nix installed (flakes enabled), from the repo root:

```console
nix profile install .#nvim
```

## Philosophy

- Manage plugins + external dependencies using Nix
  (managing plugins shouldn't be the responsibility of a plugin).
- Configuration entirely in Lua[^1] (Vimscript is also possible).
  This makes it easy to migrate from non-nix dotfiles.
- Usable on any device with Neovim and Nix installed.
- Ability to create multiple derivations with different sets of plugins.
- Use either nixpkgs or flake inputs as plugin source.
- Use Neovim's built-in loading mechanisms.
  - See [`:h initializaion`](https://neovim.io/doc/user/starting.html#initialization)
    and [`:h runtimepath`](https://neovim.io/doc/user/options.html#'runtimepath').
- Use Neovim's built-in LSP client.

[^1]: The absence of a Nix module DSL for Neovim configuration is deliberate.
      If you were to copy the `nvim` directory to `$XDG_CONFIG_HOME`,
      and install the plugins, it would work out of the box.

## Initialization order

This derivation creates an `init.lua` as follows:

1. Add `nvim/lua` to the `runtimepath`.
1. Add the content of `nvim/init.lua`.
1. Add `nvim/*` to the `runtimepath`.
1. Add `nvim/after` to the `runtimepath`.

This means that modules in `nvim/lua` can be `require`d in `init.lua` and `nvim/*/*.lua`.

Modules in `nvim/plugin/` are sourced automatically, as if they were plugins.
Because they are added to the runtime path at the end of the resulting `init.lua`,
Neovim sources them _after_ loading plugins.

## Syncing updates

To update the flake from the original kickstart-nix template,
add the template as a remote:

```console
git remote add upstream git@github.com:mrcjkb/kickstart-nix.nvim.git
```

Fetch and merge changes:

```console
git fetch upstream
git merge upstream/main --allow-unrelated-histories
```
