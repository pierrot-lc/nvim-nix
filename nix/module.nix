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
    };
  };

  config = lib.mkIf config.nvim-nix.enable {
    home.packages = [package.nvim-nix];
  };
}
