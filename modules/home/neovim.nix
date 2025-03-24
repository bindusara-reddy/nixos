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
	options = {
          mouse = "a";
          tabstop = 8;
          autoindent = false;
          shiftwidth = 4;
        };
	languages = {
	  enableLSP = true;
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
      };
    };
  };
  programs.neovim.defaultEditor = true;

}
