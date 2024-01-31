{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  pythonWithDebugpy = pkgs.python311.withPackages (ps: with ps; [ debugpy ]);

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs.vimPlugins; [
    # Treesitter.
    nvim-treesitter.withAllGrammars
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    hmts-nvim

    # LSPs.
    nvim-lspconfig
    fidget-nvim
    lsp_signature-nvim
    neodev-nvim

    # Completers.
    nvim-cmp
    cmp-calc
    cmp-nvim-lsp
    cmp-path
    cmp-rg
    (mkNvimPlugin inputs.gitmoji-nvim "gitmoji-nvim")

    # DAP.
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

    # Miscs.
    conform-nvim
    copilot-lua
    dial-nvim
    leap-nvim
    neogit
    nvim-autopairs
    nvim-lint
    nvim-spider
    nvim-surround
    nvim-ufo
    todo-comments-nvim
    toggleterm-nvim
    vim-lastplace
    (mkNvimPlugin inputs.nvim-puppeteer "nvim-puppeteer")
    (mkNvimPlugin inputs.nvim-rooter "nvim-rooter")
    (mkNvimPlugin inputs.outline-nvim "outline-nvim")
    (mkNvimPlugin inputs.vim-characterize "vim-characterize")
    (mkNvimPlugin inputs.vim-kitty "vim-kitty")

    # Mini plugins.
    mini-nvim

    # Neorg.
    neorg

    # Tree.
    nvim-tree-lua

    # Telescope.
    telescope-nvim
    telescope-fzf-native-nvim
    (mkNvimPlugin inputs.telescope-repo-nvim "telescope-repo-nvim")

    # UI.
    alpha-nvim
    dressing-nvim
    gitsigns-nvim
    lualine-nvim
    which-key-nvim
    zen-mode-nvim
    (mkNvimPlugin inputs.nordic-nvim "nordic-nvim")

    # Dependencies.
    diffview-nvim  # For Neogit.
    nvim-web-devicons
    plenary-nvim
  ];

  extraPackages = with pkgs; [
    # Neovim dependency.
    luajit

    # Extra packages for your plugins.
    isort
    jq
    lua-language-server
    marksman
    nil
    nodePackages_latest.bash-language-server
    nodePackages_latest.markdownlint-cli
    nodePackages_latest.nodejs
    perl538Packages.LatexIndent
    proselint
    python311Packages.python-lsp-server
    pythonWithDebugpy
    ripgrep
    ruff-lsp
    shellcheck
    shfmt
    stylua
    yamllint

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
