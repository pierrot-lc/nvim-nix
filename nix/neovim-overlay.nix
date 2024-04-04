# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{
  inputs,
  config,
}: final: prev: let
  pkgs = final;

  package = import ./package.nix {
    inherit pkgs;
    inherit config;
    inherit inputs;
    lib = final;
  };
in {
  # This is the neovim derivation
  # returned by the overlay.
  nvim-pkg = package.nvim-pkg;

  # This can be symlinked in the devShell's shellHook.
  nvim-luarc-json = package.nvim-luarc-json;

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
}
