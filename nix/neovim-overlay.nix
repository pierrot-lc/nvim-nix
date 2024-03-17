{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  pythonWithDebugpy = pkgs.python311.withPackages (ps: with ps; [debugpy]);

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

    # DAPs.
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    {
      plugin = nvim-dap-python;
      config = ''
        lua << EOF
          require('dap-python').setup('${pythonWithDebugpy}/bin/python')
        EOF
      '';
      type = "lua";
    }

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
    (mkNvimPlugin inputs.outline-nvim "outline-nvim")

    # Miscs.
    copilot-lua
    dial-nvim
    nvim-biscuits
    nvim-spider
    todo-comments-nvim
    toggleterm-nvim
    undotree
    (mkNvimPlugin inputs.nvim-puppeteer "nvim-puppeteer")
    (mkNvimPlugin inputs.nvim-rooter "nvim-rooter")
    (mkNvimPlugin inputs.vim-characterize "vim-characterize")
    (mkNvimPlugin inputs.vim-kitty "vim-kitty")
    (mkNvimPlugin inputs.vim-minizinc "vim-minizinc")

    # Mini plugins.
    mini-nvim

    # Neorg.
    neorg
    diffview-nvim

    # Pairs.
    nvim-autopairs
    nvim-surround

    # Pencil.
    vim-pencil

    # Snippets.
    luasnip

    # Tree.
    nvim-tree-lua

    # Treesitter.
    nvim-treesitter.withAllGrammars
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    hmts-nvim

    # Telescope.
    telescope-nvim
    telescope-fzf-native-nvim
    (mkNvimPlugin inputs.telescope-repo-nvim "telescope-repo-nvim")

    # Tex.
    vimtex
    (mkNvimPlugin inputs.cmp-vimtex "cmp-vimtex")

    # UI.
    alpha-nvim
    dressing-nvim
    kanagawa-nvim
    lualine-nvim
    zen-mode-nvim

    # Which-key.
    which-key-nvim

    # General dependencies.
    nvim-web-devicons
    plenary-nvim
  ];

  # Extra packages for your plugins.
  extraPackages = with pkgs; [
    nodePackages_latest.nodejs
    ripgrep

    # DAPs.
    pythonWithDebugpy

    # Formatters.
    alejandra
    bibtex-tidy
    isort
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
    fswatch  # See https://github.com/neovim/neovim/pull/27347. 
    lua-language-server
    marksman
    nil
    nodePackages_latest.bash-language-server
    python311Packages.python-lsp-server
    ruff-lsp
    texlab

    # LuaSnip dependencies.
    luajitPackages.jsregexp

    # Telescope repo dependencies.
    bat
    fd
    glow
    mlocate
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
