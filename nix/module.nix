# The input is declared outside so that it is possible to define a partial
# activation of the module, parameterized by the inputs.
{
  inputs,
  pkgs,
}: {
  lib,
  config,
  ...
}: let
  package = import ./package.nix {
    inherit pkgs;
    inherit lib;
    inherit inputs;
    config = {
      inherit (config.nvim-nix) theme;
      inherit (config.nvim-nix) version;
    };
  };
in {
  options = {
    nvim-nix = {
      enable = lib.mkEnableOption "Enable nvim-nix";

      theme = {
        name = lib.mkOption {
          type = lib.types.enum [
            "catppuccin-macchiato"
            "catppuccin-mocha"
            "everforest"
            "gruvbox"
            "rose-pine"
          ];
          default = "catppuccin-mocha";
          description = "The theme to use.";
        };
        flavour = lib.mkOption {
          type = lib.types.enum ["dark" "light"];
          default = "dark";
          description = "Version of the theme to use";
        };
      };
      version = lib.mkOption {
        type = lib.types.enum ["stable" "nightly"];
        default = "stable";
        description = "The base version of neovim.";
      };
    };
  };

  config = lib.mkIf config.nvim-nix.enable {
    home.packages = [package.nvim-nix];
  };
}
