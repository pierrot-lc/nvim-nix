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
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add bleeding-edge plugins here.
    # They can be updated with `nix flake update` (make sure to commit the generated flake.lock)
    cmp-vimtex = {
      url = "github:micangl/cmp-vimtex";
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
    nvim-rooter = {
      url = "github:notjedi/nvim-rooter.lua";
      flake = false;
    };
    outline-nvim = {
      url = "github:hedyhli/outline.nvim";
      flake = false;
    };
    telescope-repo-nvim = {
      url = "github:cljoly/telescope-repo.nvim";
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
    neovim-nightly,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # This is where the Neovim derivation is built.
    neovim-overlay = import ./nix/neovim-overlay.nix {inherit inputs;};
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          # Import the overlay, so that the final Neovim derivation(s) can be accessed via pkgs.<nvim-pkg>.
          neovim-overlay
          # This adds a function can be used to generate a .luarc.json
          # containing the Neovim API all plugins in the workspace directory.
          # The generated file can be symlinked in the devShell's shellHook.
          gen-luarc.overlays.default
          # Add the nightly package as an installable available wrapper.
          neovim-nightly.overlay
        ];
      };
      shell = pkgs.mkShell {
        name = "nvim-devShell";
        buildInputs = with pkgs; [
          # Tools for Lua and Nix development, useful for editing files in this repo.
          lua-language-server
          nil
          stylua
          luajitPackages.luacheck
        ];
      };
    in {
      packages = rec {
        default = nvim;
        nvim = pkgs.nvim-pkg;
      };
      devShells = {
        default = shell;
      };
    })
    // {
      # You can add this overlay to your NixOS configuration
      overlays.default = neovim-overlay;
    };
}
