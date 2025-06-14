{ inputs, ... }: {
  
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
	        enable = true;
	        name = "gruvbox";
	        style = "dark";
	      };
	      statusline.lualine.enable = true;
	      telescope.enable = true;
	      autocomplete.nvim-cmp.enable = true;
        lsp.enable = true;
	      options = {
          mouse = "a";
          tabstop = 2;
          autoindent = false;
          shiftwidth = 4;
        };
	      languages = {
	        enableTreesitter = true;
          enableDAP = true;
          enableFormat = true;
          nix.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
	        python.enable = true;
	      };
	      git.enable = true;
        filetree.nvimTree.enable = true;
        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
          setupOpts = {
            enable_winbar = true;
            direction = "float";
          };
        };
      };
    };
  };
  programs.neovim.defaultEditor = true;

}
