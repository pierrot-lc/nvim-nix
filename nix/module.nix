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
      theme = config.nvim-nix.theme;
      version = config.nvim-nix.version;
    };
  };

  validThemes = [
    "catppuccin"
    "everforest"
    "gruvbox"
    "gruvbox-light"
    "kanagawa"
    "melange"
    "melange-light"
    "nord"
    "rose-pine"
    "rose-pine-dawn"
  ];
in {
  options = {
    nvim-nix = {
      enable = lib.mkEnableOption "Enable nvim-nix";

      theme = lib.mkOption {
        type = lib.types.enum validThemes;
        default = "gruvbox";
        description = "The theme to use.";
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
