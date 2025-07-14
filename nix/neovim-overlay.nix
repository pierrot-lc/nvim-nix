# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{
  inputs,
  pkgs,
}: final: prev: let
  # This is how the package is built. It uses the the default config.
  package = import ./package.nix {
    pkgs = pkgs;
    lib = pkgs;
    inherit inputs;
  };
in {
  nvim-nix = package.nvim-nix;
  nvim-dev = package.nvim-dev;
  nvim-luarc-json = package.nvim-luarc-json;
}
