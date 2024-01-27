<!-- markdownlint-disable -->
<br />
<div align="center">
  <a href="https://github.com/mrcjkb/kickstart-nix.nvim">
    <img src="./nvim-nix.svg" alt="kickstart-nix.nvim">
  </a>
  <!-- TODO: -->
  <!-- <p align="center"> -->
    <!-- <br /> -->
    <!-- TODO: -->
    <!-- <a href="./nvim/doc/kickstart-nix.txt"><strong>Explore the docs »</strong></a> -->
    <!-- <br /> -->
    <!-- <br /> -->
    <!-- <a href="https://github.com/mrcjkb/kickstart-nix.nvim/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml">Report Bug</a> -->
    <!-- · -->
    <!-- <a href="https://github.com/mrcjkb/kickstart-nix.nvim/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.yml">Request Feature</a> -->
    <!-- · -->
    <!-- <a href="https://github.com/mrcjkb/kickstart-nix.nvim/discussions/new?category=q-a">Ask Question</a> -->
  <!-- </p> -->
  <p>❄️</p>
  <p>
    <strong>
      A dead simple <a href="https://nixos.org/">Nix</a> flake template repository</br>
      for <a href="https://neovim.io/">Neovim</a> 
    </strong>
  </p>
</div>
<!-- markdownlint-restore -->

[![Neovim][neovim-shield]][neovim-url]
[![Nix][nix-shield]][nix-url]
[![Lua][lua-shield]][lua-url]

[![GPL2 License][license-shield]][license-url]
[![Issues][issues-shield]][issues-url]

![](https://github.com/mrcjkb/kickstart-nix.nvim/assets/12857160/84faa268-82de-4401-acf3-efddc26dd58a)

If Nix and Neovim have one thing in common, it's that many new users don't know where to get started. Most Nix-based Neovim setups assume deep expertise in both realms, abstracting away Neovim's core functionalities as well as the Nix internals used to build a Neovim config. `kickstart-nix.nvim` is different: It's geared for users of all levels, making the migration of Neovim configurations to Nix straightforward.

> [!NOTE]
>
> Similar to [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim),
> this repository is meant to be used by **you** to begin your
> **Nix**/Neovim journey; remove the things you don't use and add what you miss.

## Quick Links

- [Test drive](#test-drive)
- [Usage](#usage)
- [Installation](#installation)
- [Philosophy](#philosophy)
- [Design](#design)
- [Pre-configured plugins](#pre-configured-plugins)
- [Syncing updates](#syncing-updates)
- [Alternative / similar projects](#alternative--similar-projects)

## Test drive

If you have Nix installed (with [flakes](https://nixos.wiki/wiki/Flakes) enabled),
you can test drive this by running:

```console
nix run "github:mrcjkb/kickstart-nix.nvim"
```

## Usage

1. Click on [Use this template](https://github.com/mrcjkb/kickstart-nix.nvim/generate)
to start a repo based on this template. **Do _not_ fork it**.
1. Add/remove plugins to/from the [Neovim overlay](./nix/neovim-overlay.nix).
1. Add/remove plugin configs to/from the `nvim/plugin` directory.
1. Modify as you wish (you will probably want to add a color theme, ...).
   See: [Design](#design).

## Installation

### NixOS (with flakes)

1. Add your flake to you NixOS flake inputs.
1. Add the overlay provided by this flake.

```nix
nixpkgs.overlays = [
    # replace <kickstart-nix-nvim> with the name you chose
    <kickstart-nix-nvim>.overlays.default
];
```

You can then add the overlay's output(s) to the `systemPackages`:

```nix
environment.systemPackages = with pkgs; [
    nvim-pkg # The default package added by the overlay
];
```

### Non-NixOS

With Nix installed (flakes enabled), from the repo root:

```console
nix profile install .#nvim
```

## Philosophy

- KISS principle with sane defaults.
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

## Design

Directory structure:

```sh
── flake.nix
── nvim # Neovim configs (lua), equivalent to ~/.config/nvim
── nix # Nix configs
```

### Neovim configs

- Set options in `init.lua`.
- Source autocommands, user commands, keymaps,
  and configure plugins in individual files within the `plugin` directory.
- Filetype-specific scripts (e.g. start LSP clients) in the `ftplugin` directory.
- Library modules in the `lua/user` directory.

Directory structure:

```sh
── nvim
  ├── ftplugin # Sourced when opening a file type
  │  └── <filetype>.lua
  ├── init.lua # Always sourced
  ├── lua # Shared library modules
  │  └── user
  │     └── <lib>.lua
  ├── plugin # Automatically sourced at startup
  │  ├── autocommands.lua
  │  ├── commands.lua
  │  ├── keymaps.lua
  │  ├── plugins.lua # Plugins that require a `setup` call
  │  └── <plugin-config>.lua # Plugin configurations
  └── after # Empty in this template
     ├── plugin # Sourced at the very end of startup (rarely needed)
     └── ftplugin # Sourced when opening a filetype, after sourcing ftplugin scripts
```

> [!IMPORTANT]
>
> - Configuration variables (e.g. `vim.g.<plugin_config>`) should go in `nvim/init.lua`
>   or a module that is `require`d in `init.lua`.
> - Configurations for plugins that require explicit initialization
>   (e.g. via a call to a `setup()` function) should go in `nvim/plugin/<plugin>.lua`
>   or `nvim/plugin/plugins.lua`.
> - See [Initialization order](#initialization-order) for details.

### Nix

You can declare Neovim derivations in `nix/neovim-overlay.nix`.

There are two ways to add plugins:

- The traditional way, using `nixpkgs` as the source.
- By adding plugins as flake inputs (if you like living on the bleeding-edge).
  Plugins added as flake inputs must be built in `nix/plugin-overlay.nix`.

Directory structure:

```sh
── flake.nix
── nix
  ├── mkNeovim.nix # Function for creating the Neovim derivation
  └── neovim-overlay.nix # Overlay that adds Neovim derivation
```

### Initialization order

This derivation creates an `init.lua` as follows:

1. Add `nvim/lua` to the `runtimepath`.
1. Add the content of `nvim/init.lua`.
1. Add `nvim/*` to the `runtimepath`.
1. Add `nvim/after` to the `runtimepath`.

This means that modules in `nvim/lua` can be `require`d in `init.lua` and `nvim/*/*.lua`.

Modules in `nvim/plugin/` are sourced automatically, as if they were plugins.
Because they are added to the runtime path at the end of the resulting `init.lua`,
Neovim sources them _after_ loading plugins.

## Pre-configured plugins

This configuration comes with [a few plugins pre-configured](./nix/neovim-overlay.nix).

You can add or remove plugins by

- Adding/Removing them in the [Nix list](./nix/neovim-overlay.nix).
- Adding/Removing the config in `nvim/plugin/<plugin>.lua`.

## Syncing updates

If you have used this template and would like to fetch updates
that were added later...

Add this template as a remote:

```console
git remote add upstream git@github.com:mrcjkb/kickstart-nix.nvim.git
```

Fetch and merge changes:

```console
git fetch upstream
git merge upstream/main --allow-unrelated-histories
```

## Alternative / similar projects

- [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim):
  Single-file Neovim configuration template with a similar philosophy to this project.
  Does not use Nix to manage plugins.
- [`neovim-flake`](https://github.com/jordanisaacs/neovim-flake):
  Configured using a Nix module DSL.
- [`NixVim`](https://github.com/nix-community/nixvim):
  A Neovim distribution configured using a NixOS module.
- [`nixCats-nvim`](https://github.com/BirdeeHub/nixCats-nvim):
  A project that organises plugins into categories.
  It also separates lua and nix configuration.
- [`lazy-nix-helper.nvim`](https://github.com/b-src/lazy-nix-helper.nvim):
  For lazy.nvim users who would like to manage plugins with Nix,
  but load them with lazy.nvim.

> [!NOTE]
>
> When comparing with projects in the "non-Nix world", this
> repository would be more comparable to `kickstart.nvim` (hence the name),
> while the philosophies of `neovim-flake` and `NixVim` are more in line with
> a Neovim distribution like [`LunarVim`](https://www.lunarvim.org/)
> or [`LazyVim`](https://www.lazyvim.org/)
> (though they are more minimal by default).

<!-- MARKDOWN LINKS & IMAGES -->
[neovim-shield]: https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white
[neovim-url]: https://neovim.io/
[nix-shield]: https://img.shields.io/badge/nix-0175C2?style=for-the-badge&logo=NixOS&logoColor=white
[nix-url]: https://nixos.org/
[lua-shield]: https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white
[lua-url]: https://www.lua.org/
[license-shield]: https://img.shields.io/github/license/mrcjkb/kickstart-nix.nvim.svg?style=for-the-badge
[license-url]: https://github.com/mrcjkb/kickstart-nix.nvim/blob/master/LICENSE
[issues-shield]: https://img.shields.io/github/issues/mrcjkb/kickstart-nix.nvim.svg?style=for-the-badge
[issues-url]: https://github.com/mrcjkb/kickstart-nix.nvim/issues
[license-shield]: https://img.shields.io/github/license/mrcjkb/kickstart-nix.nvim.svg?style=for-the-badge
[license-url]: https://github.com/mrcjkb/kickstart-nix.nvim/blob/master/LICENSE
