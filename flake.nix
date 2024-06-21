{
  description = "Neovim derivation";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add bleeding-edge plugins here.
    # They can be updated with `nix flake update` (make sure to commit the
    # generated flake.lock).
    cmp-vimtex = {
      url = "github:micangl/cmp-vimtex";
      flake = false;
    };
    everforest-nvim = {
      url = "github:neanias/everforest-nvim";
      flake = false;
    };
    gitmoji-nvim = {
      url = "github:Dynge/gitmoji.nvim";
      flake = false;
    };
    nvim-puppeteer = {
      url = "github:chrisgrieser/nvim-puppeteer";
      flake = false;
    };
    telescope-helpgrep-nvim = {
      url = "github:catgoose/telescope-helpgrep.nvim";
      flake = false;
    };
    vim-characterize = {
      url = "github:tpope/vim-characterize";
      flake = false;
    };
    vim-kitty = {
      url = "github:fladson/vim-kitty";
      flake = false;
    };
    vim-minizinc = {
      url = "github:vale1410/vim-minizinc";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    gen-luarc,
    neovim-nightly-overlay,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      # This is the neovim nightly package from the neovim-nightly flake.
      nightly-package = neovim-nightly-overlay.packages.${system}.default;

      # This is where the Neovim derivation is built.
      neovim-overlay = import ./nix/neovim-overlay.nix {
        inherit inputs;
        # Use neovim nightly package.
        neovim-unwrapped = nightly-package;
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          # Import the overlay, so that the final Neovim derivation(s) can be
          # accessed via pkgs.<nvim-pkg>.
          neovim-overlay
          # This adds a function can be used to generate a .luarc.json
          # containing the Neovim API all plugins in the workspace directory.
          # The generated file can be symlinked in the devShell's shellHook.
          gen-luarc.overlays.default
        ];
      };
      shell = pkgs.mkShell {
        name = "nvim-devShell";
        buildInputs = with pkgs; [
          # Tools for Lua and Nix development, useful for editing files in this repo.
          lua-language-server
          nixd
          stylua
          luajitPackages.luacheck
        ];
        shellHook = ''
          ln -fs ${pkgs.nvim-luarc-json} .luarc.json
        '';
      };
    in {
      packages = rec {
        nvim = pkgs.nvim-pkg;
        default = nvim;
      };

      devShells = {
        default = shell;
      };

      # You can add this overlay to your NixOS configuration.
      overlays.default = neovim-overlay;

      # Or you can add this module in your home manager module, allowing you
      # to manually set the configuration.
      nixosModules.default = import ./nix/module.nix {
        inherit inputs;
        neovim-unwrapped = nightly-package;
      };
    });
}
