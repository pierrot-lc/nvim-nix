# The input is declared outside so that it is possible to define a partial
# activation of the module, parameterized by the inputs.
{
  inputs,
  neovim-unwrapped,
}: {
  pkgs,
  lib,
  config,
  ...
}: let
  package = import ./package.nix {
    inherit pkgs;
    inherit lib;
    inherit inputs;
    inherit neovim-unwrapped;
    config = {
      theme = config.nvim-nix.theme;
      transparentBackground = config.nvim-nix.transparentBackground;
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
      transparentBackground = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to use a transparent background";
      };
    };
  };

  config = lib.mkIf config.nvim-nix.enable {
    home.packages = [package.nvim-nix];
  };
}
