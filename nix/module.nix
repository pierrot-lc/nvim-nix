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
in {
  options = {
    nvim-nix = {
      enable = lib.mkEnableOption "Enable nvim-nix";
      theme = lib.mkOption {
        type = lib.types.str;
        default = "everforest";
        description = "The theme to use for nvim, choose from the list of themes in the README.md";
      };
      transparentBackground = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to use a transparent background";
      };
    };
  };

  config = lib.mkIf config.nvim-nix.enable {
    home.packages = [package.nvim-pkg];
  };
}
