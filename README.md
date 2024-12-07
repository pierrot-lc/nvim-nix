# My Neovim Flake

This is my neovim configuration implemented as a flake. Thanks to the power of
nix and flakes, my whole neovim configuration can be built with a single
command.

Based on the template from
[kickstart-nix.nvim](https://github.com/nix-community/kickstart-nix.nvim). If
you come from this template, please know that I made some slights modifications
a little.

Some of the features:

- LSPs, linters, formatters for Python.
- Use [Neorg](https://github.com/nvim-neorg/neorg) for note taking.
- Optionally use Neovim nightly.

Note: Many LSPs, formatters and others are not packaged in this flake. You have
to provide them yourself. See this [debate](
https://www.reddit.com/r/NixOS/comments/18oai2a/should_lsp_servers_be_in_the_project_flake/)
for more.


## Themes

There are multiple themes available and you can activate a specific theme by
passing the `config.theme` value to the nix package at build time. You can
choose between the following themes:

- [`catppuccin`](https://github.com/catppuccin/nvim)
- [`everforest`](https://github.com/neanias/everforest-nvim)
- [`gruvbox`](https://github.com/ellisonleao/gruvbox.nvim/)
- [`rose-pine`](https://github.com/rose-pine/neovim)

See `./nix/module.nix` for the available option values.

## Installation

### Test Drive

If you have Nix installed (with [flakes](https://nixos.wiki/wiki/Flakes)
enabled), you can test drive this by running:

```console
nix run "github:pierrot-lc/nvim-nix"
```

### NixOS and Home Manager (with flakes)

Add this flake to your NixOS flake inputs.

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nvim-nix = {
      url = "github:pierrot-lc/nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ...
  };

  # ...
}
```

#### Using the Overlay

Overlays are a way to provide additional packages to the list of available
`pkgs`. This flake output such overlay to add our `nvim-nix` derivation to
`pkgs`. Here is a minimal example with home-manager:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-nix = {
      url = "github:pierrot-lc/nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        # We provide our `nvim-nix` package by giving the overlay here.
        inputs.nvim-nix.overlays.${system}.default
      ];
    };
  in {
    homeConfigurations = {
      username = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];
      };
    };
  };
}
```

```nix
# home.nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    nvim-nix # This package will be found thanks to the added overlays.
  ];
}
```

#### Using the Module

This flake also provide a module. It provides an interface to specify options
before building the derivation. You can have a look into `./nix/module.nix` to
see the available options for yourself, along with their default values.

To make this work, you do not have to add this flake overlay but you have to
provide the module. Here is a minimal example:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-nix = {
      url = "github:pierrot-lc/nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    homeConfigurations = {
      username = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          # Add the module here.
          inputs.nvim-nix.hmModules.${system}.default
        ];
      };
    };
  };
}
```

```nix
# home.nix
{pkgs, ...}: {
  nvim-nix = {
    enable = true;
    theme.name = "gruvbox";
    theme.flavour = "light"; # Set vim.opt.background.
    version = "nightly";
  };
}
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

## Initialization Order

This derivation creates an `init.lua` as follows:

1. Add `nvim/lua` to the `runtimepath`.
1. Add the content of `nvim/init.lua`.
1. Add `nvim/*` to the `runtimepath`.
1. Add `nvim/after` to the `runtimepath`.

This means that modules in `nvim/lua` can be `require`d in `init.lua` and
`nvim/*/*.lua`.

Modules in `nvim/plugin/` are sourced automatically, as if they were plugins.
Because they are added to the runtime path at the end of the resulting
`init.lua`, Neovim sources them _after_ loading plugins.

## Bonus: bundle the neovim package into an executable

You can use
[nix-portable](https://github.com/DavHau/nix-portable?tab=readme-ov-file#bundle-programs)
to bundle the derivation into a dependency-free executable.

```nix
nix bundle --bundler github:DavHau/nix-portable -o bundle
```

You still need nix to generate the bundle, but then you can simply pass around
the generated `./bundle/bin/nvim` wherever you want and execute your nvim
package!

Make sure that the target machine has no conflicting nvim configuration. Have a
look at `~/.config/nvim`, `~/.local/share/nvim` and `~/.local/state/nvim`, and
remove those directories if you have any conflict (make sure to make a backup
before if you have important data there).
