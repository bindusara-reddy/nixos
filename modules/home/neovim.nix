{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];
  programs.nvf = {
    enable = true;
    # nvf's own knob — sets EDITOR/VISUAL to nvim for the whole session
    # (programs.neovim.defaultEditor is a no-op here: that module is disabled)
    defaultEditor = true;
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

        # pops up a cheat-sheet of keybinds when you pause mid-chord
        binds.whichKey.enable = true;
        autopairs.nvim-autopairs.enable = true;

        options = {
          mouse = "a";
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          ignorecase = true;
          smartcase = true;
          scrolloff = 8;
          undofile = true; # undo survives closing the file
        };

        # yank/paste goes through the GNOME Wayland clipboard (wl-clipboard)
        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };
        languages = {
          enableTreesitter = true;
          enableDAP = true;
          enableFormat = true;
          nix.enable = true;
          rust.enable = true;
          python.enable = true;
          markdown.enable = true;
          bash.enable = true;
          clang.enable = true;
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
}
