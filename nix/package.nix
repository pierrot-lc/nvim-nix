{
  pkgs,
  lib,
  inputs,
  config ? {
    theme = {
      name = "everforest";
      flavour = "dark";
    };
    version = "nightly";
  },
}:
with lib; let
  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  # Selects the right version of neovim we want to use. The pkgs must provide
  # both `neovim-unwrapped` and `neovim-nightly-unwrapped`.
  neovim-versions = {
    "stable" = pkgs.neovim-unwrapped;
    "nightly" = pkgs.neovim-nightly-unwrapped;
  };
  neovim-unwrapped = neovim-versions.${config.version};

  all-plugins = with pkgs.vimPlugins; [
    (mkNvimPlugin inputs.everforest-nvim "everforest-nvim")
    (mkNvimPlugin inputs.vim-characterize "vim-characterize")
    (mkNvimPlugin inputs.vim-minizinc "vim-minizinc")
    blink-cmp
    catppuccin-nvim
    conform-nvim
    dial-nvim
    fidget-nvim
    gruvbox-nvim
    lazydev-nvim
    mini-nvim
    neorg
    nvim-spider
    nvim-tree-lua
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    nvim-treesitter.withAllGrammars
    oil-nvim
    outline-nvim
    rose-pine
    snacks-nvim
  ];

  # Extra packages for your plugins. I decided not to provide LSPs and other
  # formatters, but you can add theme here. See this debate for more:
  # https://www.reddit.com/r/NixOS/comments/18oai2a/should_lsp_servers_be_in_the_project_flake/
  extraPackages = with pkgs; [
    ripgrep
    # lua-language-server
  ];

  extraLuaPackages = ps:
    with ps; [
      # Ideally the plugin dependencies are managed by nix but it is not the
      # case for all plugins. See here for more:
      # https://github.com/NixOS/nixpkgs/issues/306367.

      # Note that at least right now, `luasnip` and `neorg` come with their
      # dependencies!

      # Nvim-spider's dependency to identify words with UTF-8 accents.
      luautf8
    ];
in {
  # This is the neovim derivation returned by the overlay.
  nvim-nix = mkNeovim {
    inherit neovim-unwrapped;
    plugins = all-plugins;
    inherit extraPackages;
    inherit extraLuaPackages;
    extraLuaConfig = /* lua */ ''
        -- Global theme of the config. The UI plugins use this to set the theme.
        vim.g.theme = "${config.theme.name}"
        vim.opt.background = "${config.theme.flavour}"
      '';
  };

  # This can be symlinked in the devShell's shellHook.
  nvim-luarc-json = mk-luarc-json {
    nvim = neovim-unwrapped;
    plugins = all-plugins;
  };
}
