{inputs, lib, config, ...}: {
  options = {
    nvim-nix.theme = lib.mkOption {
      type = lib.types.str;
      default = "everforest";
      description = "The theme to use for nvim";
    };
  };

  config = {
    neovim-overlay = import ./neovim-overlay.nix {
      inherit inputs;
      config = {
        theme = config.nvim-nix.theme;
      };
   };
  };
}
