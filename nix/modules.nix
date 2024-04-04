{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  package = import ./package.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit inputs;
  };
in {
  options = {
    nvim-nix.theme = lib.mkOption {
      type = lib.types.str;
      default = "everforest";
      description = "The theme to use for nvim";
    };
  };

  config = {
    home.packages = [package.nvim-pkg];
  };
}
