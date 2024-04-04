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
    # Add the package as an available package in `pkgs`.
    pkgs = pkgs // {nvim-nix = package.nvim-pkg;};
  };
}
