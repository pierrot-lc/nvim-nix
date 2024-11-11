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
  # This is the neovim derivation
  # returned by the overlay.
  nvim-nix = package.nvim-nix;

  # This can be symlinked in the devShell's shellHook.
  nvim-luarc-json = package.nvim-luarc-json;
}
