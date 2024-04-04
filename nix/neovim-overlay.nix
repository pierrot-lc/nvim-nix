# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev: let
  # This is how the package is built. It uses the the default config.
  package = import ./package.nix {
    pkgs = final;
    inherit inputs;
    lib = final;
  };
in {
  # This is the neovim derivation
  # returned by the overlay.
  nvim-pkg = package.nvim-pkg;

  # This can be symlinked in the devShell's shellHook.
  nvim-luarc-json = package.nvim-luarc-json;
}
