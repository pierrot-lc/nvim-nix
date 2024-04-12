{
  pkgs,
  lib,
  config ? {
    theme = "gruvbox";
  },
  inputs,
}:
with lib; let
  # The theme is selected based on the "config.theme" value.
  # This set serves as a switch statement, where the vim command is called
  # to load the theme.
  themeCommands = {
    "catppuccin" = "colorscheme catppuccin-frappe";
    "everforest" = "colorscheme everforest";
    "gruvbox" = "colorscheme gruvbox";
    "kanagawa" = "colorscheme kanagawa-dragon";
  };

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs.vimPlugins; [
    # Completers.
    nvim-cmp
    cmp-calc
    cmp-nvim-lsp
    cmp-path
    cmp-rg
    cmp_luasnip
    (mkNvimPlugin inputs.gitmoji-nvim "gitmoji-nvim")

    # Folds.
    nvim-ufo

    # Formatters.
    conform-nvim

    # Gits.
    gitsigns-nvim
    vim-fugitive

    # Linters.
    nvim-lint

    # LSPs.
    nvim-lspconfig
    fidget-nvim
    lsp_signature-nvim
    neodev-nvim
    outline-nvim

    # Miscs.
    copilot-lua
    dial-nvim
    nvim-autopairs
    nvim-spider
    todo-comments-nvim
    toggleterm-nvim
    (mkNvimPlugin inputs.nvim-puppeteer "nvim-puppeteer")
    (mkNvimPlugin inputs.nvim-rooter "nvim-rooter")
    (mkNvimPlugin inputs.vim-characterize "vim-characterize")
    (mkNvimPlugin inputs.vim-kitty "vim-kitty")

    # Minizinc.
    (mkNvimPlugin inputs.vim-minizinc "vim-minizinc")

    # Mini plugins.
    mini-nvim

    # Neorg.
    neorg
    diffview-nvim
    nui-nvim
    nvim-nio
    (mkNvimPlugin inputs.lua-utils-nvim "lua-utils-nvim")
    (mkNvimPlugin inputs.pathlib-nvim "pathlib-nvim")

    # Snippets.
    luasnip

    # Telescope.
    telescope-nvim
    telescope-fzf-native-nvim
    (mkNvimPlugin inputs.telescope-helpgrep-nvim "telescope-helpgrep-nvim")

    # Tex.
    vimtex
    (mkNvimPlugin inputs.cmp-vimtex "cmp-vimtex")

    # Themes.
    catppuccin-nvim
    gruvbox-nvim
    kanagawa-nvim
    (mkNvimPlugin inputs.everforest-nvim "everforest-nvim")

    # Tree.
    nvim-tree-lua

    # Treesitter.
    nvim-treesitter.withAllGrammars
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    hmts-nvim

    # UI.
    alpha-nvim
    dressing-nvim
    lualine-nvim
    which-key-nvim
    zen-mode-nvim

    # General dependencies.
    nvim-web-devicons
    plenary-nvim
  ];

  # Extra packages for your plugins.
  extraPackages = with pkgs; [
    nodePackages_latest.nodejs
    ripgrep

    # Formatters.
    alejandra
    bibtex-tidy
    jq
    just
    shfmt
    stylua

    # Linters.
    nodePackages_latest.markdownlint-cli
    proselint
    shellcheck
    yamllint

    # LSPs.
    fswatch # See https://github.com/neovim/neovim/pull/27347.
    lua-language-server
    marksman
    nil
    nodePackages_latest.bash-language-server
    python311Packages.python-lsp-server
    ruff-lsp
    texlab
  ];

  extraLuaPackages = ps:
    with ps; [
      # LuaSnip dependency.
      jsregexp
    ];
in {
  # This is the neovim derivation
  # returned by the overlay.
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    inherit extraLuaPackages;
    extraLuaConfig = ''
      -- Select the theme only after the config have been loaded.
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("nvim_nix", { clear = true }),
        desc = "Load theme",
        command = '${themeCommands.${config.theme}}',
      })
    '';
  };

  # This can be symlinked in the devShell's shellHook.
  nvim-luarc-json = final.mk-luarc-json {
    nvim = final.neovim-nightly;
    plugins = all-plugins;
    neodev-types = "nightly";
  };
}
